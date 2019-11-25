module Civitas
    class SorpresaPorCasaHotel < Sorpresa
        public_class_method :new
        def initialize(texto, valor)
            super(texto)
            @valor=valor
        end
        
        def aplicarAJugador(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                todos[actual].modificarSaldo(@valor*todos[actual].cantidadCasasHoteles)
            end
        end
    end
end