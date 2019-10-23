package juegoTexto;

import civitas.CivitasJuego;

class Controlador{
    private CivitasJuego juego;
    private VistaTextual vista;

    Controlador (CivitasJuego juego, VistaTextual vista){
        this.juego=juego;
        this.vista=vista;
    }

    void juega(){
        vista.setCivitasJuego(juego);
        while(!juego.finalDelJuego()){
            vista.actualizarVista();
            vista.pausa();
            vista.mostrarSiguienteOperacion(juego.siguientePaso());
            
            if (juego.finalDelJuego())
                juego.actualizarInfo();
            else{

            }
        }
    }
}