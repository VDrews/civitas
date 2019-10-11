require './diario'

module Civitas
    class MazoSorpresas
        @@diario = Diario.instance
        def initialize(debug = false)
            init()
        end

        def alMazo(s)
            if (!barajada)
                sorpresas.push(s)
            else
            end
        end

        def siguiente
            if (!barajada || usadas == sorpresas.length)
                shuffle
            end
                
        end

        def setDebug(d)
            debug = d
        end

        private
            @sorpresas
            @barajada
            @usadas
            @debug
            @cartasEspeciales
            @ultimaSorpresa

            def init
                sorpresas = []
                cartasEspeciales = []
                barajada = false
                usadas = 0
            end

            
            def shuffle
                if (!debug)
                    sorpresas.shuffle
                end
                usadas = 0
                barajada = true

                usadas += 1
                ultimaSorpresa = sorpresas.shift

                sorpresas.push(ultimaSorpresa)
                return ultimaSorpresa
            end

            def inhabilitarCartaEspecial(sorpresa) #Sorpresa
                # Sorpresa es un objeto, no se si al pedir el indice lo encontrará unicamente poniendo el objeto
                @index = sorpresas.index(sorpresa)
                @param = sorpresas[index]
                if(index)
                    sorpresas.delete_at(index)
                    cartasEspeciales.push(param)
                    diario.push("Se ha inhabilitado la carta nº" + index + "al mazo de cartas")
                end
            end

            def habilitarCartaEspecial(sorpresa)
                @index = cartasEspeciales.index(sorpresa)
                @param = cartasEspeciales[index]
                if(index)
                    cartasEspeciales.delete_at(index)
                    sorpresas.push(param)
                    diario.push("Se ha habilitado la carta nº" + index + "al mazo de cartas")
            
                end
            end
    end
end