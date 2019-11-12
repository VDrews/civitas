require_relative('jugador')

module Civitas

    class TituloPropiedad

        
        def initialize(nom, ab, fr, hb, pc, pe)
            @alquilerBase=ab
            @factorRevalorizacion=fr
            @hipotecaBase=hb
            @hipotecado=false
            @nombre=nom
            @numCasas=0
            @numHoteles=0
            @precioCompra=pc
            @precioEdificar=pe
            @propietario=nil
        end

        @@factorInteresesHipoteca=1.1
        attr_reader :hipotecado, :hipotecaBase, :nombre, :numCasas, :numHoteles, :precioCompra, :precioEdificar, :propietario


        private
        def esEsteElPropietario(jugador)
            return @propietario.nombre==jugador.nombre
        end

        def getPrecioAlquiler
            if (!@hipotecado || !propietarioEncarcelado)
                return (@alquilerBase*(1+(@numCasas*0.5)+(numHoteles*2.5)))
            else 
                return 0
            end
        end

        def propietarioEncarcelado
            return (tienePropietario&&!@propietario.isEncarcelado)
        end

        def getImporteHipoteca
            return @hipotecaBase*(1+(@numCasas*0.5)+(@numHoteles*2.5))
        end
    

        public
        def toString
            string="Alquiler Base: "+@alquilerBase.to_s
            string+=", Factor Revalorización: "+@factorRevalorizacion.to_s
            string+=", Hipoteca Base: "+@hipotecaBase.to_s
            string+=", Hipotecado: "+@hipotecado.to_s
            string+=", Nombre: "+@nombre.to_s
            string+=", Casas: "+@numCasas.to_s
            string+=", Hoteles: "+@numHoteles.to_s
            string+=", Precio compra: "+@precioCompra.to_s
            string+=", Precio casa: "+@precioEdificar.to_s
            string+=", Propietario: "+@propietario.to_s
            #La salida de lo comentado no es ortodoxa. Activar si realmente necesario

            return string
        end

        def getImporteCancelarHipoteca
            return (@@factorInteresesHipoteca*getImporteHipoteca)
        end

        def cancelarHipoteca (jugador)
            if (@hipotecado && esEsteElPropietario(jugador))
                jugador.paga(getImporteCancelarHipoteca)
                @hipotecado=false
                return true
            else
                return false
            end
        end

        def actualizaPropietarioPorConversion(jugador)
            if(!esEsteElPropietario(jugador))
                @propietario=jugador
            end
        end

        def cantidadCasasHoteles
            return @numCasas+@numHoteles
        end

        def comprar(jugador)
            if !tienePropietario
                @propietario=jugador
                jugador.paga(@precioCompra)
                return true
            else
                return false
            end
        end

        def construirCasa(jugador)
            if(esEsteElPropietario(jugador))
                jugador.paga(@precioEdificar)
                @numCasas += 1
                return true
            else
                return false
            end
        end

        def construirHotel(jugador)
            if(esEsteElPropietario(jugador))
                jugador.paga(@precioEdificar)
                @numHoteles += 1
                return true
            else
                return false
            end
        end

        def derruirCasas(n, jugador)
            if(esEsteElPropietario(jugador) && @numCasas >= n)
                @numCasas -= n
                return true
            else
                return false
            end
        end

        def hipotecar(jugador)
            if (!@hipotecado && esEsteElPropietario(jugador))
                jugador.recibe(getImporteHipoteca)
                @hipotecado=true
                return true
            else
                return false
            end
        end

        def tienePropietario
            return @propietario!=nil
        end

        def tramitarAlquiler(jugador)
            if (!@hipotecado && !esEsteElPropietario(jugador))
                jugador.pagaAlquiler(getPrecioAlquiler)
                @propietario.recibe(getPrecioAlquiler)
                return true
            else
                return false
            end
        end

        def vender(jugador)
            if (esEsteElPropietario(jugador))
                @propietario=nil
                jugador.recibe(getPrecioVenta)
                @numCasas=0
                @numHoteles=0
                return true
            else
                return false
            end
        end

        def getPrecioVenta
            return (@precioCompra+(@numCasas+5*@numHoteles)*(@precioEdificar*@factorRevalorizacion))
        end
    end
end