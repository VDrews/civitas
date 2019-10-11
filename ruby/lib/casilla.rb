module Civitas
    class Casilla
        
        @@carcel

        def initialize(importe, nombre, tipo, tituloPropiedad, mazo, sorpresa)
            @importe=importe
            @nombre=nombre
            @tipo=tipo
            @tituloPropiedad=tituloPropiedad
            @mazo=mazo
            @sorpresa=sorpresa
        end

        attr_reader :nombre, :tituloPropiedad

        def self.newDescanso(nombre)
            new(nil, nombre, DESCANSO, nil, nil, nil)
        end

        def self.newCalle(titulo)
            new(titulo.precioCompra, titulo.nombre, CALLE, titulo, nil, nil)            
        end

        def self.newImpuesto(cantidad, nombre)
            new(cantidad, nombre, IMPUESTO, nil, nil. nil)
        end

        def self.newJuez(numCasillaCarcel, nombre)
            new()
        end

        def self.newSorpresa(mazo, nombre)

        def informe

        end

        def toString

        end

        def jugadorCorrecto(actual, todos)

        end

        def recibeJugador(actual, todos)

        end

        private
        def recibeJugador_impuesto(actual, todos)
            
        end

        def recibeJugador_calle(actual, todos)
            
        end

        def recibeJugador_juez(actual, todos)
            
        end

        def recibeJugador_sprpresa(actual, todos)
            
        end
    end
end