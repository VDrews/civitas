package civitas;

// ENCARCELAR

public class Jugador implements Comparable<Jugador> {
    private final static int CasasMax = 4;
    private final static int CasasporHotel = 4;
    private boolean encarcelado;
    private final int HotelesMax = 4;
    private String nombre;
    private int numCasillaActual;
    private final static int pasoPorSalida = 1000;
    private final static int precioLibertad = 200;
    private boolean puedeComprar;
    private float saldo;
    private static float saldoInicial = 7500;
    private Sorpresa salvoconducto = null;
    private ArrayList<TituloPropiedad> propiedades;

    Jugador(String nombre) {
        this.nombre = nombre;
    }

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
            return true;
        }
    }

    boolean encarcelar(int numCasillaCarcel) {
        if (debeSerEncarcelado()) {
            moverACasilla(numCasillaCarcel);
            encarcelado = true;
            Diario.getInstance().ocurreEvento("El jugador " + nombre + " ha sido encarcelado");
        }

        return encarcelado;
    }

    boolean obtenerSalvoconducto(Sorpresa s) {
        if (encarcelado) {
            return false;
        }

        else {
            salvoconducto = s;
        }
    }

    private void perderSalvoconducto() {
        salvoconducto.usada();
    }

    boolean tieneSalvoconducto() {
        return salvoconducto != null;
    }

    boolean puedeComprarCasilla() {
        puedeComprar = !encarcelado;
        return puedeComprar;
    }

    boolean paga(float cantidad) {
        return modificarSaldo(cantidad * -1);
    }

    boolean pagaImpuesto(float cantidad) {
        if (encarcelado) return false;
        return paga(cantidad);
    }
    
    boolean pagaAlquiler(float cantidad) {
        if (encarcelado) return false;
        return paga(cantidad);
    }
    
    boolean recibe(float cantidad) {
        if (encarcelado) {
            return false;
        }

        else {
            return modificarSaldo(cantidad);
        }
    }

    boolean modificarSaldo(float cantidad) {
        saldo += cantidad;
        Diario.getInstance().ocurreEvento("Se ha modificado el saldo en: " + cantidad + ", SALDO ACTUAL: " + saldo);
        return true;
    }

    boolean moverACasilla(int numCasilla) {
        if (encarcelado) {
            return false;
        }
        else {
            numCasillaActual = numCasilla;
            puedeComprar = false;
            Diario.getInstance().ocurreEvento("Se ha desplazado a la casilla: " + numCasilla);
        }
    }

    private boolean puedoGastar(float precio) {
        return saldo >= precio;
    }

    boolean vender(int ip) {
    
        if (!encarcelado && existeLaPropiedad(ip) && propiedades[ip].vender(this)) {
                propiedades.remove(ip);
                Diario.getInstance().ocurreEvento("Se ha vendido la propiedad: " + ip);
                return true;
            }

            else {
            return false;
        }
    }

    boolean tieneAlgoQueGestionar()  {
        return propiedades.size() != 0;
    }

    private boolean puedeSalirCarcelPagando() {
        return saldo >= precioLibertad;
    }

    boolean salirCarcelPagando() {
        if (encarcelado && puedeSalirCarcelPagando()) {
            paga(precioLibertad);
            encarcelado = false;
            Diario.getInstance().ocurreEvento("Jugador: " + nombre + " ha salido de la carcel PAGANDO");
            return true;
        }
        
        else {
            return false;
        }
    }
    
    boolean salirCarcelTirando() {
        if (Dado.getInstance().salgoDeLaCarcel()) {
            encarcelado = false;
            Diario.getInstance().ocurreEvento("Jugador: " + nombre + " ha salido de la carcel PAGANDO");
            return true;
        }
        else {
            return false;
        }
    }
    
    boolean pasaPorSalida() {
        modificarSaldo(pasoPorSalida);
        Diario.getInstance().ocurreEvento("Jugador: " + nombre + " ha pasado por la salida");
        return true;
    }

    public int compareTo(Jugador otro) {
        if (saldo > otro.saldo) {
            return 1;
        }

        else if (saldo < otro.saldo) {
            return -1;
        }

        else return 0;
    }

    private String toString() {return "";}

    public int getNumCasillaActual() {
        return numCasillaActual;
    }

    //P3
    // cancelarHipoteca(int ip)
    // comprar(TituloPropiedad titulo)
    // construirHotel(int ip)
    // construirCasa(int ip)
    // boolean hipotecar(int ip)

    // private boolean existeLaPropiedad(int ip)
    // private int getCasasMax()
    // private int getHotelesMax()
    // protected String getNombre()

}