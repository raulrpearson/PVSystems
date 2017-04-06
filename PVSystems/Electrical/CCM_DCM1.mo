within PVSystems.Electrical;
model CCM_DCM1
  "Average switch model for any ideal 2-switch PWM converter in DCM"
  extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  extends Interfaces.SwitchNetworkInterface;
  parameter Modelica.SIunits.Inductance Le "Equivalent DCM inductance";
  parameter Modelica.SIunits.Frequency fs "Switching frequency";
  Real mu "Effective switch conversion ratio";
  Real Re "Equivalent DCM port 1 resistance";
equation
  Re = 2*Le*fs/d^2;
  mu = max(d, 1/(1 + Re*i1/v2));
  v1 = (1 - mu)/mu*v2;
  -i2 = (1 - mu)/mu*i1;
end CCM_DCM1;
