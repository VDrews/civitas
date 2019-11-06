package juegoTexto;

import java.util.ArrayList;
import civitas.CivitasJuego;
import civitas.Dado;

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
        //Dado.getInstance().setDebug(true);

        controlador.juega();
    }
}