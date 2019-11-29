package civitas;

import java.util.ArrayList;

public class SorpresaJugadorEspeculador extends Sorpresa {
    private int fianza;

    SorpresaJugadorEspeculador(int fianza) {
        super("Jugador Especulador");
        this.fianza = fianza;
    }

    public void aplicarAJugador(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            JugadorEspeculador jugador=new JugadorEspeculador(todos.get(actual), fianza);
            todos.remove(actual);
            todos.add(actual, jugador);
        }
    }
}