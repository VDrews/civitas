module Civitas
    class Controlador
        def initialize(juego, vista)
            @juego = juego #CivitasJuego
            @vista = vista #VistaTextual
        end

        def juega #void
            @vista.setCivitasJuego(@juego)
            @vista.pausa
            siguientePaso = @vista.mostrarSiguienteOperacion(@juego.siguientePaso)
            
            if (siguientePaso != "PASAR_TURNO")
                @vista.mostrarEventos
            end

            isFinal = @juego.finalDelJuego()

            if (!isFinal)
                case siguientePaso
                when "COMPRAR"
                    if (vista.comprar == RESPUESTAS::SI)
                        juego.comprar
                        juego.siguientePasoCompletado(OperacionesJuego::COMPRAR)
                    end
                when "GESTIONAR"
                    vista.gestionar
                    operacionInmobiliaria = OperacionInmobiliaria.new(vista.getGestion, vista.getPropiedad)
                    juego.siguientePasoCompletado(OperacionesJuego::GESTIONAR)

                when "TERMINAR"
                    juego.siguientePasoCompletado(OperacionesJuego::TERMINAR)

                when "SALIR_CARCEL"
                    if (vista.salirCarcel == SalidasCarcel::PAGANDO)
                        juego.salirCarcelPagando()
                    else
                        juego.salirCarcelTirando()
                    end
                    juego.siguientePasoCompletado(OperacionesJuego::SALIR_CARCEL)
                    
                end
            else
                juego.ranking
            end            
        end
    end
end