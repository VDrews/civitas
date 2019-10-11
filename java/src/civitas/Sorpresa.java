package civitas;

// SIN ACABAR

public class Sorpresa {
    private String texto; // Definir por cada tipo
    private int valor;
    private Tablero tablero;
    private MazoSorpresas mazo;
    private TipoSorpresa tipo;

    Sorpresa(TipoSorpresa tipo, Tablero tablero) {
        this.tipo = tipo;
        this.tablero = tablero;

        if (tipo == TipoSorpresa.IRCARCEL) {
            texto = "Carcel";
        }
        else if (tipo == TipoSorpresa.SALIRCARCEL) {
            texto = "Salir de la carcel";
        }
    }

    Sorpresa(TipoSorpresa tipo, Tablero tablero, int valor, String texto) {
        this.tipo = tipo;
        this.tablero = tablero;
        this.valor = valor;
        this.texto = texto;
    }

    Sorpresa(TipoSorpresa tipo, int valor, String texto) {
        this.tipo = tipo; 
        this.valor = valor;
        this.texto = texto;
    }

    Sorpresa(TipoSorpresa tipo, MazoSorpresas mazo) {
        this.tipo = tipo; 
        this.mazo = mazo;
    }

    void init() {
        valor = -1;
        texto = "";
    }

    public boolean jugadorCorrecto(int actual, ArrayList<Jugador> todos) {
        if (actual >= 0 && actual < todos.length) {
            return todos[actual];
        }
    }

    private void informe(int actual, ArrayList<Jugador> todos) {
        Diario.getInstance().ocurreEvento("Se está aplicando una sorpresa a: " + todos[actual].getNombre());
    }

    void aplicarAJugador(int actual, ArrayList<Jugador> todos) {
        if (!jugadorCorrecto(actual, todos)) return;
        informe(actual, todos);
        switch(tipo) {
            case TipoSorpresa.IRCARCEL:
                aplicarAJugador_irCarcel(actual, todos);
                break;
            case TipoSorpresa.IRCASILLA:
                aplicarAJugador_irACasilla(actual, todos);
                break;
        case TipoSorpresa.PORCASAHOTEL:
                aplicarAJugador_porCasaHotel(actual, todos);
                break;
            case TipoSorpresa.PORJUGADOR:
                aplicarAJugador_pagarJugador(actual, todos);
                break;
            case TipoSorpresa.SALIRCARCEL:
                aplicarAJugador_salirCarcel(actual, todos);
                break;
            case TipoSorpresa.PAGARCOBRAR:
                break;
            default: 
                assert("El tipo de sorpresa no está definido");
        }
        
    }

    private void aplicarAJugador_irCarcel(int actual, ArrayList<Jugador> todos) {
        todos[actual].encarcelar(valor);
    }

    private void aplicarAJugador_irACasilla(int actual, ArrayList<Jugador> todos) {
        tablero.calcularTirada(actual, valor);
    }

    private void aplicarAJugador_pagarCobrar(int actual, ArrayList<Jugador> todos) {
        todos[actual].modificarSaldo(valor);
    }
    
    private void aplicarAJugador_porCasaHotel(int actual, ArrayList<Jugador> todos) {
        todos[actual].modificarSaldo(valor * todos[actual].getPropiedades().length);
    }

    private void aplicarAJugador_porJugador(int actual, ArrayList<Jugador> todos) {
        Sorpresa s1 = new Sorpresa();
    }
    private void aplicarAJugador_salirCarcel(int actual, ArrayList<Jugador> todos) {
        boolean tieneSalvoConducto = false;
        for (int i = 0; i < todos.size() && !tieneSalvoConducto; i++) {
            if (todos[i].tieneSalvoConducto()) {
                tieneSalvoConducto = true;
            }

            if (tieneSalvoConducto) {
                todos[actual].obtenerSalvoConducto();
                salirDelMazo();
            }
        }
    }
    void salirDelMazo() {
        if (tipo == tipo.SALIRCARCEL) {
            mazo.inhabilitarCartaEspecial(this);
        }
    }

    void usada() {
        if (tipo == tipo.SALIRCARCEL) {
            mazo.habilitarCartaEspecial(this);
        }
    }

    public String toString() {
        return texto;
    }

}