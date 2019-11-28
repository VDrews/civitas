package civitas;
import java.util.ArrayList;

public class Casilla {
    protected String nombre;

    public Casilla() {
        nombre = "";
    }

    public Casilla(String nombre) {
        this.nombre = nombre;
    }

    public String getNombre() {
        return nombre;
    }

    private void informe(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto(actual, todos)) {
            Diario.getInstance().ocurreEvento(todos.get(actual).getNombre() + ": Casilla " + toString());
        }
    }

    public boolean jugadorCorrecto(int actual, ArrayList<Jugador> todos) {
        return actual >= 0 && actual < todos.size();
    }

    public String toString() {
        return "Casilla: " + nombre;
    }

    public void recibeJugador(int actual, ArrayList<Jugador> todos) {
        informe(actual, todos);
    }
}