package civitas;

import java.util.ArrayList;
import GUI.Dado;

public class Jugador implements Comparable<Jugador> {
    protected final static int CasasMax = 4;
    protected final static int CasasPorHotel = 4;
    protected boolean encarcelado;
    protected static final int HotelesMax = 4;
    protected String nombre;
    protected int numCasillaActual;
    protected final static int pasoPorSalida = 1000;
    protected final static int precioLibertad = 200;
    private boolean puedeComprar;
    protected float saldo;
    private final static float saldoInicial = 7500;
    private SorpresaSalirCarcel salvoconducto;
    protected ArrayList<TituloPropiedad> propiedades;

    Jugador(String nombre) {
        this.nombre = nombre;
        encarcelado = false;
        numCasillaActual = 0;
        puedeComprar = false;
        saldo = saldoInicial;
        salvoconducto = null;
        propiedades = new ArrayList<TituloPropiedad>();
    }

    protected Jugador(Jugador otro) {
        encarcelado = otro.encarcelado;
        nombre = otro.nombre;
        numCasillaActual = otro.numCasillaActual;
        puedeComprar = otro.puedeComprar;
        saldo = otro.saldo;
        salvoconducto = otro.salvoconducto;
        propiedades = otro.propiedades;
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

        return true;
    }

    boolean encarcelar(int numCasillaCarcel) {
        if (debeSerEncarcelado()) {
            moverACasilla(numCasillaCarcel);
            encarcelado = true;
            Diario.getInstance().ocurreEvento("El jugador " + nombre + " ha sido encarcelado");
        }

        return encarcelado;
    }

    boolean obtenerSalvoconducto(SorpresaSalirCarcel s) {
        if (encarcelado) {
            return false;
        }

        else {
            salvoconducto = s;
            Diario.getInstance().ocurreEvento("El jugador " + nombre + " obtiene salvoconducto");

            return true;
        }
    }

    protected void perderSalvoconducto() {
        salvoconducto.usada();
        salvoconducto = null;
    }

    boolean enBancarrota() {
        return saldo <= 0;
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
        if (encarcelado)
            return false;
        return paga(cantidad);
    }

    boolean pagaAlquiler(float cantidad) {
        if (encarcelado)
            return false;
        return paga(cantidad);
    }

    boolean recibe(float cantidad) {
        if (encarcelado)
            return false;
        return modificarSaldo(cantidad);
    }

    boolean modificarSaldo(float cantidad) {
        saldo += cantidad;
        Diario.getInstance().ocurreEvento("Se ha modificado el saldo en: " + cantidad + ", SALDO ACTUAL: " + saldo);
        return true;
    }

    boolean moverACasilla(int numCasilla) {
        if (encarcelado) {
            return false;
        } else {
            numCasillaActual = numCasilla;
            puedeComprar = false;
            Diario.getInstance().ocurreEvento("Se ha desplazado a la casilla: " + numCasilla);
            return true;
        }
    }

    protected boolean puedoGastar(float precio) {
        if (encarcelado)
            return false;
        return saldo >= precio;
    }

    boolean vender(int ip) {

        if (!encarcelado && existeLaPropiedad(ip) && propiedades.get(ip).vender(this)) {
            propiedades.remove(ip);
            Diario.getInstance().ocurreEvento("Se ha vendido la propiedad: " + ip);
            return true;
        }

        return false;
    }

    boolean tieneAlgoQueGestionar() {
        return propiedades.size() != 0;
    }

    private boolean puedeSalirCarcelPagando() {
        return saldo >= precioLibertad;
    }

    boolean salirCarcelPagando() {
        if (encarcelado && puedeSalirCarcelPagando()) {
            paga(getPrecioLibertad());
            encarcelado = false;
            Diario.getInstance().ocurreEvento("Jugador: " + nombre + " ha salido de la carcel PAGANDO");
            return true;
        }
        return false;
    }

    boolean salirCarcelTirando() {
        if (Dado.getInstance().salgoDeLaCarcel()) {
            encarcelado = false;
            Diario.getInstance().ocurreEvento("Jugador: " + nombre + " ha salido de la carcel PAGANDO");
            return true;
        } else {
            return false;
        }
    }

    boolean pasaPorSalida() {
        modificarSaldo(getPrecioPasoSalida());
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

        else
            return 0;
    }

    public String toString() {
        String props = "";
        for (int i = 0; i < propiedades.size(); i++) {
            props += propiedades.get(i).getNombre() + " ";
        }
        String s = "Nombre: " + nombre + " Saldo: " + saldo + " Propiedades: " + props + " Casilla actual: "
                + numCasillaActual;
        return s;
    }

    public String getNombre() {
        return nombre;
    }

