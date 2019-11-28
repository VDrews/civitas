package civitas;
import java.util.ArrayList;

public class CasillaCalle extends Casilla {
    private TituloPropiedad tituloPropiedad;
    private float importe;

    CasillaCalle(TituloPropiedad titulo) {
        super(titulo.getNombre());
        tituloPropiedad = titulo;
        importe = titulo.getPrecioCompra();
    }

    public void recibeJugador(int actual, ArrayList<Jugador> todos) {
        Jugador jugador = todos.get(actual);
        if (!tituloPropiedad.tienePropietario()) {
            jugador.puedeComprarCasilla();
        } else {
            tituloPropiedad.tramitarAlquiler(jugador);
        }
    }

    TituloPropiedad getTituloPropiedad() {
        return tituloPropiedad;
    }
}