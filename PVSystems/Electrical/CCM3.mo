within PVSystems.Electrical;
model CCM3 "Average CCM model with no losses and tranformer"
  extends Interfaces.SwitchNetworkInterface;
  parameter Real n(final unit="1") = 1
    "Transformer turns ratio 1:n (primary:secondary)";
equation
  v1 = (1 - dsat)*v2/dsat/n;
  -i2 = (1 - dsat)*i1/dsat/n;
end CCM3;
