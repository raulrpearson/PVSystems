within PVSystems.Electrical;
model CCM4 "Average CCM model with conduction losses and tranformer"
  extends Interfaces.SwitchNetworkInterface;
  parameter Modelica.SIunits.Resistance Ron=0 "Transistor on resistance";
  parameter Modelica.SIunits.Resistance RD=0 "Diode on resistance";
  parameter Real n(final unit="1") = 1
    "Transformer turns ratio 1:n (primary:secondary)";
equation
  v1 = i1*(Ron/dsat + (1 - dsat)*RD/n^2/dsat^2) + (1 - dsat)/dsat/n*v2;
  -i2 = i1*(1 - dsat)/dsat/n;
  annotation(Documentation(info="<html>
      <p>
        <em>Application</em>: two-switch PWM converters, includes
        conduction losses due to Ron, VD, RD and (possibly) transformer.
      </p>
    
      <p>
        <em>Limitations</em>: CCM only.
      </p>
    
      <p>
        Model taken
        from <a href=\"modelica://PVSystems.UsersGuide.References.EM01\">EM01</a>
        and <a href=\"modelica://PVSystems.UsersGuide.References.EMA16\">EMA16</a>.</p>
    </html>"));
end CCM4;
