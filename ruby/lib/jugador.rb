require_relative('titulo_propiedad')
#encoding:utf-8
#Falta constructor copia, protected

module Civitas
    class Jugador

        def initialize(nombre)
            @salvoconducto=nil
            @propiedades=nil
            @nombre=nombre
            @numCasillaActual=0
            @puedeComprar=true
            @saldo=@@SaldoInicial
            @encarcelado=false
            #Encarcelado es protected       
        end
        
        #protected
        private
        @@CasasMax=4
        @@CasasPorHotel=4
        @@HotelesMax=4
        @@PasoPorSalida=200
        @@PrecioLibertad=200

        private
        @@SaldoInicial=7500

        attr_reader :CasasMax, :CasasPorHotel, :HotelesMax, :nombre, :numCasillaActual, :PrecioLibertad, :premioPasoSalida, :propiedades, :puedeComprar, :saldo

        def cancelarHipoteca(ip)
            #P3
        end

        def cantidadCasasHoteles
            #No P2
        end

        def compareTo(otro)
            return @saldo <=> otro.saldo
        end

        def comprar(titulo)
            #P3
        end

        def construirCasa(ip)
            #P3
        end

        def construirHotel(ip)
            #P3
        end

        #protected
        private
        def debeSerEncarcelado
            if @encarcelado
                return false
            elsif !tieneSalvoConducto
                return true
            else
                perderSalvoConducto
                Diario.instance.ocurreEvento("El jugador "+@nombre+" se libra de la cárcel")
                return false
            end
        end

        public
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

        private
        def existeLaPropiedad(ip)
            #P3
        end

        def hipotecar(ip)
            #P3
        end

        def isEncarcelado
            ret encarcelado
        end

        def modificarSaldo(cantidad)
            @saldo += cantidad
            Diario.instance.ocurreEvento("Se ha modificado el saldo en: " + cantidad + ", SALDO ACTUAL: " + @saldo)
            return true
        end

        def moverACasilla(numCasilla)
            if (encarcelado) 
                return false
            else 
                @numCasillaActual = numCasilla
                @puedeComprar = false
                Diario.instance.ocurreEvento("Se ha desplazado a la casilla: " + numCasilla)
            end
        end

        def obtenerSalvoconducto(sorpresa)
            if @encarcelado
                return false            
            else
                @salvoconducto=sorpresa
                return true
            end
        end

        def paga(cantidad)
            return modificarSaldo(cantidad * -1)
        end

        def pagaAlquiler(cantidad)
            if (@encarcelado) 
                return false 
            end
            return paga(@cantidad)
        end

        def pagaImpuesto(cantidad)
            if @encarcelado 
                return false 
            end
            return paga(@cantidad)
        end

        def pasaPorSalida
            modificarSaldo(@@PasoPorSalida)
            Diario.instance.ocurreEvento("Jugador: " + @nombre + " ha pasado por la salida")
            return true
        end

        private
        def perderSalvoConducto
            @salvoconducto.usada()
        end

        public
        def puedeComprarCasilla
            @puedeComprar = !@encarcelado;
            return @puedeComprar;
        end

        private
        def puedeSalirCarcelPagando
            return @saldo >= @@PrecioLibertad
        end

        def puedoEdificarCasa(propiedad)
            #No P2
        end

        def puedoEdificarHotel(propiedad)
            #No P2
        end

        def puedoGastar(precio)
            return @saldo >= precio
        end

        public
        def recibe(cantidad)
            if (@encarcelado) 
                return false
            else 
                return modificarSaldo(cantidad)
            end
        end

        def salirCarcelPagando
            if (@encarcelado && puedeSalirCarcelPagando()) 
                paga(PrecioLibertad)
                @encarcelado = false
                Diario.getInstance().ocurreEvento("Jugador: " + @nombre + " ha salido de la carcel PAGANDO")
                return true
            else 
                return false
            end
        end

        def salirCarcelTirando
            if (Dado.getInstance().salgoDeLaCarcel()) 
                @encarcelado = false;
                Diario.instance.ocurreEvento("Jugador: " + @nombre + " ha salido de la carcel TIRANDO")
                return true
            else 
                return false
            end
        end

        def tieneAlgoQueGestionar
            return @propiedades.size != 0;
        end

        def tieneSalvoConducto
            return @salvoconducto!=nil
        end

        def toString

        end

        def vender(ip)
            if @encarcelado
                return false
            elsif existeLaPropiedad(ip)
                if propiedades[ip].vender
                    Diario.instance.ocurreEvento("La propiedad "+propiedades[ip].nombre+" ha sido vendida")
                    propiedades.delete_at(ip)

                    return true
                end
            else
                return false
            end       

        end
    end
end