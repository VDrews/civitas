package civitas;
import java.util.ArrayList;

public abstract class Sorpresa {
    protected String texto;

    Sorpresa(String texto) {
        this.texto = texto;
    }

    public boolean jugadorCorrecto(int actual, ArrayList<Jugador> todos) {
        return (actual >= 0 && actual < todos.size());
    }

    public abstract void aplicarAJugador(int actual, ArrayList<Jugador> todos);

    void informe(int actual, ArrayList<Jugador> todos) {
        Diario.getInstance().ocurreEvento("Se está aplicando una sorpresa a: " + todos.get(actual).getNombre());
    }
}