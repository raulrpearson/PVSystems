within PVSystems.Examples.Application;
model USBBatteryConverter "Bidirectional converter for USB battery interface"
  extends Modelica.Icons.Example;
  extends Modelica.Icons.UnderConstruction;
  Electrical.Assemblies.CPMBidirectionalBuckBoost converter(
    Cin=10e-6,
    Cout=88e-6,
    L=10e-6,
    Rf=1,
    fs=200e3,
    Va_buck=0.65,
    Va_boost=1.3,
    vCin_ini=12.6,
    vCout_ini=5,
    iL_ini=2,
    RL=8e-3) annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage Vbatt(V=12.6) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,50})));
  Modelica.Electrical.Analog.Basic.Resistor Rload(R=2.5) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,50})));
  Modelica.Blocks.Sources.RealExpression vc_boost(y=0)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Sources.RealExpression vc_buck(y=5)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{70,0},{90,20}})));
  Modelica.Electrical.Analog.Basic.Resistor Rbatt(R=50e-3)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Continuous.PI PI(k=10, T=1)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Blocks.Sources.RealExpression vout_sense(y=converter.v2)
    annotation (Placement(transformation(extent={{-90,-30},{-60,-10}})));
equation
  connect(Vbatt.n, converter.n1) annotation (Line(points={{-80,40},{0,40},{0,45},
          {20,45}}, color={0,0,255}));
  connect(converter.p2, Rload.p) annotation (Line(points={{40,55},{60,55},{60,
          60},{80,60}}, color={0,0,255}));
  connect(converter.n2, Rload.n) annotation (Line(points={{40,45},{60,45},{60,
          40},{80,40}}, color={0,0,255}));
  connect(ground.p, Rload.n)
    annotation (Line(points={{80,20},{80,20},{80,40}}, color={0,0,255}));
  connect(Vbatt.p, Rbatt.p)
    annotation (Line(points={{-80,60},{-70,60},{-60,60}}, color={0,0,255}));
  connect(Rbatt.n, converter.p1) annotation (Line(points={{-40,60},{0,60},{0,55},
          {20,55}}, color={0,0,255}));
  connect(feedback.y, PI.u)
    annotation (Line(points={{-31,10},{-22,10}}, color={0,0,127}));
  connect(PI.y, converter.vc_buck)
    annotation (Line(points={{1,10},{25,10},{25,38}}, color={0,0,127}));
  connect(vc_buck.y, feedback.u1)
    annotation (Line(points={{-59,10},{-48,10}}, color={0,0,127}));
  connect(vc_boost.y, converter.vc_boost)
    annotation (Line(points={{-59,-50},{35,-50},{35,38}}, color={0,0,127}));
  connect(vout_sense.y, feedback.u2)
    annotation (Line(points={{-58.5,-20},{-40,-20},{-40,2}}, color={0,0,127}));
end USBBatteryConverter;
