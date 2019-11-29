package civitas;

import java.util.ArrayList;
import GUI.Dado;
import java.util.Collections;

public class CivitasJuego {
    private int indiceJugadorActual;
    private ArrayList<Jugador> jugadores;
    private EstadosJuego estado;
    private GestorEstados gestorEstados;
    private Tablero tablero;
    private MazoSorpresas mazo;

    // Constructor
    public CivitasJuego(ArrayList<String> nombres) {
        jugadores = new ArrayList<Jugador>();
        for (int i = 0; i < nombres.size(); i++) {
            jugadores.add(new Jugador(nombres.get(i)));
        }

        gestorEstados = new GestorEstados();
        estado=gestorEstados.estadoInicial();
        indiceJugadorActual = Dado.getInstance().quienEmpieza(nombres.size());
        mazo = new MazoSorpresas();
        inicializaTablero(mazo);
        inicializaMazoSopresas(tablero);

    }

    public void actualizarInfo() {
        System.out.println(infoJugadorTexto());

        if (algunoEnBancarrota()) {
            ranking();
        }
    }

    private void inicializaTablero(MazoSorpresas mazo) {
        tablero = new Tablero(4);
        // Implícito                                                                                            //Salida
        tablero.añadeCasilla(new CasillaCalle(new TituloPropiedad("Ladrón", 1.5f, -0.5f, 30f, 60f, 30f)));           //Calle 1.1
        tablero.añadeCasilla(new CasillaSorpresa(mazo, "Suerte"));                                                      // Sorpresa
        tablero.añadeCasilla(new CasillaCalle(new TituloPropiedad("Cloti", 2f, -0.5f, 45f, 70f, 45f)));              //Calle 1.2
        // Implícito                                                                                            //Cárcel
        tablero.añadeCasilla(new CasillaCalle(new TituloPropiedad("Tortu", 5f, 0f, 50f, 100f, 50f)));                //Calle 2.1
        tablero.añadeCasilla(new CasillaCalle(new TituloPropiedad("Pedro", 5f, 0f, 50f, 100f, 50f)));                //Calle 2.2
        tablero.añadeCasilla(new CasillaSorpresa(mazo, "Suerte"));                                                      //Sorpresa
        tablero.añadeCasilla(new CasillaCalle(new TituloPropiedad("Román", 7f, 0f, 75f, 150f, 75f)));                //Calle 2.3
        tablero.añadeCasilla(new Casilla("Parking"));                                                           //Descanso
        tablero.añadeCasilla(new CasillaCalle(new TituloPropiedad("Victor", 10f, 0.5f, 100f, 200f, 100f)));          //Calle 3.1
        tablero.añadeCasilla(new CasillaCalle(new TituloPropiedad("Aceituno", 10f, 0.5f, 100f, 200f, 100f)));        //Calle 3.2
        tablero.añadeCasilla(new CasillaSorpresa(mazo, "Suerte"));                                                      //Sorpresa
        tablero.añadeCasilla(new CasillaCalle(new TituloPropiedad("Juan Antonio", 12f, 0.5f, 125f, 250f, 125f)));    //Calle 3.3
        tablero.añadeJuez();                                                                                    //Juez
        tablero.añadeCasilla(new CasillaCalle(new TituloPropiedad("GOOOD", 15f, 1f, 150f, 300f, 150f)));             //Calle 4.1
        tablero.añadeCasilla(new CasillaCalle(new TituloPropiedad("Paco Pepe", 15f, 1f, 150f, 300f, 150f)));         //Calle 4.2
        tablero.añadeCasilla(new CasillaImpuesto(500f, "Hacienda somos todos"));                                        //Impuesto
        tablero.añadeCasilla(new CasillaCalle(new TituloPropiedad("Beñat", 25f, 1.5f, 200f, 400f, 200f)));           //Calle 5.1
        tablero.añadeCasilla(new CasillaCalle(new TituloPropiedad("Urrutikoetxea", 25f, 1.5f, 200f, 400f, 200f)));   //Calle 5.2
        
    }

