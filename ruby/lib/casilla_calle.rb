module Civitas
    class CasillaCalle < Casilla
        def initialize(titulo)
            super(titulo.nombre)
            @importe=titulo.precioCompra
            @tituloPropiedad=titulo
        end
        attr_reader :importe, :tituloPropiedad

        def recibeJugador(actual, todos)
            if (jugadorCorrecto(actual, todos))
                informe(actual, todos)
                jugador = todos[actual]
                if !@tituloPropiedad.tienePropietario()
                    jugador.puedeComprarCasilla
                else
                    @tituloPropiedad.tramitarAlquiler(jugador)
                end
            end
        end
    end
end