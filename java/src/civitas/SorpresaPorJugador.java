package civitas;

public class SorpresaPorJugador extends Sorpresa {
    private int valor;

    SorpresaPorJugador(int valor, String texto) {
        super(texto);
        this.valor = valor;
    }
    

    public void aplicarAJugador(int actual, ArrayList<Jugador> todos) {
        Sorpresa s1 = new SorpresaPagarCobrar(valor * -1, "Quita");
        for (int i = 0; i < todos.size(); i++) {
            if (i != actual)
                s1.aplicarAJugador(i, todos);
        }

        Sorpresa s2 = new SorpresaPagarCobrar(valor * (todos.size() - 1), "Pon");
        s2.aplicarAJugador(actual, todos);
    }
}