within PVSystems.Electrical;
model CCM5
  "Average CCM model with conduction losses and diode reverse recovery"
  extends Interfaces.SwitchNetworkInterface;
  parameter Modelica.SIunits.Resistance Ron=0 "Transistor on resistance";
  parameter Modelica.SIunits.Voltage VD=0 "Diode forward voltage drop";
  parameter Modelica.SIunits.Charge Qr "Diode reverse recovery charge";
  parameter Modelica.SIunits.Time tr "Diode reverse recovery time";
  parameter Modelica.SIunits.Frequency fs "Switching frequency";
equation
  0 = p1.i + n1.i;
  0 = p2.i + n2.i;
  v1 = (i1 - fs*Qr)*Ron/(dsat + fs*tr) + (1 - dsat)/dsat*(v2 + VD);
  -i2 = i1*(1 - dsat - fs*tr)/(dsat + fs*tr) - fs*Qr/(dsat + fs*tr);
  annotation(Documentation(info="<html>
      <p>
        <em>Application</em>: two-switch PWM converters, includes
        conduction losses due to Ron, VD and diode reverse recovery
        losses.
      </p>
    
      <p>
        <em>Limitations</em>: CCM only, d'&gt;tr/Ts, &lt;i1&gt; &gt;
        Qr/Ts.
      </p>
    
      <p>
        Model taken
        from <a href=\"modelica://PVSystems.UsersGuide.References.EM01\">EM01</a>
        and <a href=\"modelica://PVSystems.UsersGuide.References.EMA16\">EMA16</a>.</p>
    </html>"));
end CCM5;
