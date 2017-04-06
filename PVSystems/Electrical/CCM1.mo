within PVSystems.Electrical;
model CCM1 "Average CCM model with no losses"
  extends Interfaces.SwitchNetworkInterface;
equation
  v1 = (1 - d)/d*v2;
  -i2 = (1 - d)/d*i1;
end CCM1;
