package civitas;

public class Casilla {
    private String nombre;
    private static int carcel;
    private float importe;
    private TipoCasilla tipo;
    private TituloPropiedad tituloPropiedad;
    private Sorpresa sorpresa;
    private MazoSorpresas mazo;
    private Tablero casillas;
    
    //Descanso
    Casilla(String nombre) {
        init();
        tipo = TipoCasilla.DESCANSO;
        this.nombre = nombre;
    }
    
    //Calle
    Casilla(TituloPropiedad titulo) {
        init();
        tipo = TipoCasilla.CALLE;
        tituloPropiedad = titulo;     
    }
    
    //Impuesto
    Casilla(float cantidad, String nombre) {
        init();
        tipo = TipoCasilla.IMPUESTO;
        this.nombre = nombre;
        importe = cantidad;
    }
    
    //Juez
    Casilla(int numCasillaCarcel, String nombre) {
        init();
        tipo = TipoCasilla.JUEZ;
        carcel = numCasillaCarcel;
        this.nombre = nombre;
    }
    
    //Sorpresa
    Casilla(MazoSorpresas mazo, String nombre) {
        init();
        tipo = TipoCasilla.SORPRESA;
        this.mazo = mazo;
        this.nombre = nombre;
        
    }

    public String getNombre(){
        return nombre;
    }

    private void init() {
        nombre = "";
        carcel = 0;
        importe = 0;
    }

    private void informe(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto()) {
            Diario.getInstance().ocurreEvento(todos[actual].getNombre() + ": Casilla " + toString());
        }
    }
    
    //P3
    public boolean jugadorCorrecto(int actual, ArrayList<Jugador> todos) {
        return actual >= 0 && actual < todos.length;
    }

    void recibeJugador(int actual, ArrayList<Jugador> todos) {
        if (jugadorCorrecto(actual, todos)) {
            informe(actual, todos);
        
        }
    }
    // private void recibeJugador_calle(int actual, ArrayList<Jugador> todos)
    // private void recibeJugador_sorpresa(int actual, ArrayList<Jugador> todos)
    private void recibeJugador_impuesto(int actual, ArrayList<Jugador> todos) {
        todos[actual].pagaImpuesto(importe);
    }

    private void recibeJugador_juez(int actual, ArrayList<Jugador> todos) {
        todos[actual].encarcelar();
    }

    public String toString() {
        return "Casilla: " + nombre + "\nCarcel: " + carcel + "\nImporte: " + importe;
    }

    
    
}
