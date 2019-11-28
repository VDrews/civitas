package civitas;

public class SorpresaPorCasaHotel extends Sorpresa {
    private int valor;

    SorpresaPorCasaHotel(int valor, String texto) {
        super(texto);
        this.valor = valor;
    }
    
    public void aplicarAJugador(int actual, ArrayList<Jugador> todos) {
        todos.get(actual).modificarSaldo(valor * todos.get(actual).cantidadCasasHoteles());
    }
}