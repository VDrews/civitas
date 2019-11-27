require_relative("mazo_sorpresas")

module Civitas
    class Sorpresa

        def initialize(texto)
            @texto=texto
        end

        def aplicarAJugador(actual, todos)
        end

       
        def informe(actual, todos)
            Diario.instance.ocurreEvento("Se aplica #{toString} a "+todos[actual].nombre)
        end

        def jugadorCorrecto (actual, todos)
            return (actual >= 0 && actual <= todos.length)
        end

        def toString
            return "Sorpresa: #{@texto}"
        end

        private_class_method :new
    end
end