package civitas;

public class SorpresaPagarCobrar extends Sorpresa {
    private int valor;

    SorpresaPagarCobrar(int valor, String texto) {
        super(texto);
        this.valor = valor;
    }
    public void aplicarAJugador(int actual, ArrayList<Jugador> todos) {
        todos.get(actual).modificarSaldo(valor);
    }
}