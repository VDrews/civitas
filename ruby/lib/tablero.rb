require_relative 'casilla'
require_relative 'casilla_calle'
require_relative 'casilla_impuesto'
require_relative 'casilla_juez'
require_relative 'casilla_sorpresa'


module Civitas
    class Tablero
        def initialize(indexCarcel)
        @numCasillaCarcel = indexCarcel >= 1 ? indexCarcel : 1
        @casillas = []
        @porSalida = 0
        @tieneJuez = false
        
        @casillas.push(Casilla.new('Salida'))

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
            @casillas.push(casilla)
            if (@casillas.length == @numCasillaCarcel) 
                @casillas.push(Casilla.new("Cárcel"))
            end
        end

        def añadeJuez()
            if (!@tieneJuez)
                @casillas.push(CasillaJuez.new(@numCasillaCarcel))
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
                posicion=(actual + tirada) % @casillas.length
                if (posicion != (actual+tirada))
                    @porSalida+=1
                end
                return posicion
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