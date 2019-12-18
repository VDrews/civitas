/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package GUI;
import civitas.TituloPropiedad;

/**
 *
 * @author chemooon
 */
public class PropiedadPanel extends javax.swing.JPanel {

    /**
     * Creates new form PropiedadPanel
     */
    public PropiedadPanel() {
        initComponents();
    }
    
    private TituloPropiedad tituloPropiedad;
    public void setPropiedad(TituloPropiedad tituloPropiedad){
        this.tituloPropiedad=tituloPropiedad;
        text_nombre.setText(tituloPropiedad.getNombre());
        text_alqbase.setText(String.valueOf(tituloPropiedad.getAlquilerBase()));
        text_numCasas.setText(String.valueOf(tituloPropiedad.getNumCasas()));
        text_numHoteles.setText(String.valueOf(tituloPropiedad.getNumHoteles()));
        text_hipotecada.setText(String.valueOf(tituloPropiedad.getHipotecado()));
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        titulo = new javax.swing.JLabel();
        label_nombre = new javax.swing.JLabel();
        text_nombre = new javax.swing.JTextField();
        label_alqbase = new javax.swing.JLabel();
        text_alqbase = new javax.swing.JTextField();
        label_numCasas = new javax.swing.JLabel();
        text_numCasas = new javax.swing.JTextField();
        label_numHoteles = new javax.swing.JLabel();
        label_hipotecada = new javax.swing.JLabel();
        text_numHoteles = new javax.swing.JTextField();
        text_hipotecada = new javax.swing.JTextField();

        titulo.setText("TÍTULO DE PROPIEDAD");
        titulo.setEnabled(false);

        label_nombre.setText("Nombre");
        label_nombre.setEnabled(false);

        text_nombre.setText("jTextField1");
        text_nombre.setEnabled(false);

        label_alqbase.setText("Alquiler base");
        label_alqbase.setEnabled(false);

        text_alqbase.setText("jTextField2");
        text_alqbase.setEnabled(false);

        label_numCasas.setText("Nr. de casas");
        label_numCasas.setEnabled(false);

        text_numCasas.setText("jTextField3");
        text_numCasas.setEnabled(false);

        label_numHoteles.setText("Nr. de hoteles");
        label_numHoteles.setEnabled(false);

        label_hipotecada.setText("¿Hipotecada?");
        label_hipotecada.setEnabled(false);

        text_numHoteles.setText("jTextField3");
        text_numHoteles.setEnabled(false);

        text_hipotecada.setText("jTextField5");
        text_hipotecada.setEnabled(false);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(117, 117, 117)
                .addComponent(titulo)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(layout.createSequentialGroup()
                .addGap(56, 56, 56)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(label_hipotecada)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(text_hipotecada, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(label_numHoteles)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 101, Short.MAX_VALUE)
                        .addComponent(text_numHoteles, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(label_numCasas)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(text_numCasas, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(label_alqbase)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(text_alqbase, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(label_nombre)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(text_nombre, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(56, 56, 56))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(titulo)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(label_nombre)
                    .addComponent(text_nombre, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(label_alqbase)
                    .addComponent(text_alqbase, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(38, 38, 38)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(label_numCasas)
                    .addComponent(text_numCasas, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(label_numHoteles)
                    .addComponent(text_numHoteles, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(text_hipotecada, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(label_hipotecada))
                .addContainerGap(40, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel label_alqbase;
    private javax.swing.JLabel label_hipotecada;
    private javax.swing.JLabel label_nombre;
    private javax.swing.JLabel label_numCasas;
    private javax.swing.JLabel label_numHoteles;
    private javax.swing.JTextField text_alqbase;
    private javax.swing.JTextField text_hipotecada;
    private javax.swing.JTextField text_nombre;
    private javax.swing.JTextField text_numCasas;
    private javax.swing.JTextField text_numHoteles;
    private javax.swing.JLabel titulo;
    // End of variables declaration//GEN-END:variables
}
