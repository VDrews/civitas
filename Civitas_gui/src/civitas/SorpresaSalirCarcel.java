package civitas;
import java.util.ArrayList;

public class SorpresaSalirCarcel extends Sorpresa {
    private MazoSorpresas mazo;

    SorpresaSalirCarcel(MazoSorpresas mazo) {
        super("Salir de la carcel");
        this.mazo = mazo;
    }

    public void aplicarAJugador(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto(actual, todos)){
            informe(actual,todos);
            boolean alguienTieneSalvoConducto = false;
            for (int i = 0; i < todos.size() && !alguienTieneSalvoConducto; i++) {
                if (todos.get(i).tieneSalvoconducto()) {
                    alguienTieneSalvoConducto = true;
                }

                if (!alguienTieneSalvoConducto) {
                    todos.get(actual).obtenerSalvoconducto(this);
                    salirDelMazo();
                }
            }
        }
    }

    void salirDelMazo() {
        mazo.inhabilitarCartaEspecial(this);
    }

    void usada() {
        mazo.habilitarCartaEspecial(this);
    }
}