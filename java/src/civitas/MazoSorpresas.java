package civitas;

import java.util.ArrayList;
import java.util.Collections;

public class MazoSorpresas{
    private ArrayList<Sorpresa> sorpresas;
    private boolean barajada;
    private int usadas;
    private boolean debug;
    private ArrayList<Sorpresa> cartasEspeciales;
    private Sorpresa ultimaSorpresa;

    private void init()
    {
        barajada=false;
        usadas=0;
        sorpresas=new ArrayList<Sorpresa>();
        cartasEspeciales=new ArrayList<Sorpresa>();
    }

    MazoSorpresas(){
        init();
        debug=false;
    }

    MazoSorpresas(boolean d){
        init();
        debug=d;
        if (d) Diario.getInstance().ocurreEvento("MazoSorpresas--Modo debug: activado");
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
        usadas++;
        ultimaSorpresa=sorpresas.get(0);
        sorpresas.remove(0);

        return ultimaSorpresa;
    }

    void inhabilitarCartaEspecial(Sorpresa sorpresa){
        boolean esta=false;
        for (int i=0; i<sorpresas.size() && !esta; i++){
            if (sorpresa==sorpresas.get(i)){
                cartasEspeciales.add(sorpresas.remove(i));
                Diario.getInstance().ocurreEvento("MazoSorpresas--Carta especial inhabilitada");
                esta=true;
            }
        }
    }

    void habilitarCartaEspecial (Sorpresa sorpresa){
        boolean esta=false;
        for (int i=0; i<cartasEspeciales.size() && !esta; i++){
            if (sorpresa==cartasEspeciales.get(i)){
                sorpresas.add(cartasEspeciales.remove(i));
                Diario.getInstance().ocurreEvento("MazoSorpresas--Carta especial habilitada");
                esta=true;
            }
        }
    }
    
}