    int getNumCasillaActual() {
        return numCasillaActual;
    }

    public boolean isEncarcelado() {
        return encarcelado;
    }

    boolean getPuedeComprar() {
        return puedeComprar;
    }

    public float getSaldo() {
        return saldo;
    }

    int cantidadCasasHoteles() {
        int cant = 0;
        for (int i = 0; i < propiedades.size(); i++) {
            cant += propiedades.get(i).cantidadCasasHoteles();
        }
        return cant;
    }

    boolean cancelarHipoteca(int ip) {
        boolean result = false;
        if (encarcelado)
            return result;
        if (existeLaPropiedad(ip)) {
            TituloPropiedad propiedad = propiedades.get(ip);
            float cantidad = propiedad.getImporteCancelarHipoteca();
            boolean puedoGastar = puedoGastar(cantidad);
            if (puedoGastar) {
                result = propiedad.cancelarHipoteca(this);
                if (result)
                    Diario.getInstance()
                            .ocurreEvento("El jugador " + nombre + " cancela hipoteca de la propiedad " + ip);
            }
        }
        return result;
    }

    private float getPrecioLibertad() {
        return precioLibertad;
    }

    private float getPrecioPasoSalida() {
        return pasoPorSalida;
    }

    public ArrayList<TituloPropiedad> getPropiedades() {
        return propiedades;
    }

    public ArrayList<String> getPropiedades_toString() {
        ArrayList<String> res = new ArrayList<String>();
        for (int i = 0; i < propiedades.size(); i++) {
            res.add(propiedades.get(i).getNombre());
        }
        return res;
    }

    boolean comprar(TituloPropiedad titulo) {
        boolean result = false;
        if (encarcelado)
            return result;
        if (puedeComprar) {
            float precio = titulo.getPrecioCompra();
            if (puedoGastar(precio)) {
                result = titulo.comprar(this);
                if (result){
                    propiedades.add(titulo);
                    Diario.getInstance().ocurreEvento("El jugador " + nombre + " compra la propiedad " + titulo.toString());
                }
            }
            puedeComprar = false;
        }
        return result;
    }

    boolean construirHotel(int ip) {
        boolean result = false;
        if (encarcelado)
            return result;
        if (existeLaPropiedad(ip)) {
            TituloPropiedad propiedad = propiedades.get(ip);
            boolean puedoEdificarHotel = puedoEdificarHotel(propiedad);

            if (puedoEdificarHotel) {
                result = propiedad.construirHotel(this);
                int casasPorHotel = getCasasPorHotel();
                propiedad.destruirCasas(casasPorHotel, this);
                Diario.getInstance().ocurreEvento("El jugador " + nombre + " ha construido un hotel en " + ip);
            }
        }
        return result;
    }

    boolean construirCasa(int ip) {
        boolean result = false;
        if (encarcelado)
            return result;
        if (existeLaPropiedad(ip)) {
            TituloPropiedad propiedad = propiedades.get(ip);
            boolean puedoEdificarCasa = puedoEdificarCasa(propiedad);

            if (puedoEdificarCasa) {
                result = propiedad.construirCasa(this);
                Diario.getInstance().ocurreEvento("El jugador " + nombre + " ha construido una casa en " + ip);
            }
        }
        return result;
    }

    boolean hipotecar(int ip) {
        boolean result = false;
        if (encarcelado)
            return result;
        if (existeLaPropiedad(ip)) {
            TituloPropiedad propiedad = propiedades.get(ip);
            result = propiedad.hipotecar(this);
        }
        if (result)
            Diario.getInstance().ocurreEvento("El jugador " + nombre + " hipoteca " + ip);
        return result;
    }

    private boolean existeLaPropiedad(int ip) {
        return ip >= 0 && ip < propiedades.size();
    }

    protected int getCasasMax() {
        return CasasMax;
    }

    protected int getHotelesMax() {
        return HotelesMax;
    }

    int getCasasPorHotel() {
        return CasasPorHotel;
    }

    private boolean puedoEdificarCasa(TituloPropiedad propiedad) {
        float precio = propiedad.getPrecioEdificar();
        if (puedoGastar(precio)) {
            if (propiedad.getNumCasas() < getCasasMax()) {
                return true;
            }
        }
        return false;
    }

    private boolean puedoEdificarHotel(TituloPropiedad propiedad) {
        float precio = propiedad.getPrecioEdificar();
        if (puedoGastar(precio)) {
            if (propiedad.getNumHoteles() < getHotelesMax()) {
                if (propiedad.getNumCasas() >= getCasasPorHotel()) {
                    return true;
                }
            }
        }
        return false;
    }
    
    public boolean isEspeculador(){
        return false;
    }

}