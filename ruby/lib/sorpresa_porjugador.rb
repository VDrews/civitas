module Civitas
    class SorpresaPorJugador < Sorpresa
        public_class_method :new
        def initialize(texto, valor)
            super(texto)
            @valor=valor
        end

        def aplicarAJugador(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                s1= SorpresaPagarCobrar.new("TODOS", @valor*-1)
                for i in 0...todos.length do
                    if i!=actual
                        s1.aplicarAJugador(i, todos)
                    end
                end

                sorpresa= SorpresaPagarCobrar.new("ACTUAL", @valor*(todos.length-1))
                sorpresa.aplicarAJugador(actual, todos)
            end
        end
    end
end