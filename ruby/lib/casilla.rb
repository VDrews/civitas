require_relative('tipo_casilla')
require_relative('sorpresa')
require_relative('mazo_sorpresas')
require_relative('jugador')
require_relative('titulo_propiedad')

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
            new(0, nombre, TipoCasilla::DESCANSO, nil, nil, nil)
        end

        def self.newCalle(titulo)
            new(titulo.precioCompra, titulo.nombre, TipoCasilla::CALLE, titulo, nil, nil)            
        end

        def self.newImpuesto(cantidad, nombre)
            new(cantidad, nombre, TipoCasilla::IMPUESTO, nil, nil, nil)
        end

        def self.newJuez(numCasillaCarcel, nombre)
            @@carcel=numCasillaCarcel
            new(0, nombre, TipoCasilla::JUEZ, nil, nil, nil)
            
        end

        def self.newSorpresa(mazo, nombre)
            new(0, nombre, TipoCasilla::SORPRESA, nil, mazo, nil)
        end

        def informe(actual, todos)
            if (jugadorCorrecto(actual, todos)) 
                Diario.instance.ocurreEvento(todos[actual].nombre + ": Casilla " + toString())
            end
        end

        def toString
            return "\nCasilla: " + @nombre.to_s + "\nCarcel: " + @@carcel.to_s + "\nImporte: " + @importe.to_s
        end

        def jugadorCorrecto(actual, todos)
            return actual >= 0 && actual < todos.length
        end

        def recibeJugador(actual, todos)
            if (jugadorCorrecto(actual, todos))
                informe(actual, todos)
                case @tipo
                when TipoCasilla::CALLE
                    recibeJugador_calle(actual, todos)
                when TipoCasilla::IMPUESTO
                    recibeJugador_impuesto(actual, todos)
                when TipoCasilla::JUEZ
                    recibeJugador_juez(actual, todos)
                when TipoCasilla::SORPRESA
                    recibeJugador_sorpresa(actual, todos)
                end
            end
        end

        private
        def recibeJugador_calle(actual, todos)
            jugador = todos[actual]
            if !@tituloPropiedad.tienePropietario()
                jugador.puedeComprarCasilla
            else
                @tituloPropiedad.tramitarAlquiler(jugador)
            end
        end

        def recibeJugador_sorpresa(actual, todos)
            @sorpresa = @mazo.siguiente
            @sorpresa.aplicarAJugador(actual, todos)
        end

        def recibeJugador_impuesto(actual, todos)
            todos[actual].pagaImpuesto(@importe);
        end


        def recibeJugador_juez(actual, todos)
            todos[actual].encarcelar(@@carcel)
        end


        private_class_method :new
        
    end
end