package civitas;

import java.util.ArrayList;

public class Jugador implements Comparable<Jugador> {
    private final static int CasasMax = 4;
    private final static int CasasPorHotel = 4;
    private boolean encarcelado;
    private static final int HotelesMax = 4;
    private String nombre;
    private int numCasillaActual;
    private final static int pasoPorSalida = 1000;
    private final static int precioLibertad = 200;
    private boolean puedeComprar;
    private float saldo;
    private static float saldoInicial = 7500;
    private Sorpresa salvoconducto;
    private ArrayList<TituloPropiedad> propiedades;

    Jugador(String nombre) {
        this.nombre = nombre;
        encarcelado=false;
        numCasillaActual=0;
        puedeComprar=true;
        saldo=saldoInicial;
        salvoconducto=null;
        propiedades=new ArrayList<TituloPropiedad>();
    }

    protected Jugador(Jugador otro){
        otro.encarcelado=encarcelado;
        otro.nombre=nombre;
        otro.numCasillaActual=numCasillaActual;
        otro.puedeComprar=puedeComprar;
        otro.saldo=saldo;
        otro.salvoconducto=salvoconducto;
        otro.propiedades=propiedades;
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

    boolean obtenerSalvoconducto(Sorpresa s) {
        if (encarcelado) {
            return false;
        }

        else {
            salvoconducto = s;
            return true;
        }
    }

    private void perderSalvoconducto() {
        salvoconducto.usada();
        salvoconducto=null;
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
        if (encarcelado) return false;
        return paga(cantidad);
    }
    
    boolean pagaAlquiler(float cantidad) {
        if (encarcelado) return false;
        return paga(cantidad);
    }
    
    boolean recibe(float cantidad) {
        if (encarcelado) return false;
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
        }
        else {
            numCasillaActual = numCasilla;
            puedeComprar = false;
            Diario.getInstance().ocurreEvento("Se ha desplazado a la casilla: " + numCasilla);
            return true;
        }
    }

    private boolean puedoGastar(float precio) {
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
            return false;
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

    public String toString() {return "";}

    protected String getNombre(){return nombre;}

    public int getNumCasillaActual() {
        return numCasillaActual;
    }
    public boolean isEncarcelado(){
        return encarcelado;
    }

    public boolean getPuedeComprar() {return puedeComprar;}

	public boolean tieneSalvoConducto() {
		return false;
	}

	public void obtenerSalvoConducto() {
	}

	public int cantidadCasasHoteles() {
        int cant=0;
		for (int i=0; i<propiedades.size(); i++){
            cant+=propiedades.get(i).cantidadCasasHoteles();
        }
        return cant;
	}

    boolean cancelarHipoteca(int ip){
        boolean result=false;
        if (encarcelado) return result;
        if (existeLaPropiedad(ip)){
            TituloPropiedad propiedad=propiedades.get(ip);
            float cantidad=propiedad.getImporteCancelarHipoteca();
            boolean puedoGastar=puedoGastar(cantidad);
            if(puedoGastar){
                result=propiedad.cancelarHipoteca(this);
                if(result) Diario.getInstance().ocurreEvento("El jugador "+nombre+" cancela hipoteca de la propiedad "+ip);
            }
        }
        return result;
    }

    boolean comprar(TituloPropiedad titulo){
        boolean result=false;
        if(encarcelado) return result;
        if(puedeComprar){
            float precio=titulo.getPrecioCompra();
            if(puedoGastar(precio)){
                result=titulo.comprar(this);
                if(result)
                propiedades.add(titulo);
                Diario.getInstance().ocurreEvento("El jugador "+nombre+" compra la propiedad "+titulo.toString());
            }
            puedeComprar=false;
        }
        return result;
    }

    boolean construirHotel(int ip){
        boolean result=false;
        if(encarcelado) return result;
        if (!encarcelado){
            TituloPropiedad propiedad=propiedades.get(ip);
            boolean puedoEdificarHotel=puedoEdificarHotel(propiedad);

            if(puedoEdificarHotel){
                result=propiedad.construirHotel(this);
                int casasPorHotel=getCasasPorHotel();
                propiedad.destruirCasas(casasPorHotel, this);
            }
            Diario.getInstance().ocurreEvento("El jugador "+nombre+" ha construido un hotel en "+ip);
        }
        return result;
    }

    boolean construirCasa(int ip){
        boolean result=false;
        if(encarcelado) return result;
        if (!encarcelado){
            TituloPropiedad propiedad=propiedades.get(ip);
            boolean puedoEdificarCasa=puedoEdificarCasa(propiedad);

            if(puedoEdificarCasa){
                result=propiedad.construirCasa(this);
            }
            Diario.getInstance().ocurreEvento("El jugador "+nombre+" ha construido una casa en "+ip);
        }
        return result;
    }
    
    boolean hipotecar(int ip){
        boolean result=false;
        if(encarcelado) return result;
        if(existeLaPropiedad(ip)){
            TituloPropiedad propiedad=propiedades.get(ip);
            result=propiedad.hipotecar(this);
        }
        if(result) Diario.getInstance().ocurreEvento("El jugador "+nombre+" hipoteca "+ip);
        return result;
    }

    private boolean existeLaPropiedad(int ip){
        return ip>=0 && ip<propiedades.size();
    }

    private int getCasasMax(){return CasasMax;}
    private int getHotelesMax(){return HotelesMax;}
    int getCasasPorHotel(){return CasasPorHotel;}

    private boolean puedoEdificarCasa(TituloPropiedad propiedad){
        float precio=propiedad.getPrecioEdificar();
        if(puedoGastar(precio)){
            if(propiedad.getNumCasas()<getCasasMax()){
                return true;
            }
        }
        return false;
    }

    private boolean puedoEdificarHotel(TituloPropiedad propiedad){
        float precio=propiedad.getPrecioEdificar();
        if(puedoGastar(precio)){
            if(propiedad.getNumHoteles()<getHotelesMax()){
                if (propiedad.getNumCasas()>=getCasasPorHotel()){
                    return true;
                }
            }
        }
        return false;
    }

}