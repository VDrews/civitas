package civitas;
import java.util.ArrayList;

public class CasillaImpuesto extends Casilla {
    private float importe;

    CasillaImpuesto(float cantidad, String nombre) {
        super(nombre);
        importe = cantidad;
    }

    public void recibeJugador(int actual, ArrayList<Jugador> todos) {
        todos.get(actual).pagaImpuesto(importe);
    }
}