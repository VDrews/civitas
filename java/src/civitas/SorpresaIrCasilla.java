package civitas;

public class SorpresaIrCasilla extends Sorpresa {
    private Tablero tablero;
    private int valor;

    SorpresaIrCasilla(TipoSorpresa tipo, Tablero tablero, int valor, String texto) {
        super(texto);
        this.tablero = tablero;
        this.valor = valor;
    }

    private void aplicarAJugador(int actual, ArrayList<Jugador> todos) {
        int tirada = tablero.calcularTirada(todos.get(actual).getNumCasillaActual(), valor);
        int numCasilla = tablero.nuevaPosicion(todos.get(actual).getNumCasillaActual(), tirada);
        todos.get(actual).moverACasilla(numCasilla);
        tablero.getCasilla(valor).recibeJugador(actual, todos);
    }
}