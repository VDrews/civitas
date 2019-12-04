package civitas;
import java.util.ArrayList;

public class CasillaJuez extends Casilla {
    private static int carcel;
    CasillaJuez(int numCasillaCarcel, String nombre) {
        super(nombre);
        carcel = numCasillaCarcel;
    }
    
    @Override
    public String getTipo(){
        return "Juez";
    }

    @Override
    public void recibeJugador(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            todos.get(actual).encarcelar(carcel);
        }
    }
}