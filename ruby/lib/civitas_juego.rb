require_relative('jugador')
require_relative('estados_juego')
require_relative('operaciones_juego')
require_relative('gestor_estados')
require_relative('mazo_sorpresas')
require_relative('dado')
require_relative('tablero')
require_relative('sorpresa_ircarcel')
require_relative('sorpresa_salircarcel')
require_relative('sorpresa_ircasilla')
require_relative('sorpresa_pagarcobrar')
require_relative('sorpresa_porjugador')
require_relative('sorpresa_porcasahotel')
require_relative('sorpresa_jugadorespeculador')

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

            @tablero.añadeCasilla(CasillaCalle.new(TituloPropiedad.new("Ladrón", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(CasillaSorpresa.new(@mazo)) 
            @tablero.añadeCasilla(CasillaCalle.new(TituloPropiedad.new("Ladrón 2", 1.5, -0.5, 30.0, 60.0, 30.0)))
            
            @tablero.añadeCasilla(CasillaCalle.new(TituloPropiedad.new("Ladrón 3", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(CasillaCalle.new(TituloPropiedad.new("Ladrón 4", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(CasillaSorpresa.new(@mazo)) 
            @tablero.añadeCasilla(CasillaCalle.new(TituloPropiedad.new("Ladrón 5", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(Casilla.new("Burger King")) 
            @tablero.añadeCasilla(CasillaCalle.new(TituloPropiedad.new("Ladrón 6", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(CasillaCalle.new(TituloPropiedad.new("Ladrón 7", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(CasillaSorpresa.new(@mazo))
            @tablero.añadeCasilla(CasillaCalle.new(TituloPropiedad.new("Ladrón 8", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeJuez
            @tablero.añadeCasilla(CasillaCalle.new(TituloPropiedad.new("Ladrón 9", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(CasillaCalle.new(TituloPropiedad.new("Ladrón 10", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(CasillaImpuesto.new("Peaje", 200)) 
            @tablero.añadeCasilla(CasillaCalle.new(TituloPropiedad.new("Ladrón 11", 1.5, -0.5, 30.0, 60.0, 30.0)))
            @tablero.añadeCasilla(CasillaCalle.new(TituloPropiedad.new("Ladrón 12", 1.5, -0.5, 30.0, 60.0, 30.0)))
        end
        
        def inicializaMazoSorpresas(tablero)
            @mazo.alMazo(SorpresaJugadorEspeculador.new(200))
            @mazo.alMazo(SorpresaIrCarcel.new(@tablero))
            @mazo.alMazo(SorpresaSalirCarcel.new(@mazo))
            @mazo.alMazo(SorpresaIrCasilla.new("A la casilla", @tablero, 3))
            @mazo.alMazo(SorpresaIrCasilla.new("A la casilla", @tablero, 6))
            @mazo.alMazo(SorpresaPagarCobrar.new("Paga", -70))
            @mazo.alMazo(SorpresaPagarCobrar.new("Cobra", 50))
            @mazo.alMazo(SorpresaPorJugador.new("Paga_jugador", -10))
            @mazo.alMazo(SorpresaPorJugador.new("Cobra_jugador", 10))
            @mazo.alMazo(SorpresaPorJugador.new("Obras", -20))
            @mazo.alMazo(SorpresaPorJugador.new("Casahotel", 25))
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