# encoding:utf-8
require './casilla'
require './dado'
require './estadosJuego'
# require './mazoSorpresas'
require './operacionesJuego'
require './tablero'

class TestP1


    def initialize
    end

    def main
        
        #QUIEN EMPIEZA -- COMPLETADO
        dado = Dado.instance
        testDado = [0,0,0,0]
        
        for i in 1..100 do
           testDado[dado.quienEmpieza(4)] += 1
        end
        
        puts testDado
        

        # PERFECTO
        for i in 1..20 do
            if (i % 2 == 0)
                dado.setDebug(true)
            else
                dado.setDebug(false)
            end

            dado.tirar
            puts dado.ultimoResultado
        end

        puts (dado.salgoDeLaCarcel) ? 'Salgo de la carcel' : 'No salgo de la carcel'
        
        
        
    end

end

testp1 = TestP1.new

testp1.main
