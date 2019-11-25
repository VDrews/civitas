module Civitas
    class SorpresaSalirCarcel < Sorpresa
        public_class_method :new
        def initialize(mazo)
            super("Salir de carcel")
            @mazo=mazo
        end

        def aplicarAJugador(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                tiene=false
                for i in 0...todos.size do
                    tiene=todos[i].tieneSalvoConducto
                    if tiene
                        break
                    end
                end
                if !tiene
                    todos[actual].obtenerSalvoconducto(self)
                    self.salirDelMazo
                end
            end
        end

        def salirDelMazo
            @mazo.inhabilitarCartaEspecial(self)
        end

        def usada
            @mazo.habilitarCartaEspecial(self)
        end
    end
end