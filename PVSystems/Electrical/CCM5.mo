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
  v1 = (i1 - fs*Qr)*Ron/(d + fs*tr) + (1 - d)/d*(v2 + VD);
  -i2 = i1*(1 - d - fs*tr)/(d + fs*tr) - fs*Qr/(d + fs*tr);
end CCM5;
