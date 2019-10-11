package civitas;

class Comparable implements Comparator<Jugador> {
    public int compare(Jugador j1, Jugador j2) {
        return j1.compareTo(j2);
    }
}