package Solar "Solar PV elements" 
  model PVArray "Fundamental PV array model" 
    // TODO
    // - FIX whatever happens when v > Vocn, simulation stops
    // - What happens when too much reverse voltage is applied. Also, what
    //   *actually* happens to junction when reverse voltage is applied?
    // - Is it possible to algorithm at init of simulation to iterate and solve
    //   best Rp, Rs, Ipvn with parameter values?
    // - Cool to be able to provide thermal model of panel so that user can
    //   input ambient T in degrees instead of junction T in Kelvin
    // - Improve scope of parameters and variables
    // - Search for inspiration in AW2PS files
    // - Complete units by assigning appropriate SI class to vars and params
    extends Interfaces.OnePort;
    constant SI.Charge q=1.60217646e-19 "Electron charge";
    constant Real Gn=1000 "STC irradiation";
    constant SI.Temperature Tn=298.16 "STC temperature";
    // Basic datasheet parameters
    parameter SI.Current Imp=7.61 "Maximum power current";
    parameter SI.Voltage Vmp=26.3 "Maximum power voltage";
    parameter SI.Current Iscn=8.21 "Short circuit current";
    parameter SI.Voltage Vocn=32.9 "Open circuit voltage";
    parameter Real Kv=-0.123 "Voc temperature coefficient";
    parameter Real Ki=3.18e-3 "Isc temperature coefficient";
    // Basic model parameters
    parameter Real Ns=54 "Number of cells in series";
    parameter Real Np=1 "Number of cells in parallel";
    parameter SI.Resistance Rs=0.221 "Equivalent series resistance of array";
    parameter SI.Resistance Rp=415.405 
      "Equivalent parallel resistance of array";
    parameter Real a=1.3 "Diode ideality constant";
    // Derived model parameters
    parameter SI.Current Ipvn=Iscn "Photovoltaic current at STC";
    // Variables
    SI.Voltage Vt "Thermal voltage of the array";
    SI.Current Ipv "Photovoltaic current of the cell";
    SI.Current I0 "Saturation current of the cell";
    SI.Current Id "Diode current";
    SI.Current Ir "Rp current";
    // Annotation
    annotation (
      Coordsys(
        extent=[-100,-100;100,100],
        grid=[2,2],
        component=[20,20]),
      Documentation(
        info="<html><p><i>Amortiguador lineal dependiente de la velocidad</i>.
        Puede ser conectado entre una masa y un punto de referencia o entre
        dos masas.</p>
        <p><b>Nota</b>: elemento elaborado a partir de código de la librería
        Modelica.Mechanics.Translational.</p></html>"),
      Icon(
        Line(points=[-90,0;-60,0], style(color=0)),
        Rectangle(extent=[-60,-40;60,40], style(color=0,fillColor=7)),
        Line(points=[-60,-40;-20,0], style(color=0)),
        Line(points=[-20,0;-60,40], style(color=0)),
        Line(points=[60,0;90,0], style(color=0))),
      Diagram);
    Modelica.Blocks.Interfaces.InPort G(final n=1) "Solar irradiation" 
      annotation (extent=[-45,-70; -15,-40],
                                         rotation=90);
    Modelica.Blocks.Interfaces.InPort T(final n=1) "Panel temperature" 
      annotation (extent=[15,-70; 45,-40],
                                       rotation=90);
  equation 
    // Auxiliary variables
    Vt = Ns*C.k*T.signal[1]/q;
    Ipv = (Ipvn + Ki*(T.signal[1]-Tn)) * G.signal[1]/Gn;
    I0 = (Iscn + Ki*(T.signal[1]-Tn)) / (exp((Vocn+Kv*(T.signal[1]-Tn))/a/Vt) - 1);
    Id = I0 * (exp((v-Rs*i)/a/Vt) - 1);
    Ir = (v-Rs*i)/Rp;
    i = if v < 0 then 
      v / ((Rs+Rp)/Np) else 
      -Np * (Ipv - Id - Ir);
  end PVArray;
end Solar;
