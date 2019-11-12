# encoding:utf-8
require_relative('vista_textual')
require_relative('civitas_juego')
require_relative('dado')
require_relative('controlador')


module Civitas

    class ProgramaPrincipal
        def initialize
        end

        def self.main
            vista = Vista_textual.new
            juego = CivitasJuego.new(["Java", "Ruby"])
            Dado.instance.setDebug(true)
            controlador = Controlador.new(juego, vista)

            controlador.juega
        end

    end

    ProgramaPrincipal.main

end
