require_relative 'diario'
require 'singleton'

module Civitas
    class Dado
        include Singleton
        @@SalidaCarcel = 5
        @@random = nil
        @@ultimoResultado = 1 #int
        @@debug = false #bool

        def initialize 
        end

        def tirar #int
            if (!@@debug)
                @@ultimoResultado = rand(1..6).floor
            end

            return @@ultimoResultado
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
            ran = rand(0...n)
            return ran
        end

        def setDebug(d)
            @@debug = d
            if (d)
                cadena = "El modo debug ha sido activado"
            else
                cadena = "El modo debug ha sido desactivado"
            end
            Diario.instance.ocurreEvento(cadena)
        end

        def ultimoResultado
            return @@ultimoResultado
        end

        def toString
            string="Salida carcel: "+@@SalidaCarcel.to_s
            string+=" Ultimo resultado: "+@@ultimoResultado.to_s
            string+=" Debug: "+@@debug.to_s
            return string
        end

    end
end
#Dado.instance para obtener la instancia