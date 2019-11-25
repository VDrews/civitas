module Civitas
    class SorpresaIrCasilla < Sorpresa
        public_class_method :new
        def initialize(texto, tablero, valor)
            super(texto)
            @tablero=tablero
            @valor=valor
        end

        def aplicarAJugador(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                tirada = @tablero.calcularTirada(todos[actual].getNumCasillaActual, @valor)
                nueva_pos = @tablero.nuevaPosicion(todos[actual].getNumCasillaActual, tirada)
                todos[actual].moverACasilla(nueva_pos)
                @tablero.getCasilla(nueva_pos).recibeJugador(actual, todos)
            end
        end
    end
end