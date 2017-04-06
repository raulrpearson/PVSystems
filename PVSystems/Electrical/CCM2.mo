within PVSystems.Electrical;
model CCM2 "Average CCM model with conduction losses"
  extends Interfaces.SwitchNetworkInterface;
  parameter Modelica.SIunits.Resistance Ron=0 "Transistor on resistance";
  parameter Modelica.SIunits.Resistance RD=0 "Diode on resistance";
  parameter Modelica.SIunits.Voltage VD=0 "Diode forward voltage drop";
equation
  v1 = i1*(Ron/d + (1 - d)*RD/d^2) + (1 - d)/d*(v2 + VD);
  -i2 = i1*(1 - d)/d;
end CCM2;