    private void inicializaMazoSopresas(Tablero tablero) {

        mazo.alMazo(new SorpresaJugadorEspeculador(200));
        mazo.alMazo(new SorpresaIrCarcel(tablero));
        mazo.alMazo(new SorpresaSalirCarcel(mazo));
        mazo.alMazo(new SorpresaIrCasilla("A la casilla", tablero, 3));
        mazo.alMazo(new SorpresaIrCasilla("A la casilla", tablero, 6));
        mazo.alMazo(new SorpresaPagarCobrar("Paga", -70));
        mazo.alMazo(new SorpresaPagarCobrar("Cobra", 50));
        mazo.alMazo(new SorpresaPorJugador("Paga_jugador", -10));
        mazo.alMazo(new SorpresaPorJugador("Cobra_jugador", 10));
        mazo.alMazo(new SorpresaPorCasaHotel("Obras", -20));
        mazo.alMazo(new SorpresaPorCasaHotel("Casahotel", 25));
    }

    private void contabilizarPasosPorSalida(Jugador jugadorActual) {
        while (tablero.getPorSalida() > 0) {
            jugadorActual.pasaPorSalida();
        }
    }

    private void pasarTurno() {
        indiceJugadorActual = (indiceJugadorActual + 1) % jugadores.size();
    }

    public Casilla getCasillaActual() {
        return tablero.getCasilla(getJugadorActual().getNumCasillaActual());
    }

    public Jugador getJugadorActual() {
        return jugadores.get(indiceJugadorActual);
    }

    public void siguientePasoCompleado(OperacionesJuego operacion) {
        estado = gestorEstados.siguienteEstado(getJugadorActual(), estado, operacion);
    }

    public boolean construirCasa(int ip) {
        return getJugadorActual().construirCasa(ip);
    }

    public boolean construirHotel(int ip) {
        return getJugadorActual().construirHotel(ip);
    }

    public String infoJugadorTexto() {
        String s = "Jugador:\n" + jugadores.get(indiceJugadorActual).toString();
        return s;
    }

    public boolean vender(int ip) {
        return getJugadorActual().vender(ip);
    }

    public boolean hipotecar(int ip) {
        return getJugadorActual().hipotecar(ip);
    }

    public boolean cancelarHipoteca(int ip) {
        return getJugadorActual().cancelarHipoteca(ip);
    }

    public boolean salirCarcelPagando() {
        return getJugadorActual().salirCarcelPagando();
    }

    public boolean salirCarcelTirando() {
        return getJugadorActual().salirCarcelTirando();
    }

    private boolean algunoEnBancarrota() {
        boolean enBancarrota = false;
        for (int i = 0; i < jugadores.size() && !enBancarrota; i++) {
            if (jugadores.get(i).enBancarrota()) {
                enBancarrota = true;
            }
        }

        return enBancarrota;
    }

    public boolean finalDelJuego() {
        return algunoEnBancarrota();
    }

    private ArrayList<Jugador> ranking() {
        ArrayList<Jugador> jugadores_ordenados = new ArrayList<Jugador>(jugadores);

        Collections.sort(jugadores_ordenados);

        return jugadores_ordenados;
    }

    private void avanzaJugador() {
        Jugador jugadorActual = jugadores.get(indiceJugadorActual);
        int posicionActual = jugadorActual.getNumCasillaActual();
        int tirada = Dado.getInstance().tirar();
        int posicionNueva = tablero.nuevaPosicion(posicionActual, tirada);
        Casilla casilla = tablero.getCasilla(posicionNueva);
        contabilizarPasosPorSalida(jugadorActual);
        jugadorActual.moverACasilla(posicionNueva);
        casilla.recibeJugador(indiceJugadorActual, jugadores);
        contabilizarPasosPorSalida(jugadorActual);
    }

    public OperacionesJuego siguientePaso() {
        Jugador jugadorActual = getJugadorActual();
        OperacionesJuego operacion = gestorEstados.operacionesPermitidas(jugadorActual, estado);
        if (operacion == OperacionesJuego.PASAR_TURNO) {
            pasarTurno();
            siguientePasoCompleado(operacion);
        } else if (operacion == OperacionesJuego.AVANZAR) {
            avanzaJugador();
            siguientePasoCompleado(operacion);
        }
        return operacion;
    }

    public boolean comprar() {
        Jugador jugadorActual = getJugadorActual();
        int numCasillaActual = jugadorActual.getNumCasillaActual();
        CasillaCalle casilla = (CasillaCalle)tablero.getCasilla(numCasillaActual);
        TituloPropiedad titulo = casilla.getTituloPropiedad();
        boolean res = jugadorActual.comprar(titulo);
        return res;
    }
}