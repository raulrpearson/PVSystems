within PVSystems.Electrical;
model CCM3 "Average CCM model with no losses and tranformer"
  extends Interfaces.SwitchNetworkInterface;
  parameter Real n(final unit="1") = 1
    "Transformer turns ratio 1:n (primary:secondary)";
equation
  v1 = (1 - d)*v2/d/n;
  -i2 = (1 - d)*i1/d/n;
end CCM3;
