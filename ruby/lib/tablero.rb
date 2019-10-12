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
                @casillas.push(Casilla.new("Cárcel"))
            end
            Casilla.new(casilla)
            if (@casillas.length == @numCasillaCarcel) 
                @casillas.push(Casilla.new("Cárcel"))
            end
        end

        def añadeJuez()
            if (!@tieneJuez)
                @casillas.push(Casilla.new("Juez"))
                @tieneJuez = true
            end
        end

        def getCasilla(numCasilla)
            if (correcto(numCasilla))
                return @casillas[numCasilla]
            else
                return null
            end
        end

        def nuevaPosicion(actual, tirada)
            if (correcto()) 
                return -1
            end
            return (actual + tirada) % @casillas.length
        end

        def calcularTirada(origen, destino)
            tirada = destino - origen

            if (tirada < 0)
                tirada += casillas.length
            end

            return tirada
        end



    end
end