module Civitas
    class SorpresaPagarCobrar < Sorpresa
        public_class_method :new
        def initialize(texto, valor)
            super(texto)
            @valor=valor
        end
        
        def aplicarAJugador(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual,todos)
                todos[actual].modificarSaldo(@valor)
            end
        end
    end
end