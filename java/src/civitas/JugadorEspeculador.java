package civitas;

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

    @Override
    protected int getCasasMax() {
        return CasasMax * factorEspeculador;
    }

    @Override
    protected int getHotelesMax() {
        return HotelesMax * factorEspeculador;
    }

    @Override
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

    @Override
    boolean pagaImpuesto(float cantidad) {
        if (encarcelado)
            return false;
        return paga(cantidad / 2);
    }

    @Override
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