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
            new(nil, nombre, TipoCasilla::DESCANSO, nil, nil, nil)
        end

        def self.newCalle(titulo)
            new(titulo.precioCompra, titulo.nombre, TipoCasilla::CALLE, titulo, nil, nil)            
        end

        def self.newImpuesto(cantidad, nombre)
            new(cantidad, nombre, TipoCasilla::IMPUESTO, nil, nil, nil)
        end

        def self.newJuez(numCasillaCarcel, nombre)
            new(nil, nombre, TipoCasilla::JUEZ, nil, nil, nil)
            @@carcel=numCasillaCarcel
        end

        def self.newSorpresa(mazo, nombre)
            new(nil, nombre, TipoCasilla::SORPRESA, nil, mazo, nil)
        end

        def informe(actual, todos)
            if (jugadorCorrecto(actual, todos)) 
                Diario.instance.ocurreEvento(todos[actual].nombre + ": Casilla " + toString())
            end
        end

        def toString
            return "Casilla: " + @nombre.to_s + "\nCarcel: " + @carcel.to_s + "\nImporte: " + @importe.to_s
        end

        def jugadorCorrecto(actual, todos)
            return actual >= 0 && actual < todos.length
        end

        def recibeJugador(actual, todos)
            case @tipo
            when TipoCasilla::CALLE
                recibeJugador_calle(actual, todos)
            when TipoCasilla::IMPUESTO
                recibeJugador_impuesto(actual, todos)
            when TipoCasilla::JUEZ
                recibeJugador_juez(actual, todos)
            when TipoCasilla::SORPRESA
                recibeJugador_sorpresa(actual, todos)
            else
                informe(actual, todos)
            end
        end

        private
        def recibeJugador_impuesto(actual, todos)
            todos[actual].pagaImpuesto(importe);
        end

        def recibeJugador_calle(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                jugador = todos[actual].clone

                if !@tituloPropiedad.tienePropietario(jugador)
                    jugador.puedeComprarCasilla
                else
                    @tituloPropiedad.tramitarAlquiler(nuevo)
                end
            end
        end

        def recibeJugador_juez(actual, todos)
            todos[actual].encarcelar
        end

        def recibeJugador_sorpresa(actual, todos)
            if jugadorCorrecto(actual, todos)
                sorpresa = mazo.siguiente
                informe(actual, todos)
                sorpresa.aplicarAJugador(actual, todos)
            end

        end

        private_class_method :new
        
    end
end