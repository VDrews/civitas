require_relative 'casilla'

module Civitas
    class Tablero
        def initialize(indexCarcel)
        @numCasillaCarcel = indexCarcel >= 1 ? indexCarcel : 1
        @casillas = []
        @porSalida = 0
        @tieneJuez = false
        
        @casillas.push(Casilla.newDescanso('Salida'))

        end
        
        def correcto(numCasilla = nil)
            if (numCasilla == nil)
                return @casillas.length > @numCasillaCarcel
            elsif (@casillas.length > @numCasillaCarcel && numCasilla >= 0 && numCasilla < @casillas.length)
                return true
            end
        end

        def getCarcel()
            return @numCasillaCarcel
        end

        def getPorSalida()
            ret = @porSalida
            if (@porSalida > 0) 
                @porSalida -= 1
            end
            return ret

        end

        def añadeCasilla(casilla)
            if (@casillas.length == @numCasillaCarcel) 
                @casillas.push(Casilla.newDescanso("Cárcel"))
            end
            @casillas.push(casilla)
            if (@casillas.length == @numCasillaCarcel) 
                @casillas.push(Casilla.newDescanso("Cárcel"))
            end
        end

        def añadeJuez()
            if (!@tieneJuez)
                @casillas.push(Casilla.newJuez(@numCasillaCarcel, "Juez"))
                @tieneJuez = true
            end
        end

        def getCasilla(numCasilla)
            if (correcto(numCasilla))
                return @casillas[numCasilla]
            else
                return nil
            end
        end

        def nuevaPosicion(actual, tirada)
            puts "ACTUAL: #{actual}"
            puts "TIRADA: #{tirada}"
            if (correcto) 
                return (actual + tirada) % @casillas.length
            end
            
            return -1
        end

        def calcularTirada(origen, destino)
            tirada = destino - origen

            if (tirada < 0)
                tirada += @casillas.length
            end

            return tirada
        end

        def toString
            string="Casilla cárcel: "+@numCasillaCarcel.to_s
            #string+=", Casillas: "+@casillas.to_s
            string+=", Juez: "+@tieneJuez.to_s
            string+=", por Salida: "+@porSalida.to_s
            #La salida de lo comentado no es ortodoxa. Activar si realmente necesario
        end



    end
end