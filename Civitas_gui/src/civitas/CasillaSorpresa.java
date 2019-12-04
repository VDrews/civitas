package civitas;
import java.util.ArrayList;

public class CasillaSorpresa extends Casilla {
    private Sorpresa sorpresa;
    private MazoSorpresas mazo;
    CasillaSorpresa(MazoSorpresas mazo, String nombre) {
        super(nombre);
        this.mazo = mazo;
    }
    
    @Override
    public String getTipo(){
        return "Sorpresa";
    }

    @Override
    public void recibeJugador(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto(actual, todos)){
            informe(actual, todos);
            sorpresa = mazo.siguiente();
            sorpresa.aplicarAJugador(actual, todos);
        }
    }
}