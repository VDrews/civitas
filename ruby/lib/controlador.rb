module Civitas
    class Controlador
        def initialize(juego, vista)
            @juego = juego #CivitasJuego
            @vista = vista #VistaTextual
        end

        def juega #void
            
            @vista.setCivitasJuego(@juego)

            isFinal = @juego.finalDelJuego()
            while !isFinal
                @vista.pausa
                siguientePaso = @juego.siguientePaso
                @vista.mostrarSiguienteOperacion(siguientePaso)
                
                
                if (siguientePaso != "PASAR_TURNO")
                    @vista.mostrarEventos
                end
                
                isFinal = @juego.finalDelJuego()

                if (!isFinal)
                    puts siguientePaso.inspect

                    case siguientePaso
                    when Operaciones_juego::COMPRAR
                        if (@vista.comprar == Respuestas::SI)
                            @juego.comprar
                            @juego.siguientePasoCompletado(Operaciones_juego::COMPRAR)
                        end
                    when Operaciones_juego::GESTIONAR
                        @vista.gestionar
                        operacionInmobiliaria = OperacionInmobiliaria.new(@vista.getGestion, @vista.getPropiedad)
                        @juego.siguientePasoCompletado(Operaciones_juego::GESTIONAR)

                        if @vista.getGestion == 6
                            @juego.siguientePasoCompletado(Operaciones_juego::TERMINAR)
                        end

                    when Operaciones_juego::SALIR_CARCEL
                        if (@vista.salirCarcel == SalidasCarcel::PAGANDO)
                            @juego.salirCarcelPagando()
                        else
                            @juego.salirCarcelTirando()
                        end
                        @juego.siguientePasoCompletado(Operaciones_juego::SALIR_CARCEL)
                        
                    else
                        puts "No esta entrando por ningún lao" 
                    end
                end     
            end       
        end
    end
end