
require './diario'
require 'singleton'

class Dado
    include Singleton
    @@SalidaCarcel = 5
    @@random = nil
    @@ultimoResultado = nil #int
    @@debug = false #bool

    def initialize 

    end

    def tirar #int
        if (!@@debug)
            @@ultimoResultado = rand(1..6).floor
        end
    end

    def salgoDeLaCarcel
        tirar()
        if (@@ultimoResultado == @@SalidaCarcel)
            return true
        else
            return false
        end
    end

    def quienEmpieza(n)
        ran = rand(1..n).floor - 1
        return ran
    end

    def setDebug(d)
        @@debug = d
        if (d)
            cadena = "El modo debug ha sido activado"
        else
            cadena = "El modo debug ha sido desactivado"
        end
        diario = Diario.instance
        diario.ocurreEvento(cadena)
    end

    def ultimoResultado
        return @@ultimoResultado
    end






    
end

#Dado.instance para obtener la instancia