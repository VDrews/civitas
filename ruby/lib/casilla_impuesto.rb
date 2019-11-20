module Civitas
    class CasillaImpuesto < Casilla
        def initialize(nombre, importe)
            super(nombre)
            @importe=importe
        end
        attr_reader :importe

        def recibeJugador(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                todos[actual].pagaImpuesto(@importe);
            end
        end
    end
end