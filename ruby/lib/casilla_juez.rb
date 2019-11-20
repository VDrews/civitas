module Civitas
    class CasillaJuez < Casilla
        def initialize(carcel)
            super("Juez")
            @carcel=carcel
        end
        attr_reader :carcel

        def recibeJugador(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                todos[actual].encarcelar(@carcel)
            end
        end
    end
end