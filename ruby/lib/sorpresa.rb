require_relative("mazo_sorpresas")
require_relative("tipo_sorpresa")
module Civitas
    class Sorpresa

        def initialize(mazo:nil, tipo:, tablero:nil, valor:-1, texto:nil)
            @mazo=mazo
            @tipo=tipo
            @tablero=tablero
            @valor=valor
            @texto=texto
        end

        def aplicarAJugador(actual, todos)
            case @tipo
            when TipoSorpresa::IRCARCEL
                aplicarAJugador_irCarcel(actual, todos)
            when TipoSorpresa::IRCASILLA
                aplicarAJugador_irACasilla(actual, todos)
            when TipoSorpresa::PAGARCOBRAR
                aplicarAJugador_pagarCobrar(actual, todos)
            when TipoSorpresa::SALIRCARCEL
                aplicarAJugador_salirCarcel(actual, todos)
            when TipoSorpresa::PORCASAHOTEL
                aplicarAJugador_porCasaHotel(actual, todos)
            when TipoSorpresa::PORJUGADOR
                aplicarAJugador_porJugador(actual, todos)
            end
            
        end

        private
        def aplicarAJugador_irACasilla(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                puts "CASILLAACTUAL: #{todos[actual].getNumCasillaActual}"
                puts "VALOR: #{@valor}"
                tirada = @tablero.calcularTirada(todos[actual].getNumCasillaActual, @valor)
                nueva_pos = @tablero.nuevaPosicion(todos[actual].getNumCasillaActual, tirada)
                todos[actual].moverACasilla(nueva_pos)
                puts "NUEVA POS: #{nueva_pos}"
                @tablero.getCasilla(nueva_pos).recibeJugador(actual, todos)
            end

        end

        def aplicarAJugador_irCarcel(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                todos[actual].encarcelar(@tablero.getCarcel) # Arreglar esto
            end
        end

        def aplicarAJugador_pagarCobrar(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual,todos)
                todos[actual].modificarSaldo(@valor)
            end
        end

        def aplicarAJugador_porCasaHotel(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                todos[actual].modificarSaldo(@valor*todos[actual].cantidadCasasHoteles)
            end
        end

        def aplicarAJugador_porJugador(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                sorpresa= Sorpresa.new(tipo:TipoSorpresa::PAGARCOBRAR, valor:@valor*-1)
                for i in 0...todos.size do
                    if i!=actual
                        sorpresa.aplicarAJugador(i, todos)
                    end
                end

                sorpresa= Sorpresa.new(tipo:TipoSorpresa::PAGARCOBRAR, valor:@valor*(todos.length-1))
                sorpresa.aplicarAJugador(actual, todos)
            end
        end

        def aplicarAJugador_salirCarcel(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                tiene=false
                for i in 0...todos.size do
                    tiene=todos[i].tieneSalvoConducto
                    if tiene
                        break
                    end
                end
                if !tiene
                    todos[actual].obtenerSalvoconducto(self)
                    self.salirDelMazo
                end
            end
        end

        def informe(actual, todos)
            Diario.instance.ocurreEvento("Se aplica sorpresa " + @tipo.to_s + " a "+ todos[actual].nombre)
        end

        public
        def jugadorCorrecto (actual, todos)
            return (actual >= 0 && actual <= todos.length)
        end

        def salirDelMazo
            if (@tipo == TipoSorpresa::SALIRCARCEL)
                @mazo.inhabilitarCartaEspecial(self)
            end
        end

        def toString
            return "Texto: "+@texto.to_s
        end

        def usada
            if (@tipo == TipoSorpresa::SALIRCARCEL)
                @mazo.habilitarCartaEspecial(self)
            end
        end

    end
end