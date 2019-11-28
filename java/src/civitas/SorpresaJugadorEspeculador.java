package civitas;

public class SorpresaJugadorEspeculador extends Sorpresa {
    int fianza;
    Jugador jugador;

    SorpresaJugadorEspeculador(Jugador jugador, int fianza) {
        super("Sorpresa Jugador Especulador");
        this.fianza = fianza;
        this.jugador = jugador;
    }

    public void aplicarAJugador_salirCarcel(int actual, ArrayList<Jugador> todos) {
        jugador = new JugadorEspeculador(todos.get(actual), fianza);
        
    }
}