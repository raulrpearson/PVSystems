within PVSystems.Electrical;
model CCM3 "Average CCM model with no losses and tranformer"
  extends Interfaces.SwitchNetworkInterface;
  parameter Real n(final unit="1") = 1
    "Transformer turns ratio 1:n (primary:secondary)";
equation
  v1 = (1 - dsat)*v2/dsat/n;
  -i2 = (1 - dsat)*i1/dsat/n;
  annotation(Documentation(info="<html>
      <p>
        <em>Application</em>: two-switch PWM converters, with (possibly)
        transformer.
      </p>
    
      <p>
        <em>Limitations</em>: ideal switches, CCM only.
      </p>
    
      <p>
        Model taken
        from <a href=\"modelica://PVSystems.UsersGuide.References.EM01\">EM01</a>
        and <a href=\"modelica://PVSystems.UsersGuide.References.EMA16\">EMA16</a>.</p>
    </html>"));
end CCM3;
