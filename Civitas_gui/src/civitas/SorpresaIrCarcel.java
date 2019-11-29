package civitas;

import java.util.ArrayList;

public class SorpresaIrCarcel extends Sorpresa {
    private Tablero tablero;
    SorpresaIrCarcel(Tablero tablero) {
        super("Carcel");
        this.tablero=tablero;
    }

    public void aplicarAJugador(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto(actual, todos)){
            informe(actual,todos);
            todos.get(actual).encarcelar(tablero.getCarcel());
        }
    }
}