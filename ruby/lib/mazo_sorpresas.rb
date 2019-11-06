require_relative('diario')

module Civitas
    class MazoSorpresas

        def initialize(debug = false)
            @sorpresas = []
            @cartasEspeciales = []
            @barajada = false
            @usadas = 0
            @debug=debug
            if debug
                Diario.instance.ocurreEvento("MazoSorpresas--Modo debug: activado")
            end
        end

        def toString
            #string="Sorpresas: "+@sorpresas.to_s
            #string+=" Cartas especiales: "+@cartasEspeciales.to_s
            string=" Barajada "+@barajada.to_s
            string+=" Usadas "+@usadas.to_s
            string+=" Debug: "+@debug.to_s
            string+=" Tamaño: "+@sorpresas.size.to_s
            #La salida de lo comentado no es ortodoxa. Activar si realmente necesario
            return string
        end

        def alMazo(s)
            if (!@barajada)
                @sorpresas << s
            end
        end

        def siguiente
            if (!@barajada || @usadas == @sorpresas.length)
                if !@debug
                    @sorpresas.shuffle
                end
                @usadas=0
                @barajada=true
            end
            @usadas+=1
            @ultimaSorpresa=@sorpresas[0]
            # @sorpresas.delete_at(0)

            # PETA PORQUE SE QUEDA SIN CARTAS
            
            return @ultimaSorpresa    
        end

        def setDebug(d)
            @debug = d
            if d 
                Diario.instance.ocurreEvento("MazoSorpresas--Modo debug: activado")
            end

        end

        def inhabilitarCartaEspecial(sorpresa) #Sorpresa
            # Sorpresa es un objeto, no se si al pedir el indice lo encontrará unicamente poniendo el objeto
            index = @sorpresas.index(sorpresa)
            if(index!=nil)
                param = @sorpresas[index]
                @sorpresas.delete_at(index)
                @cartasEspeciales.push(param)
                Diario.instance.ocurreEvento("Se ha inhabilitado la carta nº" + index + "al mazo de cartas")
            end
        end

        def habilitarCartaEspecial(sorpresa)
            index = @cartasEspeciales.index(sorpresa)
            if(index!=nil)
                param = @cartasEspeciales[index]
                @cartasEspeciales.delete_at(index)
                @sorpresas.push(param)
                Diario.instance.ocurreEvento("Se ha habilitado la carta nº" + index + "al mazo de cartas")
        
            end
        end
    end
end