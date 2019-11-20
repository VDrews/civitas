module Civitas
    class CasillaSorpresa < Casilla
        def initialize(mazo)
            super("Sorpresa")
            @mazo=mazo
            @sorpresa=nil
        end
        attr_reader :mazo, :sorpresa

        def recibeJugador(actual, todos)
            if (jugadorCorrecto(actual, todos))
                informe(actual, todos)
                @sorpresa = @mazo.siguiente
                @sorpresa.aplicarAJugador(actual, todos)
        
            end
        end
    end
end