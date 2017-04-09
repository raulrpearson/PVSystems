within PVSystems.Electrical;
model CCM_DCM1 "Average CCM-DCM model with no losses"
  extends Interfaces.SwitchNetworkInterface;
  parameter Modelica.SIunits.Inductance Le "Equivalent DCM inductance";
  parameter Modelica.SIunits.Frequency fs "Switching frequency";
protected
  Real mu "Effective switch conversion ratio";
  Real Re "Equivalent DCM port 1 resistance";
equation
  Re = 2*Le*fs/dsat^2;
  mu = max(dsat, 1/(1 + Re*i1/v2));
  v1 = (1 - mu)/mu*v2;
  -i2 = (1 - mu)/mu*i1;
end CCM_DCM1;
