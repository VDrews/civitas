package civitas;

import java.util.ArrayList;

public class Tablero {
    private int numCasillaCarcel;
    private ArrayList<Casilla> casillas;
    private int porSalida;
    private boolean tieneJuez;

    Tablero(int indice) {
        if (indice >= 1)
            numCasillaCarcel = indice;
        else
            numCasillaCarcel = 1;

        casillas = new ArrayList<Casilla>();
        Casilla s = new Casilla("Salida");
        casillas.add(s);

        porSalida = 0;

        tieneJuez = false;

    }

    private boolean correcto() {
        return numCasillaCarcel < casillas.size();
    }

    private boolean correcto(int numCasilla) {
        if (numCasilla >= 0 && numCasilla < casillas.size())
            return correcto();
        else
            return false;
    }

    int getCarcel() {
        return numCasillaCarcel;
    }

    int getPorSalida() {
        if (porSalida > 0) {
            porSalida--;
            return (porSalida + 1);
        } else
            return porSalida;
    }

    void añadeCasilla(Casilla casilla) {
        if (casillas.size() == numCasillaCarcel)
            casillas.add(new Casilla("Cárcel"));
        casillas.add(casilla);
        if (casillas.size() == numCasillaCarcel)
            casillas.add(new Casilla("Cárcel"));
    }

    void añadeJuez() {
        if (!tieneJuez) {
            casillas.add(new Casilla(numCasillaCarcel, "Juez"));
            tieneJuez = true;
        }
    }

    Casilla getCasilla(int numCasilla) {
        if (correcto(numCasilla))
            return casillas.get(numCasilla);
        else
            return null;
    }

    int nuevaPosicion(int actual, int tirada) {
        if (!correcto())
            return -1;
        else {
            int posicion = (actual + tirada) % casillas.size();
            if (posicion != (actual + tirada))
                porSalida++;
            return posicion;
        }
    }

    int calcularTirada(int origen, int destino) {
        int resultado = destino - origen;
        if (resultado < 0)
            resultado += casillas.size();
        return resultado;
    }

}
