require 'singleton'
module Civitas
  class Diario
    include Singleton

    def initialize
      @eventos = []
    end

    def ocurreEvento(e)
      @eventos << e
    end

    def eventosPendientes
      return (@eventos.length > 0)
    end

    def leerEvento
      e = @eventos.shift
      return e
    end

  end
end