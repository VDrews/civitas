require './TituloPropiedad'
#encoding:utf-8
#Falta constructor copia, protected

class Jugador
    #protected
    private
    @@CasasMax=4
    @@CasasPorHotel=4
    @@HotelesMax=4
    @@PasoPorSalida=200
    @@PrecioLibertad=200

    private
    @@SaldoInicial=7500

    public
    def initialize(nombre)
        @nombre=nombre
        @numCasillaActual=0
        @puedeComprar=true
        @saldo=@@SaldoInicial
        @encarcelado=false
        #Encarcelado es protected       
    end

    def cancelarHipoteca(ip)

    end

    def cantidadCasasHoteles

    end

    def compareTo(otro)

    end

    def comprar(titulo)

    end

    def construirCasa(ip)
        
    end

    def construirHotel(ip)
        
    end

    #protected
    private
    def debeSerEncarcelado

    end

    public
    def enBancarrota

    end

    def encarcelar(numCasillaCarcel)

    end

    private
    def existeLaPropiedad(ip)

    end

    def getCasasMax

    end

    def getHotelesMax

    end

    #protected
    private
    def getNombre

    end

    public
    def getCasasporHotel

    end

    def getNumCasillaActual

    end

    private
    def getPrecioLibertad

    end

    def getPremioPasoSalida

    end

    #protected
    private
    def getPropiedades

    end

    def getSaldo

    end

    public
    def getPuedeComprar

    end

    def hipotecar(ip)
        
    end

    def isEncarcelado

    end

    def modificarSaldo(cantidad)

    end

    def moverACasilla(numCasilla)

    end

    def obtenerSalvoconducto(sorpresa)
        
    end

    def paga(cantidad)
    
    end

    def pagaAlquiler(cantidad)

    end

    def pagaImpuesto(cantidad)
    
    end

    def pasaPorSalida
    
    end

    private
    def perderSalvoConducto
    
    end

    public
    def puedeComprarCasilla

    end

    private
    def puedeSalirCarcelPagando

    end

    def puedoEdificarCasa(propiedad)

    end

    def puedoEdificarHotel(propiedad)

    end

    def puedoGastar(precio)

    end

    public
    def recibe(cantidad)

    end

    def salirCarcelPagando

    end

    def salirCarcelTirando

    end

    def tieneAlgoQueGestionar

    end

    def tieneSalvoConducto

    end

    def toString

    end

    def vender(ip)

    end



end