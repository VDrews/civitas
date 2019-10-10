module Civitas

    class TituloPropiedad
        
        private
        @@factorInteresesHipoteca=1.1

        def esEsteElPropietario(jugador)
            
        end

        def getImporteHipoteca

        end

        def getPrecioAlquiler
            if (!@hipotecado || propietarioEncarcelado)
                return (@alquilerBase*(1+(@numCasas*0.5)+(numHoteles*2.5)))
            else return 0
        end

        def getPrecioVenta
            
        end

        def propietarioEncarcelado

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
            
        end

        def cantidadCasasHoteles
            
        end

        def comprar(jugador)
            
        end

        def construirCasa(jugador)
            
        end

        def construirHotel(jugador)
            
        end

        def derruirCasas(n, jugador)
            
        end

        def hipotecar(jugador)
            if (!@hipotecado && )
                
            else
                
            end
        end

        def tienePropietario(jugador)

        end

        def tramitarAlquiler(jugador)

        end

        def vender(jugador)
        
        end
    end
end