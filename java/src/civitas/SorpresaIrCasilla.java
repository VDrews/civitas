package civitas;

import java.util.ArrayList;

public class SorpresaIrCasilla extends Sorpresa {
    private Tablero tablero;
    private int valor;

    SorpresaIrCasilla(String texto, Tablero tablero, int valor) {
        super(texto);
        this.tablero = tablero;
        this.valor = valor;
    }

    public void aplicarAJugador(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto(actual, todos)){
            informe(actual,todos);
            int tirada = tablero.calcularTirada(todos.get(actual).getNumCasillaActual(), valor);
            int numCasilla = tablero.nuevaPosicion(todos.get(actual).getNumCasillaActual(), tirada);
            todos.get(actual).moverACasilla(numCasilla);
            tablero.getCasilla(valor).recibeJugador(actual, todos);
        }
    }
}