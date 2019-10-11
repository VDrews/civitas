module Civitas

    class TituloPropiedad

        attr_reader :hipotecado, :hipotecaBase, :nombre, :numCasas, :numHoteles, :precioCompra, :precioEdificar, :propietario
        
        private
        @@factorInteresesHipoteca=1.1

        def esEsteElPropietario(jugador)
            return @propietario==jugador
        end

        def getPrecioAlquiler
            if (!@hipotecado || propietarioEncarcelado)
                return (@alquilerBase*(1+(@numCasas*0.5)+(numHoteles*2.5)))
            else 
                return 0
            end
        end

        def propietarioEncarcelado
            return (tienePropietario&&!@propietario.isEncarcelado)
        end
        
        public
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

        def toString
            string="Alquiler Base= "+@alquilerBase
            +", Factor Revalorización: "+@factorRevalorizacion
            +", Hipoteca Base: "+@hipotecaBase
            +", Hipotecado: "+@hipotecado
            +", Nombre: "+@nombre
            +", Casas: "+@numCasas
            +", Hoteles: "+@numHoteles
            +", Precio compra: "+@precioCompra
            +", Precio casa: "+@precioEdificar

            return string
        end

        def getImporteCancelarHipoteca
            return (@@factorInteresesHipoteca*@hipotecaBase)
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
            @propietario=jugador
        end

        def cantidadCasasHoteles
            return @numCasas+@numHoteles
        end

        def comprar(jugador)
            if @propietario==nil
                actualizaPropietarioPorConversion(jugador)
                jugador.paga(@precioCompra)
                return true
            else
                return false
            end
        end

        def construirCasa(jugador)
            if(esEsteElPropietario(jugador))
                @numCasas += 1
                return true
            else
                return false
            end
        end

        def construirHotel(jugador)
            if(esEsteElPropietario(jugador))
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
                jugador.recibe(@hipotecaBase)
                @hipotecado=false
                return true
            else
                return false
            end
        end

        def tienePropietario(jugador)
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
            if (!@hipotecado && !esEsteElPropietario(jugador))
                @propietario.recibe(getPrecioVenta)
                jugador.paga(getPrecioVenta)
                @propietario=jugador
                return true
            else
                return false
            end
        end

        def getPrecioVenta
            return @precioCompra+(@precioEdificar*cantidadCasasHoteles)*@factorRevalorizacion
        end
    end
end