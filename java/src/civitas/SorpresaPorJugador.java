package civitas;

import java.util.ArrayList;

public class SorpresaPorJugador extends Sorpresa {
    private int valor;

    SorpresaPorJugador(String texto, int valor) {
        super(texto);
        this.valor = valor;
    }
    

    public void aplicarAJugador(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto(actual, todos)){
            informe(actual,todos);
            Sorpresa s1 = new SorpresaPagarCobrar("Quita", valor * -1);
            for (int i = 0; i < todos.size(); i++) {
                if (i != actual)
                    s1.aplicarAJugador(i, todos);
            }

            Sorpresa s2 = new SorpresaPagarCobrar("Pon", valor * (todos.size() - 1));
            s2.aplicarAJugador(actual, todos);
        }
    }
}