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

        def alMazo(s)
            if (!@barajada)
                @sorpresas.push(s)
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
            usadas+=1
            @ultimaSorpresa=@sorpresas[0]
            @sorpresas.delete_at(0)
            
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
            param = @sorpresas[index]
            if(index!=nil)
                @sorpresas.delete_at(index)
                @cartasEspeciales.push(param)
                Diario.instance.ocurreEvento("Se ha inhabilitado la carta nº" + index + "al mazo de cartas")
            end
        end

        def habilitarCartaEspecial(sorpresa)
            index = @cartasEspeciales.index(sorpresa)
            param = @cartasEspeciales[index]
            if(index!=nil)
                @cartasEspeciales.delete_at(index)
                @sorpresas.push(param)
                Diario.instance.ocurreEvento("Se ha habilitado la carta nº" + index + "al mazo de cartas")
        
            end
        end
    end
end