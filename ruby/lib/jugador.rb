require_relative('titulo_propiedad')
#encoding:utf-8

module Civitas
    class Jugador
        
        @CasasMax=4
        @@CasasPorHotel=4
        @HotelesMax=4
        @@PasoPorSalida=1000
        @@PrecioLibertad=200
        @@SaldoInicial=7500
    
        
        def initialize(nombre)
            @salvoconducto=nil
            @propiedades=[]
            @nombre=nombre
            @numCasillaActual=0
            @puedeComprar=false
            @saldo=@@SaldoInicial
            @encarcelado=false
            #Encarcelado es protected       
        end
        attr_reader :salvoconducto, :propiedades, :nombre, :numCasillaActual, :puedeComprar, :saldo, :encarcelado
        
        #protected
        def copia(otro)
            @salvoconducto=otro.salvoconducto
            @propiedades=otro.propiedades
            @nombre=otro.nombre
            @numCasillaActual=otro.numCasillaActual
            @puedeComprar=otro.puedeComprar
            @encarcelado=otro.encarcelado
            @saldo=otro.saldo
        end

        public
        def cancelarHipoteca(ip)
            result = false

            if (@encarcelado)
                return result
            end

            if existeLaPropiedad(ip)
                propiedad = @propiedades[ip]
                cantidad = propiedad.getImporteCancelarHipoteca
                
                if puedoGastar(cantidad)
                    result = propiedad.cancelarHipoteca(self)

                    if result
                        Diario.instance.ocurreEvento("El jugador #{@nombre} cancela la hipoteca de la propiedad #{ip}")
                    end
                end
            end

            return result
        end

        def cantidadCasasHoteles
            total = 0
            for propiedad in @propiedades
                total += propiedad.cantidadCasasHoteles
            end

            return total
        end

        def comprar(titulo)
            result = false

            if (@encarcelado)
                return result
            end

            if @puedeComprar
                precio = titulo.precioCompra

                if puedoGastar(precio)
                    result = titulo.comprar(self)

                    if (result)
                        @propiedades << titulo
                        Diario.instance.ocurreEvento("El jugador #{@nombre} compra la propiedad #{titulo.toString}")
                    end
                    
                end
                @puedeComprar = false
            end

            return result
        end

        def construirCasa(ip)
            result = false
            if @encarcelado
                return result
            end

            if existeLaPropiedad(ip)
                propiedad = @propiedades[ip]
                puedoEdificar = puedoEdificarCasa(propiedad)

                if puedoEdificar
                    result = propiedad.construirCasa(self)
                    Diario.instance.ocurreEvento("El jugador #{@nombre} construye casa en #{ip}")
                end
            end
        end

        def construirHotel(ip)
            result = false

            if @encarcelado
                return result
            end

            if existeLaPropiedad(ip)
                propiedad = @propiedades[ip]
                puedoEdificar = puedoEdificarHotel(propiedad) #He cambiado el nombre del que hay del diagrama para diferenciarlo de la funcion

                if puedoEdificar
                    result = propiedad.construirHotel(self)
                    propiedad.derruirCasas(@@CasasPorHotel, self)
                    Diario.instance.ocurreEvento("El jugador #{@nombre} construye hotel en su propiedad #{ip}")
                end
            end

            return result
        end

        def enBancarrota
            return @saldo <= 0
        end

        def encarcelar(numCasillaCarcel)
            if debeSerEncarcelado
                moverACasilla(numCasillaCarcel)
                @encarcelado=true
                Diario.instance.ocurreEvento("El jugador "+@nombre+" ha sido encarcelado")
            end
            return @encarcelado
        end

        def getCasasPorHotel
            return @@CasasPorHotel
        end

        def getNumCasillaActual
            return @numCasillaActual
        end

        def getPuedeComprar
            return @puedeComprar
        end

        def moverACasilla(numCasilla)
            if (@encarcelado) 
                return false
            else 
                @numCasillaActual = numCasilla
                @puedeComprar = false
                Diario.instance.ocurreEvento("Se ha desplazado a la casilla: #{numCasilla}")
                return true
            end
        end

        def obtenerSalvoconducto(sorpresa)
            if @encarcelado
                return false            
            else
                @salvoconducto=sorpresa
                Diario.instance.ocurreEvento("El jugador #{@nombre} obtiene salvoconducto")
                return true
            end
        end

        def salirCarcelPagando
            if (@encarcelado && puedeSalirCarcelPagando) 
                paga(@@PrecioLibertad)
                @encarcelado = false
                Diario.instance.ocurreEvento("Jugador: " + @nombre + " ha salido de la carcel PAGANDO")
                return true
            else 
                return false
            end
        end

        def salirCarcelTirando
            if (Dado.instance.salgoDeLaCarcel)
                @encarcelado = false;
                Diario.instance.ocurreEvento("Jugador: " + @nombre + " ha salido de la carcel TIRANDO")
                return true
            else 
                return false
            end
        end

        def tieneAlgoQueGestionar
            return @propiedades.size != 0
        end

        def tieneSalvoConducto
            return @salvoconducto!=nil
        end

        def vender(ip)
            if (!@encarcelado && existeLaPropiedad(ip) && @propiedades[ip].vender(self))
                @propiedades.delete_at(ip)
                Diario.instance.ocurreEvento("La propiedad ha sido vendida")
                return true
            end
            return false    
        end

        private
        def existeLaPropiedad(ip)
            return ip >= 0 && ip < @propiedades.length
        end

        protected
        def self.CasasMax
            return @CasasMax
        end

        def self.HotelesMax
            return @HotelesMax
        end

        private
        def self.PrecioLibertad
            return @@PrecioLibertad
        end

        def self.PasoPorSalida
            return @@PasoPorSalida
        end

        def perderSalvoConducto
            @salvoconducto.usada()
            @salvoconducto=nil
        end

        def puedeSalirCarcelPagando
            return @saldo >= @@PrecioLibertad
        end

        def puedoEdificarCasa(propiedad)
            precio=propiedad.precioEdificar
            if(puedoGastar(precio))
                if(propiedad.numCasas<Jugador.CasasMax)
                    return true
                end
            end
            return false
        end

        def puedoEdificarHotel(propiedad)
            precio=propiedad.precioEdificar
            if(puedoGastar(precio))
                if(propiedad.numHoteles<Jugador.HotelesMax)
                    if (propiedad.numCasas>=@@CasasPorHotel)
                        return true
                    end
                end
            end
            return false
        end

        def puedoGastar(precio)
            if(@encarcelado)
                return false
            end
            return @saldo >= precio
        end

        protected
        def debeSerEncarcelado
            if @encarcelado
                return false
            elsif tieneSalvoConducto
                perderSalvoConducto
                Diario.instance.ocurreEvento("El jugador "+@nombre+" se libra de la cárcel")
                return false
            end

            return true
        end
        
        public
        def compareTo(otro)
            return @saldo <=> otro.saldo
        end

        def hipotecar(ip)
            result = false

            if encarcelado
                return result
            end

            if existeLaPropiedad(ip)
                propiedad = @propiedades[ip]
                result = propiedad.hipotecar(self)
            end

            if result
                Diario.instance.ocurreEvento("El jugador #{@nombre} hipoteca la propiedad #{ip}")
            end
            
            return result
        end

        def modificarSaldo(cantidad)
            @saldo += cantidad
            Diario.instance.ocurreEvento("Se ha modificado el saldo en: " + cantidad.to_s + ", SALDO ACTUAL: " + @saldo.to_s)
            return true
        end

        def paga(cantidad)
            return modificarSaldo(cantidad * -1)
        end

        def pagaAlquiler(cantidad)
            if (@encarcelado) 
                return false 
            end
            return paga(cantidad)
        end

        def pagaImpuesto(cantidad)
            if @encarcelado 
                return false 
            end
            return paga(cantidad)
        end

        def pasaPorSalida
            modificarSaldo(@@PasoPorSalida)
            Diario.instance.ocurreEvento("Jugador: " + @nombre + " ha pasado por la salida")
            return true
        end

        def puedeComprarCasilla
            @puedeComprar = !(@encarcelado)
            return @puedeComprar
        end

        def toString
            string=" Nombre: "+@nombre.to_s
            string+="Salvoconducto: "+@salvoconducto.to_s
            string+=" Cas actual: "+@numCasillaActual.to_s
            string+=" Puede comprar: "+@puedeComprar.to_s
            string+=" Saldo: "+@saldo.to_s
            string+=" Encarcelado: "+@encarcelado.to_s

            substr=""
            for i in @propiedades do
                substr+= (i.nombre+" ")
            end
            string+=" Propiedades: "+substr
        end

        def isEncarcelado
            return @encarcelado
        end

        def recibe(cantidad)
            if (@encarcelado) 
                return false
            else 
                return modificarSaldo(cantidad)
            end
        end

        def getPropiedades_toString
            String res=[]
            for i in @propiedades do
                res << i.nombre
            end
            return res
        end

    end
end