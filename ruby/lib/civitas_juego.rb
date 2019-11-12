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
            for i in 0...nombres.size do
                @jugadores << Jugador.new(nombres[i])
            end
            
            @gestorEstados = GestorEstados.new
            @estado = @gestorEstados.estadoInicial
            @indiceJugadorActual = Dado.instance.quienEmpieza(nombres.length)
            @mazo = MazoSorpresas.new(true)
            
            inicializaTablero(@mazo)
            inicializaMazoSorpresas(@tablero)

        end

        def toString
            string=" Indice actual: "+@indiceJugadorActual.to_s
            string+=" Estado: "+@estado.to_s
            string+=" Mazo: "+@mazo.toString
            string+=" Tablero: "+@tablero.toString

            return string
        end

        def actualizarInfo
            puts infoJugadorTexto

            if (algunoEnBancarrota())
                ranking
            end
        end
        
        private
        def inicializaTablero(mazo)
            @tablero = Tablero.new(4)

            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Ladrón", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(Casilla.newSorpresa(@mazo, "Suerte")) 
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Ladrón 2", 1.5, -0.5, 30.0, 60.0, 30.0)))
            
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Ladrón 3", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Ladrón 4", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(Casilla.newSorpresa(@mazo, "Suerte")) 
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Ladrón 5", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(Casilla.newDescanso("Burger King")) 
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Ladrón 6", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Ladrón 7", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(Casilla.newSorpresa(@mazo, "Sorpresa3")) 
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Ladrón 8", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeJuez
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Ladrón 9", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Ladrón 10", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(Casilla.newImpuesto(200.5, "Peaje3")) 
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Ladrón 11", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(Casilla.newCalle(TituloPropiedad.new("Ladrón 12", 1.5, -0.5, 30.0, 60.0, 30.0)))
        end
        
        def inicializaMazoSorpresas(tablero)

            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::IRCARCEL, valor:@tablero.getCarcel, tablero:@tablero))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::SALIRCARCEL, mazo: @mazo))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::IRCASILLA, tablero:@tablero, valor:3, texto:"Ir a casilla"))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::IRCASILLA, tablero:@tablero, valor:6, texto:"Ir a casilla"))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::IRCASILLA, tablero:@tablero, valor:10, texto:"Ir a casilla"))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::PAGARCOBRAR, tablero:@tablero, valor:50, texto:"Pagar cobrar"))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::PAGARCOBRAR, tablero:@tablero, valor:-70, texto:"Pagar cobrar"))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::PORJUGADOR, tablero:@tablero, valor:10, texto:"Jugador"))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::PORJUGADOR, tablero:@tablero, valor:-10, texto:"Jugador"))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::PORCASAHOTEL, tablero:@tablero, valor:25, texto:"Casa o hotel"))
            @mazo.alMazo(Sorpresa.new(tipo:TipoSorpresa::PORCASAHOTEL, tablero:@tablero, valor:-20, texto:"Casa o hotel"))
        end

        def contabilizarPasosPorSalida(jugadorActual)
            while @tablero.getPorSalida > 0 do
                jugadorActual.pasaPorSalida
            end
        end

        def pasarTurno
            @indiceJugadorActual = (@indiceJugadorActual + 1) % @jugadores.length
        end

        def algunoEnBancarrota
            for jugador in @jugadores do
                if jugador.enBancarrota
                    return true
                end
            end
            return false
        end

        public
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
        
        def construirCasa(ip)
           return @jugadores[@indiceJugadorActual].construirCasa(ip)
        end

        def construirHotel(ip)
            return @jugadores[@indiceJugadorActual].construirHotel(ip)
        end
        
        
        def infoJugadorTexto
            jugadorActual = @jugadores[@indiceJugadorActual]
            puts "Jugador: #{jugadorActual.toString}"
        end
        
        def cancelarHipoteca(ip)
            return @jugadores[@indiceJugadorActual].cancelarHipoteca(ip)            
        end

        def comprar
            jugadorActual = @jugadores[@indiceJugadorActual]
            numCasillaActual = jugadorActual.numCasillaActual
            casilla = @tablero.getCasilla(numCasillaActual)
            titulo = casilla.tituloPropiedad
            return jugadorActual.comprar(titulo)
        end
        
        
        def finalDelJuego
            algunoEnBancarrota
        end
        
        def vender(ip)
            return @jugadores[@indiceJugadorActual].vender(ip)
        end
        
        def hipotecar(ip)
            return @jugadores[@indiceJugadorActual].hipotecar(ip)
        end
        
        def salirCarcelPagando
            return @jugadores[@indiceJugadorActual].salirCarcelPagando
        end
        
        def salirCarcelTirando
            return @jugadores[@indiceJugadorActual].salirCarcelTirando
        end
        
        private
        def ranking
            jugadores_ordenados=@jugadores.sort
            return jugadores_ordenados
        end    

        def avanzaJugador
            jugadorActual = getJugadorActual
            posicionActual = getJugadorActual.numCasillaActual
            tirada = Dado.instance().tirar
        
            posicionNueva = @tablero.nuevaPosicion(posicionActual, tirada)
        
            puts "posicionNueva: #{posicionNueva}"
            casilla = @tablero.getCasilla(posicionNueva)
        
            contabilizarPasosPorSalida(jugadorActual)
        
            jugadorActual.moverACasilla(posicionNueva)
        
        
            casilla.recibeJugador(@indiceJugadorActual, @jugadores)
            
            contabilizarPasosPorSalida(jugadorActual)
        end
    end
end