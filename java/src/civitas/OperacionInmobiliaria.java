package civitas;

class OperacionInmobiliaria{
    private int numPropiedad;
    private GestionesInmobiliarias gestion;

    public GestionesInmobiliarias getGestionesInmobiliarias(){return gestion;}
    public int getNumPropiedad(){return numPropiedad;}
    
    OperacionInmobiliaria(GestionesInmobiliarias gest, int ip){
        gestion=gest;
        numPropiedad=ip;
    }
}   