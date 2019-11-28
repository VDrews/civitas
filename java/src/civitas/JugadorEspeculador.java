package civitas;
import java.util.ArrayList;

public class JugadorEspeculador extends Jugador {
    private static int factorEspeculador;
    private int fianza;

    JugadorEspeculador(Jugador jugador, int fianza) {
        super(jugador);
        factorEspeculador = 2;
        this.fianza = fianza;

        for (int i = 0; i < propiedades.size(); i++) {
            propiedades.get(i).actualizaPropietarioPorConversion(this);
        }
    }

    @override
    protected int getCasasMax() {
        return CasasMax * factorEspeculador;
    }

    @override
    protected int getHotelesMax() {
        return HotelesMax * factorEspeculador;
    }

    @override
    protected boolean debeSerEncarcelado() {
        if (encarcelado) {
            return false;
        }

        else if (tieneSalvoconducto()) {
            perderSalvoconducto();
            Diario.getInstance().ocurreEvento("El jugador " + nombre + " ha perdido su salvoconducto");
            return false;
        }

        else {
            if (puedoGastar(fianza)) {
                paga(fianza);
                return false;
            }
            return true;
        }
    }

    @override
    boolean pagaImpuesto(float cantidad) {
        if (encarcelado)
            return false;
        return paga(cantidad / 2);
    }

    @override
    public String toString() {
        String props = "";
        for (int i = 0; i < propiedades.size(); i++) {
            props += propiedades.get(i).getNombre() + " ";
        }
        String s = "Nombre: " + nombre + "Es un jugador especulador " + " Saldo: " + saldo + " Propiedades: " + props + " Casilla actual: "
                + numCasillaActual;
        return s;
    }


}