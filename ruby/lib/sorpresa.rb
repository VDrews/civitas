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
            if(@tipo=IRCARCEL)
                aplicarAJugador_irCarcel(actual, todos)
            end

            if(@tipo=IRCASILLA)
                aplicarAJugador_irACasilla(actual, todos)
            end

            if(@tipo=PAGARCOBRAR)
                aplicarAJugador_pagarCobrar(actual, todos)
            end

            if(@tipo=SALIRCARCEL)
                aplicarAJugador_salirCarcel(actual, todos)
            end

            if(@tipo=PORCASAHOTEL)
                aplicarAJugador_porCasaHotel(actual, todos)
            end

            if(@tipo=PORJUGADOR)
                aplicarAJugador_porJugador(actual, todos)
            end
            
        end

        private
        def aplicarAJugador_irACasilla(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                tirada=Tablero::calcularTirada(todos[actual].casillaActual, @valor)
                nueva_pos=Tablero::nuevaPosicion(todos[actual].casillaActual, tirada)
                todos[actual].moverACasilla(nueva_pos)
                Casilla::recibeJugador(actual, todos)
            end

        end

        def aplicarAJugador_irCarcel(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                todos[actual].encarcelar
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
                todos[actual].modificarSaldo(@valor*todos[actual].numCasasHoteles)
            end
        end

        def aplicarAJugador_porJugador(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                sorpresa=new(tipo:PAGARCOBRAR, valor:@valor*-1)
                for i in todos do
                    if i!=actual
                        sorpresa.aplicarAJugador(i, todos)
                    end
                end

                sorpresa=new(tipo:PAGARCOBRAR, valor:@valor*(todos.length-1))
                sorpresa.aplicarAJugador(actual, todos)
            end
        end

        def aplicarAJugador_salirCarcel(actual, todos)
            if jugadorCorrecto(actual, todos)
                informe(actual, todos)
                tiene=false
                for i in todos do
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
            Diario.instance.ocurre_evento("Se aplica sorpresa " + @tipo + " a "+ todos[actual])
        end

        public
        def jugadorCorrecto (actual, todos)
            return (actual>=0&&actual<=todos.length)
        end

        def salirDelMazo
            if (@tipo=SALIRCARCEL)
                MazoSorpresas::inhabilitarCartaEspecial(self)
            end
        end

        def toString
            return "Texto: "+@texto.to_s
        end

        def usada
            if (@tipo=SALIRCARCEL)
                MazoSorpresas::habilitarCartaEspecial(self)
            end
        end

    end
end