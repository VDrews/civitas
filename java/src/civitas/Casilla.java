package civitas;

import java.util.ArrayList;

public class Casilla {
    private String nombre;
    private static int carcel;
    private float importe;
    private TipoCasilla tipo;
    private TituloPropiedad tituloPropiedad;
    private Sorpresa sorpresa;
    private MazoSorpresas mazo;

    // Descanso
    Casilla(String nombre) {
        init();
        tipo = TipoCasilla.DESCANSO;
        this.nombre = nombre;
    }

    // Calle
    Casilla(TituloPropiedad titulo) {
        init();
        tipo = TipoCasilla.CALLE;
        tituloPropiedad = titulo;
        nombre = titulo.getNombre();
        importe = titulo.getPrecioCompra();
    }

    // Impuesto
    Casilla(float cantidad, String nombre) {
        init();
        tipo = TipoCasilla.IMPUESTO;
        this.nombre = nombre;
        importe = cantidad;
    }

    // Juez
    Casilla(int numCasillaCarcel, String nombre) {
        init();
        tipo = TipoCasilla.JUEZ;
        carcel = numCasillaCarcel;
        this.nombre = nombre;
    }

    // Sorpresa
    Casilla(MazoSorpresas mazo, String nombre) {
        init();
        tipo = TipoCasilla.SORPRESA;
        this.mazo = mazo;
        this.nombre = nombre;

    }

    public String getNombre() {
        return nombre;
    }

    TituloPropiedad getTituloPropiedad() {
        return tituloPropiedad;
    }

    private void init() {
        nombre = "";
        importe = 0;
    }

    private void informe(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto(actual, todos)) {
            Diario.getInstance().ocurreEvento(todos.get(actual).getNombre() + ": Casilla " + toString());
        }
    }

    public boolean jugadorCorrecto(int actual, ArrayList<Jugador> todos) {
        return actual >= 0 && actual < todos.size();
    }

    void recibeJugador(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto(actual, todos)) {
            informe(actual, todos);
            switch (tipo) {
            case CALLE:
                recibeJugador_calle(actual, todos);
                break;

            case IMPUESTO:
                recibeJugador_impuesto(actual, todos);
                break;

            case JUEZ:
                recibeJugador_juez(actual, todos);
                break;

            case SORPRESA:
                recibeJugador_sorpresa(actual, todos);
                break;

            default:
                break;
            }
        }
    }

    private void recibeJugador_calle(int actual, ArrayList<Jugador> todos) {
        Jugador jugador = todos.get(actual);
        if (!tituloPropiedad.tienePropietario()) {
            jugador.puedeComprarCasilla();
        } else {
            tituloPropiedad.tramitarAlquiler(jugador);
        }
    }

    private void recibeJugador_sorpresa(int actual, ArrayList<Jugador> todos) {
        sorpresa = mazo.siguiente();
        sorpresa.aplicarAJugador(actual, todos);
    }

    private void recibeJugador_impuesto(int actual, ArrayList<Jugador> todos) {
        todos.get(actual).pagaImpuesto(importe);
    }

    private void recibeJugador_juez(int actual, ArrayList<Jugador> todos) {
        todos.get(actual).encarcelar(carcel);
    }

    public String toString() {
        return "Casilla: " + nombre + "\nCarcel: " + carcel + "\nImporte: " + importe;
    }
}
