# encoding:utf-8
require './casilla'
require './dado'
require './estados_juego'
require './tipo_sorpresa'
require './titulo_propiedad'
require './mazo_sorpresas'
require './operaciones_juego'
require './tablero'

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
    
        # titu = TituloPropiedad.new("hoa", 20, 21, 22, 23, 24)
        # puts titu.to_ss
        # puts
        puts TipoSorpresa::IRCARCEL
        tablero = Tablero.new(10)
        newcarcel = Sorpresa.new_carcel(TipoSorpresa::IRCARCEL,tablero)
        puts newcarcel.to_ss
        
        newotracasilla = Sorpresa.new_otraCasilla(TipoSorpresa::IRCASILLA, tablero, 100, "VACIO")
        puts newotracasilla.to_ss
        
        newresto = Sorpresa.new_resto(TipoSorpresa::PAGARCOBRAR, 100, "Vacio")
        puts newresto.to_ss
        
        mazo = MazoSorpresas.new(false)
        newevita = Sorpresa.new_evitaCarcel(TipoSorpresa::SALIRCARCEL, mazo)
        puts newevita.to_ss
        puts
        newnombre = Casilla.new_nombre("vacio")
        puts newnombre.to_ss
        #titu = TituloPropiedad.new("hoa", 20, 21, 22, 23, 24)
        puts
        newtitulo = Casilla.new_titulo(titu)
        puts newtitulo.to_ss
        puts
        newcantidad = Casilla.new_cantidad("vacio", 100.5)
        puts newcantidad.to_ss
        puts
        newcarcel = Casilla.new_carcel("Vacio", 14)
        puts newcarcel.to_ss
        puts
        #mazo = MazoSorpresas.new(false)
        newmazo = Casilla.new_mazo("vacio", mazo)
        puts newmazo.to_ss
        puts
        puts
        newjugador = Jugador.new_jugador("antonio")
        puts newjugador.to_ss
        #puts newjugador
        puts
        newotro = Jugador.new_otro(newjugador)
        puts newotro.to_ss
        #puts newotro
        puts
        nombre = ["jug1","jug2","jug3","jug4"]
        civi = CivitasJuego.new(nombre)
        puts civi.to_ss
        
    end

end

testp1 = TestP1.new

testp1.main
