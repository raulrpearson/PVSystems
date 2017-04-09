within PVSystems.Electrical;
model CCM1 "Average CCM model with no losses"
  extends Interfaces.SwitchNetworkInterface;
equation
  v1 = (1 - dsat)/dsat*v2;
  -i2 = (1 - dsat)/dsat*i1;
end CCM1;
