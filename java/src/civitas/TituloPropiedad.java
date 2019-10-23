package civitas;

//construirCasa

public class TituloPropiedad {

    private float alquilerBase;
    private static float factorInteresesHipoteca=(float) 1.1;
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
    }

    public String toString() {
        return "Nombre: " + nombre + 
        "\nAlquiler base: "+ alquilerBase +
        "\nFactor de Revalorización: " + factorRevalorizacion +
        "\nHipoteca Base: " + hipotecaBase +
        "\nHipotecado: " + hipotecado +
        "\nNúmero de CASAS: " + numCasas +
        "\nNúmero de HOTELES: " + numHoteles +
        "\nPrecio de COMPRA: " + precioCompra +
        "\nPrecio para EDIFICAR: " + precioEdificar;
    }

    float getPrecioAlquiler() {
        if (hipotecado || propietarioEncarcelado()) {
            return 0;
        }

        else {
            return alquilerBase; 
        }
    }

    float getImporteCancelarHipoteca() {
        return hipotecaBase * factorInteresesHipoteca;
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
            jugador.recibe(hipotecaBase);
            hipotecado = true;
            return true;
        }
        else {
            return false;
        }
    }

    void tramitarAlquiler(Jugador jugador) {
        if (tienePropietario() && !esEsteElPropietario(jugador)) {
            jugador.pagaAlquiler(alquilerBase);
            getPropietario().recibe(alquilerBase);
        }
    }

    boolean propietarioEncarcelado() {
        return getPropietario().isEncarcelado();
    }

    int cantidadCasasHoteles() {
        return numCasas + numHoteles;
    }

    boolean destruirCasas(int n, Jugador jugador) {
        if(esEsteElPropietario(jugador) && numCasas >= n) {
            numCasas -= n;
            return true;
        }
        return false;
    }

    float getPrecioVenta() {
        return precioCompra + (precioEdificar * factorRevalorizacion);
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

    boolean Comprar(Jugador jugador) {
        if (tienePropietario()) {
            return false;
        }
        else {
            propietario = jugador;
            jugador.paga(getPrecioVenta());
            return true;
        }
    }
    private boolean esEsteElPropietario(Jugador jugador) {
        return (jugador.getNombre() == propietario.getNombre()); // Considerando que los nombres de los jugadores son únicos
    }
    boolean tienePropietario() {
        if (propietario!=null) return true;
        return false;
    }
    Jugador getPropietario() {
        return propietario;
    }



}
