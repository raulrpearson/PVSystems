within PVSystems.Electrical;
model CCM1 "Average switch model for any ideal 2-switch PWM converter in CCM"
  extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  extends Interfaces.SwitchNetworkInterface;
  Modelica.Blocks.Interfaces.RealInput d "Duty cycle" annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{-20,-20},{20,20}},
        rotation=90)));
equation
  v1 = (1 - d)/d*v2;
  -i2 = (1 - d)/d*i1;
end CCM1;
