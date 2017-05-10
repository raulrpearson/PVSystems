within PVSystems.Electrical;
model CCM_DCM1 "Average CCM-DCM model with no losses"
  extends Interfaces.SwitchNetworkInterface;
  parameter Modelica.SIunits.Inductance Le "Equivalent DCM inductance";
  parameter Modelica.SIunits.Frequency fs "Switching frequency";
protected
  Real mu "Effective switch conversion ratio";
  Real Re "Equivalent DCM port 1 resistance";
equation
  0 = p1.i + n1.i;
  0 = p2.i + n2.i;
  Re = 2*Le*fs/dsat^2;
  mu = max(dsat, 1/(1 + Re*i1/v2));
  v1 = (1 - mu)/mu*v2;
  -i2 = (1 - mu)/mu*i1;
  annotation(Documentation(info="<html>
      <p>
        <em>Application</em>: two-switch PWM converters, CCM or DCM.
      </p>
    
      <p>
        <em>Limitations</em>: ideal switches, no transformer.
      </p>
    
      <p>
        Model taken
        from <a href=\"modelica://PVSystems.UsersGuide.References.EM01\">EM01</a>
        and <a href=\"modelica://PVSystems.UsersGuide.References.EMA16\">EMA16</a>.</p>
    </html>"));
end CCM_DCM1;
