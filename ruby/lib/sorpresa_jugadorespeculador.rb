require_relative ('jugador_especulador')

module Civitas
    class SorpresaJugadorEspeculador < Sorpresa
        public_class_method :new
        def initialize(fianza)
            super("Jugador Especulador")
            @valor=fianza
        end

        def aplicarAJugador(actual, todos)
            if(jugadorCorrecto(actual, todos))
                informe(actual, todos)
                jugador=JugadorEspeculador.nuevoEspeculador(todos[actual], @valor)
                todos.delete_at(actual)
                todos.insert(actual, jugador)
            end
        end

    end
end