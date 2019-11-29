package civitas;

public class TituloPropiedad {

    private float alquilerBase;
    private static float factorInteresesHipoteca = (float) 1.1;
    private float factorRevalorizacion;
    private float hipotecaBase;
    private boolean hipotecado;
    private String nombre;
    private int numCasas;
    private int numHoteles;
    private float precioCompra;
    private float precioEdificar;
    private Jugador propietario;

    TituloPropiedad(String nom, float ab, float fr, float hb, float pc, float pe) {
        alquilerBase = ab;
        factorRevalorizacion = fr;
        hipotecaBase = hb;
        hipotecado = false;
        nombre = nom;
        numCasas = 0;
        numHoteles = 0;
        precioCompra = pc;
        precioEdificar = pe;
        propietario = null;
    }

    public String toString() {
        return "Nombre: " + nombre + "\nAlquiler base: " + alquilerBase + "\nFactor de Revalorización: "
                + factorRevalorizacion + "\nHipoteca Base: " + hipotecaBase + "\nHipotecado: " + hipotecado
                + "\nNúmero de CASAS: " + numCasas + "\nNúmero de HOTELES: " + numHoteles + "\nPrecio de COMPRA: "
                + precioCompra + "\nPrecio para EDIFICAR: " + precioEdificar + "\nPropietario: "
                + propietario.toString();
    }

    private float getPrecioAlquiler() {
        if (hipotecado || propietarioEncarcelado()) {
            return 0;
        }

        else {
            return (float) (alquilerBase * (1 + (numCasas * 0.5) + (numHoteles * 2.5)));
        }
    }

    private float getImporteHipoteca() {
        return hipotecaBase * (1 + (numCasas * 0.5f) + (numHoteles * 2.5f));
    }

    float getImporteCancelarHipoteca() {
        return getImporteHipoteca() * factorInteresesHipoteca;
    }

    boolean cancelarHipoteca(Jugador jugador) {
        if (hipotecado && esEsteElPropietario(jugador)) {
            jugador.paga(getImporteCancelarHipoteca());
            hipotecado = false;
            return true;
        }

        else {
            return false;
        }
    }

    boolean hipotecar(Jugador jugador) {
        if (!hipotecado && esEsteElPropietario(jugador)) {
            jugador.recibe(getImporteHipoteca());
            hipotecado = true;
            return true;
        } else {
            return false;
        }
    }

    void tramitarAlquiler(Jugador jugador) {
        if (tienePropietario() && !esEsteElPropietario(jugador)) {
            float precio = getPrecioAlquiler();
            jugador.pagaAlquiler(precio);
            getPropietario().recibe(precio);
        }
    }

    boolean propietarioEncarcelado() {
        return getPropietario().isEncarcelado();
    }

    int cantidadCasasHoteles() {
        return numCasas + numHoteles;
    }

    boolean destruirCasas(int n, Jugador jugador) {
        if (esEsteElPropietario(jugador) && numCasas >= n) {
            numCasas -= n;
            return true;
        }
        return false;
    }

    float getPrecioVenta() {
        return precioCompra + (numCasas + 5 * numHoteles) * (precioEdificar * factorRevalorizacion);
    }

    boolean construirCasa(Jugador jugador) {
        if (esEsteElPropietario(jugador)) {
            jugador.paga(precioEdificar);
            numCasas++;
            return true;
        }

        else {
            return false;
        }
    }

    boolean construirHotel(Jugador jugador) {
        if (esEsteElPropietario(jugador)) {
            jugador.paga(precioEdificar);
            numHoteles++;
            return true;
        }

        else {
            return false;
        }

    }

    boolean comprar(Jugador jugador) {
        if (tienePropietario()) {
            return false;
        } else {
            propietario = jugador;
            jugador.paga(precioCompra);
            return true;
        }
    }

    private boolean esEsteElPropietario(Jugador jugador) {
        return (jugador.getNombre() == propietario.getNombre());
    }

    boolean tienePropietario() {
        return propietario != null;
    }

    Jugador getPropietario() {
        return propietario;
    }

    int getNumCasas() {
        return numCasas;
    }

    String getNombre() {
        return nombre;
    }

    public boolean getHipotecado() {
        return hipotecado;
    }

    int getNumHoteles() {
        return numHoteles;
    }

    float getPrecioCompra() {
        return precioCompra;
    }

    float getPrecioEdificar() {
        return precioEdificar;
    }

    boolean vender(Jugador jugador) {
        if (esEsteElPropietario(jugador)) {
            propietario = null;
            jugador.recibe(getPrecioVenta());
            numCasas = 0;
            numHoteles = 0;
            return true;
        }
        return false;
    }

    void actualizaPropietarioPorConversion(Jugador jugador) {
        if (!esEsteElPropietario(jugador))
            propietario = jugador;
    }

}
