require 'singleton'

class Diario
    include Singleton
    @@eventos = []

    def ocurreEvento(evento)
        @@eventos.push(evento)
    end



end

#Diario.instance para obtener la instancia