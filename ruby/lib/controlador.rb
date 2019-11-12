require_relative('operacion_inmobiliaria')
require_relative('gestiones_inmobiliarias')

module Civitas
    class Controlador
        def initialize(juego, vista)
            @juego = juego #CivitasJuego
            @vista = vista #VistaTextual
        end

        def juega #void
            
            @vista.setCivitasJuego(@juego)

            isFinal = @juego.finalDelJuego()
            while !isFinal do
                @vista.pausa
                siguientePaso = @juego.siguientePaso
                @vista.mostrarSiguienteOperacion(siguientePaso)
                
                
                if (siguientePaso != Operaciones_juego::PASAR_TURNO)
                    @vista.mostrarEventos
                end
                
                isFinal = @juego.finalDelJuego()

                if (!isFinal)
                    puts siguientePaso.inspect

                    case siguientePaso
                    when Operaciones_juego::COMPRAR
                        if (@vista.comprar == Respuestas::SI)
                            @juego.comprar
                        end
                        @juego.siguientePasoCompletado(Operaciones_juego::COMPRAR)
                                                            
                    when Operaciones_juego::GESTIONAR
                        @vista.gestionar
                        operacion = OperacionInmobiliaria.new(@vista.getGestion, @vista.getPropiedad)
                        ip=operacion.numPropiedad

                        case operacion.gestion
                        when GestionesInmobiliarias::VENDER
                            @juego.vender(ip)
                        when GestionesInmobiliarias::HIPOTECAR
                            @juego.hipotecar(ip)
                        when GestionesInmobiliarias::CANCELAR_HIPOTECA
                            @juego.cancelarHipoteca(ip)
                        when GestionesInmobiliarias::CONSTRUIR_CASA
                            @juego.construirCasa(ip)
                        when GestionesInmobiliarias::CONSTRUIR_HOTEL
                            @juego.construirHotel(ip)
                        end
                        @juego.siguientePasoCompletado(Operaciones_juego::GESTIONAR)
                                       
                    when Operaciones_juego::SALIR_CARCEL
                        
<<<<<<< HEAD
                    else
                        puts "No esta entrando por ningún lado" 
=======
                        case @vista.salirCarcel
                        when SalidasCarcel::PAGANDO
                            @juego.salirCarcelPagando
                            @juego.siguientePasoCompletado(Operaciones_juego::SALIR_CARCEL)
                        when SalidasCarcel::TIRANDO
                            @juego.salirCarcelTirando
                            @juego.siguientePasoCompletado(Operaciones_juego::SALIR_CARCEL)
                        end
>>>>>>> 5011d6f146ad65ecc16fa8dfe38d54b2def790d4
                    end
                    @vista.actualizarVista
                else
                    @juego.actualizarInfo
                end
            end       
        end
    end
end