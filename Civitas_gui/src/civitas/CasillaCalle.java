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
    
    @Override
    public float getImporte(){
        return importe;
    }

    public TituloPropiedad getTituloPropiedad(){
        return tituloPropiedad;
    }
    
    @Override
    public String getTipo(){
        return "Calle";
    }

    @Override
    public void recibeJugador(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            Jugador jugador = todos.get(actual);
            if (!tituloPropiedad.tienePropietario()) {
                jugador.puedeComprarCasilla();
            } else {
                tituloPropiedad.tramitarAlquiler(jugador);
            }
        }
    }
}