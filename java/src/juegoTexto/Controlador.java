package juegoTexto;

import civitas.CivitasJuego;
import civitas.GestionesInmobiliarias;
import civitas.OperacionesJuego;
import civitas.Respuestas;
import civitas.SalidasCarcel;
import civitas.OperacionInmobiliaria;

class Controlador {
    private CivitasJuego juego;
    private VistaTextual vista;

    Controlador(CivitasJuego juego, VistaTextual vista) {
        this.juego = juego;
        this.vista = vista;
    }

    void juega() {
        vista.setCivitasJuego(juego);
        while (!juego.finalDelJuego()) {
            vista.pausa();
            OperacionesJuego siguiente=juego.siguientePaso();
            vista.mostrarSiguienteOperacion(siguiente);
            if (siguiente!=OperacionesJuego.PASAR_TURNO) vista.mostrarEventos();

            if (juego.finalDelJuego())
                juego.actualizarInfo();
            else {
                switch (siguiente) {
                    case COMPRAR:
                        Respuestas rp=vista.comprar();
                        if(rp==Respuestas.SI){
                            juego.comprar();
                        }
                        juego.siguientePasoCompleado(OperacionesJuego.COMPRAR);
                        break;

                    case GESTIONAR:
                        vista.gestionar();
                        OperacionInmobiliaria operacion=new OperacionInmobiliaria(GestionesInmobiliarias.values()[vista.getGestion()], vista.getPropiedad());
                        int ip=operacion.getNumPropiedad();
                        switch(operacion.getGestion()){
                            case VENDER:
                                juego.vender(ip);
                                break;
                            case HIPOTECAR:
                                juego.hipotecar(ip);
                                break;
                            case CANCELAR_HIPOTECA:
                                juego.cancelarHipoteca(ip);
                                break;
                            case CONSTRUIR_CASA:
                                juego.construirCasa(ip);
                                break;
                            case CONSTRUIR_HOTEL:
                                juego.construirHotel(ip);
                                break;
                            default:
                                break;
                        }
                        juego.siguientePasoCompleado(OperacionesJuego.GESTIONAR);
                        break;

                    case SALIR_CARCEL:
                        SalidasCarcel salida=vista.salirCarcel();
                        switch (salida) {
                            case PAGANDO:
                                juego.salirCarcelPagando();
                                juego.siguientePasoCompleado(OperacionesJuego.SALIR_CARCEL);
                                break;
                        
                            case TIRANDO:
                                juego.salirCarcelTirando();
                                juego.siguientePasoCompleado(OperacionesJuego.SALIR_CARCEL);
                                break;
                        }

                        break;
                
                    default:
                        break;
                }

                vista.actualizarVista();
            }
        }
    }
}