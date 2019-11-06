#encoding:utf-8
require_relative 'operaciones_juego'
require_relative 'salidas_carcel'
require 'io/console'

module Civitas

  class Vista_textual
    #Actualizar vista 
    #Controlador::Juega
    def initialize
      @in
      @iPropiedad = 0
      @iGestion = 0
      @juegoModel
    end

    def mostrar_estado(estado)
      puts estado
    end

    
    def pausa
      print "Pulsa una tecla"
      gets
      print "\n"
    end

    def lee_entero(max,msg1,msg2)
      ok = false
      begin
        print msg1
        cadena = gets.chomp
        begin
          if (cadena =~ /\A\d+\Z/)
            numero = cadena.to_i
            ok = true
          else
            raise IOError
          end
        rescue IOError
          puts msg2
        end
        if (ok)
          if (numero >= max)
            ok = false
          end
        end
      end while (!ok)

      return numero
    end



    def menu(titulo,lista)
      tab = "  "
      puts titulo
      index = 0
      lista.each { |l|
        puts tab+index.to_s+"-"+l
        index += 1
      }

      opcion = lee_entero(lista.length,
                          "\n"+tab+"Elige una opción: ",
                          tab+"Valor erróneo")
      return opcion
    end

    def salirCarcel
      lista_Respuestas = [SalidasCarcel::PAGANDO, SalidasCarcel::TIRANDO]
      return lista_Respuestas[menu("¿Cómo quieres salir de la cárcel?", ["PAGANDO", "TIRANDO"])]
    end
    
    def comprar
      lista_Respuestas = [Respuestas::NO, Respuestas::Si]
      return lista_Respuestas[menu("¿Quieres comprar la calle?", ["NO", "SI"])]
    end

    def gestionar
      @iGestion = menu("Número de gestión de inmobiliaria", ["VENDER", "HIPOTECAR", "CANCELAR_HIPOTECA", "CONSTRUIR_CASA", "CONSTRUIR_CASA", "CONSTRUIR_HOTEL", "TERMINAR"])
      @iPropiedad = menu("Número de la propiedad", @juego.getJugadorActual.propiedades)
    end

    def getGestion
      return @iGestion
    end

    def getPropiedad
      return @iPropiedad
    end

    def mostrarSiguienteOperacion(operacion)
      case operacion
      when Operaciones_juego::PASAR_TURNO
        puts "PASAR_TURNO"
      when Operaciones_juego::SALIR_CARCEL
        puts "SALIR_CARCEL"
      when Operaciones_juego::AVANZAR
        puts "AVANZAR"
      when Operaciones_juego::COMPRAR
        puts "COMPRAR"
      when Operaciones_juego::GESTIONAR
        puts "GESTIONAR"
      end

    end

    def mostrarEventos
      while Diario.instance.eventosPendientes
        puts Diario.instance.leerEvento
      end
    end

    def setCivitasJuego(civitas)
         @juegoModel=civitas
         self.actualizarVista
    end

    def actualizarVista
      @juegoModel.infoJugadorTexto
    end

    
  end

end
