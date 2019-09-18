# encoding:utf-8
require 'singleton'
module Civitas
  module Operaciones_juego
    AVANZAR=:avanzar
    COMPRAR=:comprar
    GESTIONAR=:gestionar
    SALIR_CARCEL=:salir_carcel
    PASAR_TURNO=:pasar_turno
    
  end
  
    module Estados_juego
      INICIO_TURNO = :inicio_turno  
      DESPUES_CARCEL =:despues_carcel
  		DESPUES_AVANZAR = :despues_avanzar
  		DESPUES_COMPRAR =:despues_comprar
  		DESPUES_GESTIONAR =:despues_gestionar
  end
  
    class Tablero
      def initialize(indexCarcel)
        @numCasillaCarcel = indexCarcel >= 1 ? indexCarcel : 1
        @casillas = []
        @porSalida = 0
        @tieneJuez = false
        
        casillas.push(Casilla.new('Salida'))

      end
      
      def correcto(numCasilla = nil)
        if (numCasilla == nil)
          return casillas.length > numCasillaCarcel
        end
        
      elsif !(numCasilla < 0 || numCasilla > casillas.length)
          return true
        end
    end
    
    class Casilla
      def initialize(literal)
        @nombre = literal
      end
    end
end

puts "Hello World"
