require_relative ('diario')
module Civitas
    class JugadorEspeculador < Jugador
        @FactorEspeculador=2
        @CasasMax=@FactorEspeculador*Jugador.CasasMax
        @HotelesMax=@FactorEspeculador*Jugador.HotelesMax

        def initialize(fianza)
            super("nuevo")
            @fianza=fianza  
        end

        def self.nuevoEspeculador(jugador, fianza)
            Diario.instance.ocurreEvento("Convertido a JUGADOR ESPECULADOR")
            ret=new(fianza)
            ret.copia(jugador)
            for i in jugador.propiedades do
                i.actualizaPropietarioPorConversion(ret)
            end
            return ret
        end
        private_class_method :new

        def debeSerEncarcelado
            if @encarcelado
                return false
            elsif tieneSalvoConducto
                perderSalvoConducto
                Diario.instance.ocurreEvento("El jugador "+@nombre+" se libra de la cárcel")
                return false
            elsif puedePagarFianza
                paga(@fianza)
                return false
            end

            return true
        end

        def puedePagarFianza
            return @saldo >= @fianza
        end

        def toString
            str=super
            str+="JUGADOR ESPECULADOR"
        end

        def pagaImpuesto(cantidad)
            if @encarcelado 
                return false 
            end
            return paga(cantidad/2)
        end

    end
end