require './jugador'
require './estados_juego'
require './gestor_estados'
require './mazo_sorpresas'
require './dado'

class CivitasJuego

    def initialize(nombres)
        @jugadores = []

        nombres.each {
            |n| n.push(Jugador.new(n))
        }
        

        @gestorEstados = GestorEstados.new
        @gestorEstados.estadoInicial

        @indiceJugadorActual = Dado.instance.quienEmpieza(nombres.size)
        
        @mazo = MazoSorpresas.new
        @tablero = Tablero.new(10)
        @estado = EstadosJuego.new
    end

    def actualizarInfo
        puts "Jugador: " + jugadores[actual].toString

        if (algunoEnBancarrota())
            ranking
        end
    end
    

    def inicializaTablero(mazo)
        tablero = Tablero.new(10)
        tablero.añadeCasilla(Casilla.new(TituloPropiedad.new("Calle 1", 120, 1.1, 20000, 40000, 20000)))
        tablero.añadeCasilla(Casilla.new(TituloPropiedad.new("Calle 2", 120, 1.1, 20000, 40000, 20000)))
        tablero.añadeCasilla(Casilla.new(TituloPropiedad.new("Calle 3", 120, 1.1, 20000, 40000, 20000)))
        tablero.añadeCasilla(Casilla.new(TituloPropiedad.new("Calle 4", 120, 1.1, 20000, 40000, 20000)))
        tablero.añadeCasilla(Casilla.new(TituloPropiedad.new("Calle 5", 120, 1.1, 20000, 40000, 20000)))
        tablero.añadeCasilla(Casilla.new(TituloPropiedad.new("Calle 6", 120, 1.1, 20000, 40000, 20000)))
        tablero.añadeCasilla(Casilla.new(TituloPropiedad.new("Calle 7", 120, 1.1, 20000, 40000, 20000)))
        tablero.añadeCasilla(Casilla.new(200.5, "Peaje1"))
        tablero.añadeCasilla(Casilla.new(200.5, "Peaje2")) 
        tablero.añadeCasilla(Casilla.new(200.5, "Peaje3")) 
        tablero.añadeCasilla(Casilla.new("Camping")) 
        tablero.añadeCasilla(Casilla.new("Burger King")) 
        tablero.añadeCasilla(Casilla.new(10, "Juez")) 
        tablero.añadeCasilla(Casilla.new(10, "Juez")) 
        tablero.añadeCasilla(Casilla.new(10, "Juez")) 
        tablero.añadeCasilla(Casilla.new(10, "Juez")) 
        tablero.añadeCasilla(Casilla.new(mazo, "Sorpresa1")) 
        tablero.añadeCasilla(Casilla.new(mazo, "Sorpresa2")) 
        tablero.añadeCasilla(Casilla.new(mazo, "Sorpresa3")) 
        tablero.añadeCasilla(Casilla.new(mazo, "Sorpresa4")) 
        tablero.añadeCasilla(Casilla.new(mazo, "Sorpresa5")) 
    end
    
    def inicializaMazoSorpresas(tablero)
        mazo = MazoSorpresas.new

        mazo.alMazo(Sorpresa.new(TipoSorpresa.IRCARCEL, tablero))
        mazo.alMazo(Sorpresa.new(TipoSorpresa.SALIRCARCEL, tablero))
        mazo.alMazo(Sorpresa.new(TipoSorpresa.IRCASILLA, tablero, 3, "Ir a casilla"))
        mazo.alMazo(Sorpresa.new(TipoSorpresa.IRCASILLA, tablero, 6, "Ir a casilla"))
        mazo.alMazo(Sorpresa.new(TipoSorpresa.IRCASILLA, tablero, 10, "Ir a casilla"))
        mazo.alMazo(Sorpresa.new(TipoSorpresa.PORCASAHOTEL, tablero, 10, "Casa o hotel"))
        mazo.alMazo(Sorpresa.new(TipoSorpresa.PORJUGADOR, tablero, 10, "Jugador"))
        mazo.alMazo(Sorpresa.new(TipoSorpresa.PAGARCOBRAR, tablero, 10, "Pagar cobrar"))
    end

    def contabilizarPasosPorSalida(jugadorActual)
        while tablero.getPorSalida > 0 do
            jugadorActual.pasaPorSalida
        end
    end

    def pasarTurno
        @indiceJugadorActual = (@indiceJugadorActual + 1) % @jugadores.length
    end

    def siguientePasoCompletado(operacion)
        @estado.siguienteEstado(getJugadorActual(), @estado, operacion)
    end

    def getCasillaActual
        return @tablero.getCasilla(getJugadorActual().getNumCasillaActual())
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
        #No P2
    end

    def infoJugadorTexto
        #No P2
    end

    def cancelarHipoteca(ip)
        @jugadores[@indiceJugadorActual].cancelarHipoteca(ip)
    end

    def comprar
        #P3
    end

    def finalDelJuego
        for i in @jugadores do
            if @jugadores[i].enBancarrota
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
