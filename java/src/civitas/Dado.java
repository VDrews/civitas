package civitas;

import java.util.Random;

public class Dado{
    private Random random;
    private int ultimoResultado;
    private boolean debug;

    private static final Dado instance=new Dado();
    private static int SalidaCarcel=5;

    private Dado(){
        ultimoResultado=0;
        debug=false;
        random=new Random();
    }

    static Dado getInstance() {return instance;}

    private static int getRandomNumberInRange(int min, int max) {

		if (min >= max) {
			throw new IllegalArgumentException("max must be greater than min");
		}

		Random r = new Random();
		return r.nextInt((max - min) + 1) + min;
	}


    int tirar(){
        if (debug){
            ultimoResultado=1;
            return 1;
        }
        else{
            int valor=getRandomNumberInRange(1, 6);
            ultimoResultado=valor;
            return valor;
        }
    }

    boolean salgoDeLaCarcel(){
        return (tirar()>=5);
    }

    int quienEmpieza (int n){
        return getRandomNumberInRange(0, n-1);
    }

    void setDebug(boolean d){
        debug=d;
    }

    int getUltimoResultado() {
        return ultimoResultado;
    }


}