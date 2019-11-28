package civitas;
import java.util.ArrayList;

public class CasillaJuez extends Casilla {
    private static int carcel;
    CasillaJuez(int numCasillaCarcel, String nombre) {
        super(nombre);
        carcel = numCasillaCarcel;
    }

    public void recibeJugador(int actual, ArrayList<Jugador> todos) {
        todos.get(actual).encarcelar(carcel);
    }
}