package civitas;

import java.util.ArrayList;
import java.util.Collection;


public class CivitasJuego {
    private int indiceJugadorActual;
    private ArrayList<Jugador> jugadores;
    private EstadosJuego estado;
    private GestorEstados gestorEstados;
    private Tablero tablero;
    private MazoSorpresas mazo;

    //Constructor
    public CivitasJuego(ArrayList<String> nombres) {
        jugadores = new ArrayList<Jugador>();
        for (int i = 0; i < nombres.size(); i++) {
            jugadores.add(new Jugador(nombres.get(i)));
        }

        gestorEstados = new GestorEstados();
        gestorEstados.estadoInicial();
        indiceJugadorActual = Dado.getInstance().quienEmpieza(nombres.size());
        mazo = new MazoSorpresas();
        tablero = new Tablero(10);
        inicializaTablero(mazo);
        inicializaMazoSopresas(tablero);

    }

    public void actualizarInfo() {
        System.out.println("Jugador: " + jugadores.get(indiceJugadorActual).toString());

        if (algunoEnBancarrota()) {
            ranking();
        }
    }

    private void inicializaTablero(MazoSorpresas mazo) {
        tablero = new Tablero(10);
        tablero.añadeCasilla(new Casilla(new TituloPropiedad("Calle 1", 120, 1.1f, 20000, 40000, 20000)));
        tablero.añadeCasilla(new Casilla(new TituloPropiedad("Calle 2", 120, 1.1f, 20000, 40000, 20000)));
        tablero.añadeCasilla(new Casilla(new TituloPropiedad("Calle 3", 120, 1.1f, 20000, 40000, 20000)));
        tablero.añadeCasilla(new Casilla(new TituloPropiedad("Calle 4", 120, 1.1f, 20000, 40000, 20000)));
        tablero.añadeCasilla(new Casilla(new TituloPropiedad("Calle 5", 120, 1.1f, 20000, 40000, 20000)));
        tablero.añadeCasilla(new Casilla(new TituloPropiedad("Calle 6", 120, 1.1f, 20000, 40000, 20000)));
        tablero.añadeCasilla(new Casilla(new TituloPropiedad("Calle 7", 120, 1.1f, 20000, 40000, 20000)));
        tablero.añadeCasilla(new Casilla(200.5f, "Peaje1")); //Impuesto
        tablero.añadeCasilla(new Casilla(200.5f, "Peaje2")); //Impuesto
        tablero.añadeCasilla(new Casilla(200.5f, "Peaje3")); //Impuesto
        tablero.añadeCasilla(new Casilla("Camping")); //Descanso
        tablero.añadeCasilla(new Casilla("Burger King")); //Descanso
        tablero.añadeCasilla(new Casilla(10, "Juez")); //Juez
        tablero.añadeCasilla(new Casilla(10, "Juez")); //Juez
        tablero.añadeCasilla(new Casilla(10, "Juez")); //Juez
        tablero.añadeCasilla(new Casilla(10, "Juez")); //Juez
        tablero.añadeCasilla(new Casilla(mazo, "Sorpresa1")); //Sorpresa
        tablero.añadeCasilla(new Casilla(mazo, "Sorpresa2")); //Sorpresa
        tablero.añadeCasilla(new Casilla(mazo, "Sorpresa3")); //Sorpresa
        tablero.añadeCasilla(new Casilla(mazo, "Sorpresa4")); //Sorpresa
        tablero.añadeCasilla(new Casilla(mazo, "Sorpresa5")); //Sorpresa

    }

    private void inicializaMazoSopresas(Tablero tablero) {
        mazo = new MazoSorpresas();

        mazo.alMazo(new Sorpresa(TipoSorpresa.IRCARCEL, tablero));
        mazo.alMazo(new Sorpresa(TipoSorpresa.SALIRCARCEL, tablero));
        mazo.alMazo(new Sorpresa(TipoSorpresa.IRCASILLA, tablero, 3, "Ir a casilla"));
        mazo.alMazo(new Sorpresa(TipoSorpresa.IRCASILLA, tablero, 6, "Ir a casilla"));
        mazo.alMazo(new Sorpresa(TipoSorpresa.IRCASILLA, tablero, 10, "Ir a casilla"));
        mazo.alMazo(new Sorpresa(TipoSorpresa.PORCASAHOTEL, tablero, 10, "Casa o hotel"));
        mazo.alMazo(new Sorpresa(TipoSorpresa.PORJUGADOR, tablero, 10, "Jugador"));
        mazo.alMazo(new Sorpresa(TipoSorpresa.PAGARCOBRAR, tablero, 10, "Pagar cobrar"));
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
        estado.siguienteEstado(getJugadorActual(), estado, operacion);
    }

    public boolean construirCasa(int ip) {
        return getJugadorActual().construirCasa(ip);
    }

    public boolean construirHotel(int ip) {
        return getJugadorActual().construirHotel(ip);
    }

    public void infoJugadorTexto() {

    }
    
    public boolean vender(int ip) {
        return jugador.vender(ip);
    }

    public boolean hipotecar(int ip) {
        return jugador.hipotecar(ip);
    }
    public boolean cancelarHipoteca(int ip) {
        return jugador.cancelarHipoteca(ip);
    }
    public boolean salirCarcelPagando(int ip) {
        return jugador.salirCarcelPagando(ip);
    }
    public boolean salirCarcelTirando(int ip) {
        return jugador.salirCarcelTirando(ip);
    }
    
    private boolean algunoEnBancarrota() {
        boolean enBancarrota = false;
        for (int i = 0; i < jugadores.size() && !enBancarrota; i++) {
            if (jugadores[i].enBancarrota()) {
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
        
        Collection.sort(jugadores_ordenados, new Comparable());

        return jugadores_ordenados;
    }

    //P3
    // private void avanzaJugador() {

    // }

     public OperacionesJuego siguientePaso() {

     }

    // public boolean comprar() {}
}