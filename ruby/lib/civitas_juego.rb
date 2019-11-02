require_relative('jugador')
require_relative('estados_juego')
require_relative('operaciones_juego')
require_relative('gestor_estados')
require_relative('mazo_sorpresas')
require_relative('dado')
require_relative('tablero')
require_relative('sorpresa')
require_relative('tipo_sorpresa')

module Civitas
    class CivitasJuego
        def initialize(nombres)
            @jugadores = []

            nombres.each {
                |n| @jugadores.push(Jugador.new(n))
            }
            

            @gestorEstados = GestorEstados.new
            @gestorEstados.estadoInicial

            @indiceJugadorActual = Dado.instance.quienEmpieza(nombres.size)
            
            @mazo
            inicializaMazoSorpresas(@tablero)

            @tablero
            inicializaTablero(@mazo)

            @estado = EstadosJuego::INICIO_TURNO
        end

        def toString
            string=" Indice actual: "+@indiceJugadorActual.to_s
            string+=" Estado: "+@estado.to_s
            string+=" Mazo: "+@mazo.toString
            string+=" Tablero: "+@tablero.toString

            #Ver toString de las demás clases

            return string
        end

        def actualizarInfo
            puts "Jugador: " + @jugadores[actual].toString

            if (algunoEnBancarrota())
                ranking
            end
        end
        
        private
        def inicializaTablero(mazo)
            @tablero = Tablero.new(10)

            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Calle 1", 120, 1.1, 20000, 40000, 20000)))
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Calle 2", 120, 1.1, 20000, 40000, 20000)))
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Calle 3", 120, 1.1, 20000, 40000, 20000)))
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Calle 4", 120, 1.1, 20000, 40000, 20000)))
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Calle 5", 120, 1.1, 20000, 40000, 20000)))
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Calle 6", 120, 1.1, 20000, 40000, 20000)))
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Calle 7", 120, 1.1, 20000, 40000, 20000)))
            @tablero.añadeCasilla(Casilla.newImpuesto(200.5, "Peaje1"))
            @tablero.añadeCasilla(Casilla.newImpuesto(200.5, "Peaje2")) 
            @tablero.añadeCasilla(Casilla.newImpuesto(200.5, "Peaje3")) 
            @tablero.añadeCasilla(Casilla.newDescanso("Camping")) 
            @tablero.añadeCasilla(Casilla.newDescanso("Burger King")) 
            @tablero.añadeJuez 
            @tablero.añadeCasilla(Casilla.newSorpresa(mazo, "Sorpresa1")) 
            @tablero.añadeCasilla(Casilla.newSorpresa(mazo, "Sorpresa2")) 
            @tablero.añadeCasilla(Casilla.newSorpresa(mazo, "Sorpresa3")) 
            @tablero.añadeCasilla(Casilla.newSorpresa(mazo, "Sorpresa4")) 
            @tablero.añadeCasilla(Casilla.newSorpresa(mazo, "Sorpresa5")) 
        end
        
        def inicializaMazoSorpresas(tablero)
            @mazo = MazoSorpresas.new

            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::IRCARCEL, tablero:tablero))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::SALIRCARCEL, tablero:tablero))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::IRCASILLA, tablero:tablero, valor:3, texto:"Ir a casilla"))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::IRCASILLA, tablero:tablero, valor:6, texto:"Ir a casilla"))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::IRCASILLA, tablero:tablero, valor:10, texto:"Ir a casilla"))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::PORCASAHOTEL, tablero:tablero, valor:10, texto:"Casa o hotel"))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::PORJUGADOR, tablero:tablero, valor:10, texto:"Jugador"))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::PAGARCOBRAR, tablero:tablero, valor:10, texto:"Pagar cobrar"))
        end

        public
        def contabilizarPasosPorSalida(jugadorActual)
            while @tablero.getPorSalida > 0 do
                jugadorActual.pasaPorSalida
            end
        end

        def pasarTurno
            @indiceJugadorActual = (@indiceJugadorActual + 1) % @jugadores.length
        end

        def siguientePasoCompletado(operacion)
            @estado = @gestorEstados.siguienteEstado(getJugadorActual(), @estado, operacion)
        end

        def siguientePaso
            jugadorActual = @jugadores[@indiceJugadorActual]
            operacion = @gestorEstados.operacionesPermitidas(jugadorActual, @estado)

            if operacion == Operaciones_juego::PASAR_TURNO
                pasarTurno
                siguientePasoCompletado(operacion)
            elsif operacion == Operaciones_juego::AVANZAR 
               avanzaJugador
               siguientePasoCompletado(operacion)  
            end

            return operacion

        end

        def getCasillaActual
            return @tablero.getCasilla(getJugadorActual().numCasillaActual)
        end
        
        def getJugadorActual
            return @jugadores[@indiceJugadorActual]
        end
        
        def construirCasa
            @jugadores[@indiceJugadorActual].construirCasa(ip)
        end

        def construirHotel
            @jugadores[@indiceJugadorActual].construirHotel(ip)
        end
        
        def avanzaJugador
            jugadorActual = getJugadorActual
            posicionActual = getJugadorActual.numCasillaActual
            tirada = Dado.instance().tirar

            posicionNueva = @tablero.nuevaPosicion(posicionActual, tirada)

            casilla = @tablero.getCasilla(posicionNueva)

            contabilizarPasosPorSalida(jugadorActual)

            jugadorActual.moverACasilla(posicionNueva)

            casilla.recibeJugador(@indiceJugadorActual, @jugadores)
            
            contabilizarPasosPorSalida(jugadorActual)
        end

        def infoJugadorTexto
            jugadorActual = @jugadores[@indiceJugadorActual]
            puts "Jugador: #[jugadorActual.toString]"
        end

        def cancelarHipoteca(ip)
            @jugadores[@indiceJugadorActual].cancelarHipoteca(ip)            
        end

        def comprar
            jugadorActual = @jugadores[@indiceJugadorActual]
            numCasillaActual = jugadorActual.getNumCasillaActual
            casilla = @tablero.getCasilla(numCasillaActual)
            titulo = casilla.getTituloPropiedad
            return jugadorActual.comprar(titulo)
        end

        def finalDelJuego
            for jugador in @jugadores do
                if jugador.enBancarrota
                    return true
                end
            end
            return false
        end

        def algunoEnBancarrota
            finalDelJuego
        end

        def vender(ip)
            @jugadores[@indiceJugadorActual].vender(ip)
        end

        def hipotecar(ip)
            @jugadores[@indiceJugadorActual].hipotecar(ip)
        end

        def salirCarcelPagando
            @jugadores[@indiceJugadorActual].salirCarcelPagando(ip)
        end

        def salirCarcelTirando
            @jugadores[@indiceJugadorActual].salirCarcelTirando(ip)
        end

        def ranking
        end    

    end
end