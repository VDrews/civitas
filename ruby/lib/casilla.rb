require_relative('sorpresa')
require_relative('mazo_sorpresas')
require_relative('jugador')
require_relative('titulo_propiedad')

module Civitas
    class Casilla
        def initialize(nombre)
            @nombre=nombre
        end
        attr_reader :nombre

        def jugadorCorrecto(actual, todos)
            return actual>=0&&actual<todos.length
        end

        def informe(actual, todos)
            if (jugadorCorrecto(actual, todos)) 
                Diario.instance.ocurreEvento(todos[actual].nombre + ": Casilla " + toString())
            end
        end

        def recibeJugador(actual, todos)
        end

        def toString
            return "\nCasilla: " + @nombre
        end
    end
end