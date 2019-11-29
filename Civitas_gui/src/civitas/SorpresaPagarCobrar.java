package civitas;

import java.util.ArrayList;

public class SorpresaPagarCobrar extends Sorpresa {
    private int valor;

    SorpresaPagarCobrar(String texto, int valor) {
        super(texto);
        this.valor = valor;
    }
    public void aplicarAJugador(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto(actual, todos)){
            informe(actual,todos);
            todos.get(actual).modificarSaldo(valor);
        }
    }
}