package civitas;

import java.util.Random;

public class Dado {
    private Random random;
    private int ultimoResultado;
    private boolean debug;

    private static final Dado instance = new Dado();
    private static int SalidaCarcel = 5;

    private Dado() {
        ultimoResultado = 0;
        debug = false;
        random = new Random();
    }

    public static Dado getInstance() {
        return instance;
    }

    private int getRandomNumberInRange(int min, int max) {

        if (min >= max) {
            throw new IllegalArgumentException("max must be greater than min");
        }

        random = new Random();
        return random.nextInt((max - min) + 1) + min;
    }

    int tirar() {
        if (debug) {
            ultimoResultado = 1;
            return 1;
        } else {
            int valor = getRandomNumberInRange(1, 6);
            ultimoResultado = valor;
            return valor;
        }
    }

    boolean salgoDeLaCarcel() {
        return (tirar() >= SalidaCarcel);
    }

    int quienEmpieza(int n) {
        return getRandomNumberInRange(0, n - 1);
    }

    public void setDebug(boolean d) {
        debug = d;
        String e = "Dado--Modo debug: ";
        if (d)
            e.concat("activado");
        else
            e.concat("desactivado");
        Diario.getInstance().ocurreEvento(e);
    }

    int getUltimoResultado() {
        return ultimoResultado;
    }

}