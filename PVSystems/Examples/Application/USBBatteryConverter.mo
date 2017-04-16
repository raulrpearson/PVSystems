within PVSystems.Examples.Application;
model USBBatteryConverter "Bidirectional converter for USB battery interface"
  extends Modelica.Icons.Example;
  Electrical.Assemblies.CPMBidirectionalBuckBoost conv(
    Cin=10e-6,
    Cout=88e-6,
    L=10e-6,
    Rf=1,
    fs=200e3,
    RL=8e-3,
    Va_buck=0.3,
    Va_boost=0.9,
    vCin_ini=12.6,
    vCout_ini=5,
    iL_ini=2) annotation (Placement(transformation(extent={{4,40},{24,60}})));
  Modelica.Blocks.Sources.RealExpression boostVs(y=20)
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Modelica.Blocks.Sources.RealExpression buckVs(y=5)
    annotation (Placement(transformation(extent={{-70,-70},{-50,-50}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Modelica.Electrical.Analog.Basic.Resistor Rbatt(R=50e-3)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Blocks.Continuous.LimPID buckPI(
    k=10,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1,
    yMin=0,
    yMax=10)
    annotation (Placement(transformation(extent={{-30,-50},{-10,-70}})));
  Modelica.Blocks.Sources.RealExpression voutSense(y=conv.v2)
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  Modelica.Blocks.Continuous.LimPID boostPI(
    k=10,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1,
    yMin=0,
    yMax=10)
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Modelica.Blocks.Logical.Switch modeSelector annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,10})));
  Modelica.Blocks.Sources.BooleanExpression modeCommand(y=time > 10)
    annotation (Placement(transformation(extent={{70,-30},{44,-10}})));
  Modelica.Electrical.Analog.Basic.VariableResistor Rload annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,50})));
  Modelica.Electrical.Analog.Sources.SignalVoltage Vbatt annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-50,50})));
  Modelica.Blocks.Sources.Ramp VbattSignal(
    height=-3,
    duration=0.1,
    offset=12.6,
    startTime=10)
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Modelica.Blocks.Sources.Ramp RloadSignal(
    duration=0.1,
    startTime=10,
    height=6.67 - 2.5,
    offset=2.5) annotation (Placement(transformation(extent={{90,40},{70,60}})));
equation
  connect(Rbatt.n, conv.p1) annotation (Line(points={{-20,60},{-6,60},{-6,55},{
          4,55}}, color={0,0,255}));
  connect(buckVs.y, buckPI.u_s)
    annotation (Line(points={{-49,-60},{-32,-60}}, color={0,0,127}));
  connect(voutSense.y, buckPI.u_m)
    annotation (Line(points={{-49,-40},{-20,-40},{-20,-48}}, color={0,0,127}));
  connect(boostVs.y, boostPI.u_s)
    annotation (Line(points={{-49,-20},{-32,-20}}, color={0,0,127}));
  connect(conv.n2, ground.p) annotation (Line(points={{24,45},{34,45},{34,40},{
          50,40}}, color={0,0,255}));
  connect(modeCommand.y, modeSelector.u2)
    annotation (Line(points={{42.7,-20},{10,-20},{10,-2}}, color={255,0,255}));
  connect(modeCommand.y, conv.mode) annotation (Line(points={{42.7,-20},{34,-20},
          {34,30},{18,30},{18,38}}, color={255,0,255}));
  connect(voutSense.y, boostPI.u_m) annotation (Line(points={{-49,-40},{-34,-40},
          {-20,-40},{-20,-32}},color={0,0,127}));
  connect(modeSelector.y, conv.vc)
    annotation (Line(points={{10,21},{10,21},{10,38}}, color={0,0,127}));
  connect(boostPI.y, modeSelector.u1)
    annotation (Line(points={{-9,-20},{2,-20},{2,-2}}, color={0,0,127}));
  connect(buckPI.y, modeSelector.u3)
    annotation (Line(points={{-9,-60},{18,-60},{18,-2}}, color={0,0,127}));
  connect(Vbatt.p, Rbatt.p)
    annotation (Line(points={{-50,60},{-46,60},{-40,60}}, color={0,0,255}));
  connect(Vbatt.n, conv.n1) annotation (Line(points={{-50,40},{-50,40},{-6,40},
          {-6,45},{4,45}}, color={0,0,255}));
  connect(ground.p, Rload.n)
    annotation (Line(points={{50,40},{50,40}}, color={0,0,255}));
  connect(Rload.p, conv.p2) annotation (Line(points={{50,60},{34,60},{34,55},{
          24,55}}, color={0,0,255}));
  connect(VbattSignal.y, Vbatt.v)
    annotation (Line(points={{-69,50},{-57,50}}, color={0,0,127}));
  connect(RloadSignal.y, Rload.R)
    annotation (Line(points={{69,50},{61,50}}, color={0,0,127}));
end USBBatteryConverter;
