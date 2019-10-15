# encoding:utf-8
require_relative('casilla')
require_relative('dado')
require_relative('estados_juego')
require_relative('tipo_sorpresa')
require_relative('titulo_propiedad')
require_relative('mazo_sorpresas')
require_relative('operaciones_juego')
require_relative('civitas_juego')
require_relative('tablero')

module Civitas

    class TestP1
        def initialize
        end

        def main
            #QUIEN EMPIEZA -- COMPLETADO
            # dado = Dado.instance
            # testDado = [0,0,0,0]
            
            # for i in 1..100 do
            #    testDado[dado.quienEmpieza(4)] += 1
            # end
            
            # puts testDado
            

            # PERFECTO
            # for i in 1..20 do
            #     if (i % 2 == 0)
            #         dado.setDebug(true)
            #     else
            #         dado.setDebug(false)
            #     end

            #     dado.tirar
            #     puts dado.ultimoResultado
            # end

            # puts (dado.salgoDeLaCarcel) ? 'Salgo de la carcel' : 'No salgo de la carcel'
            
            puts "Mi clase main:"
        #PRUEBA 2
        
            titu = TituloPropiedad.new("hoa", 20, 21, 22, 23, 24)
            # puts titu.to_ss
            # puts
            puts TipoSorpresa::IRCARCEL
            tablero = Tablero.new(10)
            newcarcel = Sorpresa.new(tipo: TipoSorpresa::IRCARCEL, tablero: tablero)
            puts newcarcel.toString()
            
            newotracasilla = Sorpresa.new(tipo: TipoSorpresa::IRCASILLA, tablero: tablero, valor: 100, texto: "VACIO")
            puts newotracasilla.toString()
            
            newresto = Sorpresa.new(tipo: TipoSorpresa::PAGARCOBRAR, valor: 100, texto: "Vacio")
            puts newresto.toString()
            
            mazo = MazoSorpresas.new(false)
            newevita = Sorpresa.new(tipo: TipoSorpresa::SALIRCARCEL, mazo: mazo)
            puts newevita.toString
            puts
            nombre = ["jug1","jug2","jug3","jug4"]
            civi = CivitasJuego.new(nombre)
            #puts civi.toString()
            civi.inicializaTablero(mazo)
            civi.inicializaMazoSorpresas(tablero)
            
        end

    end

    testp1 = TestP1.new

    testp1.main

end
