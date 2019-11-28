package civitas;

public class TestP4 {
    public static void main(String[] args) {
        Jugador jug = new Jugador("Verzy");

        TituloPropiedad tp = new TituloPropiedad("Ladronzuelo", 200, 0.5f, 150, 300, 200);
        tp.comprar(jug);
        jug.getPropiedades().add(tp);

        jug = new JugadorEspeculador(jug, 200);

        System.out.println(jug.toString());
    }
}