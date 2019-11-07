package civitas;

import java.util.ArrayList;

public class Sorpresa {
    private String texto; // Definir por cada tipo
    private int valor;
    private Tablero tablero;
    private MazoSorpresas mazo;
    private TipoSorpresa tipo;

    Sorpresa(TipoSorpresa tipo, Tablero tablero) {
        init();
        this.tipo = tipo;
        this.tablero = tablero;
        valor=tablero.getCarcel();

        if (tipo == TipoSorpresa.IRCARCEL) {
            texto = "Carcel";
        } else if (tipo == TipoSorpresa.SALIRCARCEL) {
            texto = "Salir de la carcel";
        }
    }

    Sorpresa(TipoSorpresa tipo, Tablero tablero, int valor, String texto) {
        init();
        this.tipo = tipo;
        this.tablero = tablero;
        this.valor = valor;
        this.texto = texto;
    }

    Sorpresa(TipoSorpresa tipo, int valor, String texto) {
        init();
        this.tipo = tipo;
        this.valor = valor;
        this.texto = texto;
    }

    Sorpresa(TipoSorpresa tipo, MazoSorpresas mazo) {
        init();
        this.tipo = tipo;
        this.mazo = mazo;
    }

    private void init() {
        valor = -1;
        texto = "";
        mazo = null;
        tablero = null;
    }

    public boolean jugadorCorrecto(int actual, ArrayList<Jugador> todos) {
        return (actual >= 0 && actual < todos.size());
    }

    private void informe(int actual, ArrayList<Jugador> todos) {
        Diario.getInstance().ocurreEvento("Se está aplicando una sorpresa a: " + todos.get(actual).getNombre());
    }

    void aplicarAJugador(int actual, ArrayList<Jugador> todos) {
        if (!jugadorCorrecto(actual, todos))
            return;
        informe(actual, todos);
        switch (tipo) {
        case IRCARCEL:
            aplicarAJugador_irCarcel(actual, todos);
            break;
        case IRCASILLA:
            aplicarAJugador_irACasilla(actual, todos);
            break;
        case PORCASAHOTEL:
            aplicarAJugador_porCasaHotel(actual, todos);
            break;
        case PORJUGADOR:
            aplicarAJugador_porJugador(actual, todos);
            break;
        case SALIRCARCEL:
            aplicarAJugador_salirCarcel(actual, todos);
            break;
        case PAGARCOBRAR:
            aplicarAJugador_pagarCobrar(actual, todos);
            break;
        }

    }

    private void aplicarAJugador_irCarcel(int actual, ArrayList<Jugador> todos) {
        todos.get(actual).encarcelar(valor);
    }

    private void aplicarAJugador_irACasilla(int actual, ArrayList<Jugador> todos) {
        int tirada = tablero.calcularTirada(actual, valor);
        int numCasilla = tablero.nuevaPosicion(actual, tirada);
        todos.get(actual).moverACasilla(numCasilla);
        tablero.getCasilla(valor).recibeJugador(actual, todos);
    }

    private void aplicarAJugador_pagarCobrar(int actual, ArrayList<Jugador> todos) {
        todos.get(actual).modificarSaldo(valor);
    }

    private void aplicarAJugador_porCasaHotel(int actual, ArrayList<Jugador> todos) {
        todos.get(actual).modificarSaldo(valor * todos.get(actual).cantidadCasasHoteles());
    }

    private void aplicarAJugador_porJugador(int actual, ArrayList<Jugador> todos) {
        Sorpresa s1 = new Sorpresa(TipoSorpresa.PAGARCOBRAR, valor * -1, "Quita");
        for (int i = 0; i < todos.size(); i++) {
            if (i != actual)
                s1.aplicarAJugador(i, todos);
        }

        Sorpresa s2 = new Sorpresa(TipoSorpresa.PAGARCOBRAR, valor * (todos.size() - 1), "Pon");
        s2.aplicarAJugador(actual, todos);
    }

    private void aplicarAJugador_salirCarcel(int actual, ArrayList<Jugador> todos) {
        boolean alguienTieneSalvoConducto = false;
        for (int i = 0; i < todos.size() && !alguienTieneSalvoConducto; i++) {
            if (todos.get(i).tieneSalvoconducto()) {
                alguienTieneSalvoConducto = true;
            }

            if (alguienTieneSalvoConducto) {
                todos.get(actual).obtenerSalvoconducto(this);
                salirDelMazo();
            }
        }
    }

    void salirDelMazo() {
        if (tipo == TipoSorpresa.SALIRCARCEL) {
            mazo.inhabilitarCartaEspecial(this);
        }
    }

    void usada() {
        if (tipo == TipoSorpresa.SALIRCARCEL) {
            mazo.habilitarCartaEspecial(this);
        }
    }

    public String toString() {
        return texto;
    }

}