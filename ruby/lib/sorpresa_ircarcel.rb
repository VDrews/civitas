module Civitas
    class SorpresaIrCarcel < Sorpresa
        public_class_method :new
        def initialize(tablero)
            super("Carcel")
            @tablero=tablero
        end
        
        def aplicarAJugador(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                todos[actual].encarcelar(@tablero.getCarcel)
            end
        end
    end
end