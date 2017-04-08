within PVSystems.Electrical;
model CCM1 "Average CCM model with no losses"
  extends Interfaces.SwitchNetworkInterface;
  parameter Real dmin(final unit="1") = 1e-3 "Minimum duty cycle";
  parameter Real dmax(final unit="1") = 1 "Maximum duty cycle";
protected
  Real dsat(final unit="1") "Saturated duty cycle";
equation
  dsat = smooth(0, if d > dmax then dmax else if d < dmin then dmin else d);
  v1 = (1 - dsat)/dsat*v2;
  -i2 = (1 - dsat)/dsat*i1;
end CCM1;
