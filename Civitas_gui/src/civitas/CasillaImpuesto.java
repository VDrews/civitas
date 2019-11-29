package civitas;
import java.util.ArrayList;

public class CasillaImpuesto extends Casilla {
    private float importe;

    CasillaImpuesto(float cantidad, String nombre) {
        super(nombre);
        importe = cantidad;
    }

    @Override
    public void recibeJugador(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            todos.get(actual).pagaImpuesto(importe);
        }
    }
}