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
  
  class Diario
    include Singleton
    
    def initialize
      @eventos=[]
    end
    
    def ocurre_evento(e)
      @eventos << e
    end
    
    def eventos_pendientes
      return (@eventos.length > 0)
    end
    
    def
  end
end

puts "Hello World"
