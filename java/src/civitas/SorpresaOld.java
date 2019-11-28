package civitas;

import java.util.ArrayList;

public class SorpresaOld {
    private String texto; // Definir por cada tipo
    private int valor;
    private Tablero tablero;
    private MazoSorpresas mazo;
    private TipoSorpresa tipo;

    Sorpresa(TipoSorpresa tipo, Tablero tablero) {
        init();
        this.tipo = tipo;
        this.tablero = tablero;
        valor = tablero.getCarcel();
        texto = "Carcel";
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
        texto = "Salir de la cárcel";
    }

    private void init() {
        valor = -1;
        texto = "";
        mazo = null;
        tablero = null;
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

    //OK
    private void aplicarAJugador_irCarcel(int actual, ArrayList<Jugador> todos) {
        todos.get(actual).encarcelar(valor);
    }

    //OK
    private void aplicarAJugador_irACasilla(int actual, ArrayList<Jugador> todos) {
        int tirada = tablero.calcularTirada(todos.get(actual).getNumCasillaActual(), valor);
        int numCasilla = tablero.nuevaPosicion(todos.get(actual).getNumCasillaActual(), tirada);
        todos.get(actual).moverACasilla(numCasilla);
        tablero.getCasilla(valor).recibeJugador(actual, todos);
    }

    //OK
    private void aplicarAJugador_pagarCobrar(int actual, ArrayList<Jugador> todos) {
        todos.get(actual).modificarSaldo(valor);
    }

    //OK
    private void aplicarAJugador_porCasaHotel(int actual, ArrayList<Jugador> todos) {
        todos.get(actual).modificarSaldo(valor * todos.get(actual).cantidadCasasHoteles());
    }

    //Creo que OK
    private void aplicarAJugador_porJugador(int actual, ArrayList<Jugador> todos) {
        Sorpresa s1 = new Sorpresa(TipoSorpresa.PAGARCOBRAR, valor * -1, "Quita");
        for (int i = 0; i < todos.size(); i++) {
            if (i != actual)
                s1.aplicarAJugador(i, todos);
        }

        Sorpresa s2 = new Sorpresa(TipoSorpresa.PAGARCOBRAR, valor * (todos.size() - 1), "Pon");
        s2.aplicarAJugador(actual, todos);
    }

    //OK
    private void aplicarAJugador_salirCarcel(int actual, ArrayList<Jugador> todos) {
        boolean alguienTieneSalvoConducto = false;
        for (int i = 0; i < todos.size() && !alguienTieneSalvoConducto; i++) {
            if (todos.get(i).tieneSalvoconducto()) {
                alguienTieneSalvoConducto = true;
            }

            if (!alguienTieneSalvoConducto) {
                todos.get(actual).obtenerSalvoconducto(this);
                salirDelMazo();
            }
        }
    }

    void salirDelMazo() {
        mazo.inhabilitarCartaEspecial(this);
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