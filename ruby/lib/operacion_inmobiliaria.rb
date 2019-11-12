module Civitas
    class OperacionInmobiliaria
        
        def initialize(gest, ip)
            @numPropiedad = ip #int
            @gestion = gest #gestionesinmobiliarias
        end

        attr_reader :numPropiedad, :gestion

    end
end