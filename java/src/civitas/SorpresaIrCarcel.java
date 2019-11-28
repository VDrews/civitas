package civitas;

public class SorpresaIrCarcel extends Sorpresa {
    SorpresaIrCarcel(int valor, String texto) {
        super(texto);
        this.valor = valor;
    }

    private void aplicarAJugador(int actual, ArrayList<Jugador> todos) {
        todos.get(actual).encarcelar(valor);
    }
}