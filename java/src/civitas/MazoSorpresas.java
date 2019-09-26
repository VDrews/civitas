package civitas;

import java.util.ArrayList;

public class MazoSorpresas{
    private ArrayList<Sorpresa> sorpresas;
    private boolean barajada;
    private int usadas;
    private int debug;
    private ArrayList<Sorpresa> cartasEspeciales;
    private Sorpresa ultimaSorpresa;

    private void init()
    {
        barajada=false;
        usadas=0;
        sorpresas=new ArrayList<Sorpresa>();
        cartasEspeciales=new ArrayList<Sorpresa>();
    }

    public MazoSorpresas(){
        init();
        debug=false;
    }

    public MazoSorpresas(boolean d){
        init();
        debug=d;
    }

    void alMazo(Sorpresa s){
        if (!barajada) sorpresas.add(s);
    }

    Sorpresa siguiente(){
        if (!barajada || usadas==sorpresas.size()){
            Collections.shuffle(sorpresas);
            usadas=0;
            barajada=true;
        }
    }

    void inhabilitarCartaEspecial(Sorpresa sorpresa){
        
    }
}