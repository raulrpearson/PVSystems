package Examples "Application examples"
  extends Modelica.Icons.Library;
  import SI = Modelica.SIunits;


  annotation (
    Documentation(info="<html><p>Librería sencilla con elementos
      mecánicos 1D. La librería está estructurada en los siguientes 
      paquetes:</p>
      <ul>
        <li><b>Interfaces</b>: que incluye los puertos, anotaciones
          e interfaces usados por el resto de bloques, 
          fundamentalmente en el paquete <i>Elementos</i>.</li>
        <li><b>Elementos</b>: que incluye los elementos, con 
          anotaciones gráficas que facilitan su uso con programas 
          como Dymola, para la construcción de sistemas más 
        complejos.</li>
        <li><b>Ejemplos</b>: que incluye ejemplos de uso de los 
          elementos de la librería <i>Elementos</i> para construir
          sistemas más complejos.</li>
      </ul></html>"),
    uses(Modelica(version="1.6")));
end Examples;
