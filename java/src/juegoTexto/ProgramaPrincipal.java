package juegoTexto;

import java.util.ArrayList;
import civitas.CivitasJuego;

public class ProgramaPrincipal{
    public static void main (String[] args){
        ArrayList<String> nombres=new ArrayList<String>();
        nombres.add("Andrés");
        nombres.add("Carlos");
        nombres.add("Chema");
        nombres.add("Esmeralda");

        CivitasJuego juego=new CivitasJuego(nombres);
        VistaTextual vista=new VistaTextual();
        Controlador controlador=new Controlador(juego, vista);

        controlador.juega();
    }
}