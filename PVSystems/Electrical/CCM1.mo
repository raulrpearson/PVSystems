within PVSystems.Electrical;
model CCM1 "Average CCM model with no losses"
  extends Interfaces.SwitchNetworkInterface;
equation
  0 = p1.i + n1.i;
  0 = p2.i + n2.i;
  v1 = (1 - dsat)/dsat*v2;
  -i2 = (1 - dsat)/dsat*i1;
  annotation(Documentation(info="<html>
      <p>
        <em>Application</em>: two-switch PWM converters.
      </p>
    
      <p>
        <em>Limitations</em>: ideal switches, CCM only, no transformer.
      </p>
    
      <p>
        Model taken
        from <a href=\"modelica://PVSystems.UsersGuide.References.EM01\">EM01</a>
        and <a href=\"modelica://PVSystems.UsersGuide.References.EMA16\">EMA16</a>.</p>
    </html>"));
end CCM1;
