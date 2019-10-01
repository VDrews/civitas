package civitas;

public class TestP1{

    public static void main(String[] args) {
        System.out.println("Quien empieza");
        for (int i=0; i<100; i++)
            System.out.println(Dado.getInstance().quienEmpieza(4));
        
        System.out.println("Dado en debug");
        Dado.getInstance().setDebug(true);
        for (int i=0; i<4; i++)
            System.out.println(Dado.getInstance().tirar());

        System.out.println("Dado normal");
        Dado.getInstance().setDebug(false);
        for (int i=0; i<4; i++)
            System.out.println(Dado.getInstance().tirar());

        System.out.println("Metodos de Dado");
        System.out.println("U.R: "+Dado.getInstance().getUltimoResultado());
        System.out.println(Dado.getInstance().tirar());
        System.out.println("U.R: "+Dado.getInstance().getUltimoResultado());
        System.out.println(Dado.getInstance().salgoDeLaCarcel());
        System.out.println(Dado.getInstance().salgoDeLaCarcel());

    }
}