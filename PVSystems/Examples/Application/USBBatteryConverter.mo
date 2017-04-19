within PVSystems.Examples.Application;
model USBBatteryConverter "Bidirectional converter for USB battery interface"
  extends Modelica.Icons.Example;
  extends Modelica.Icons.UnderConstruction;
  Electrical.Assemblies.CPMBidirectionalBuckBoost conv(
    Cin=10e-6,
    Cout=88e-6,
    L=10e-6,
    Rf=1,
    fs=200e3,
    RL=8e-3,
    Va_buck=0.5,
    Va_boost=1,
    vCin_ini=12.6,
    vCout_ini=5,
    iL_ini=2) annotation (Placement(transformation(extent={{4,60},{24,80}})));
  Modelica.Blocks.Sources.RealExpression boostVs(y=20)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Blocks.Sources.RealExpression buckVs(y=5)
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Electrical.Analog.Basic.Resistor Rbatt(R=50e-3)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Blocks.Continuous.LimPID buckPI(
    k=10,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1,
    yMin=0,
    yMax=8) annotation (Placement(transformation(extent={{-30,-30},{-10,-50}})));
  Modelica.Blocks.Sources.RealExpression voutSense(y=conv.v2)
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Modelica.Blocks.Continuous.LimPID boostPI(
    k=10,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1,
    yMin=0,
    yMax=8) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Logical.Switch modeSelector annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,30})));
  Modelica.Electrical.Analog.Basic.VariableResistor Rload annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,70})));
  Modelica.Electrical.Analog.Sources.SignalVoltage Vbatt annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-50,70})));
  Modelica.Blocks.Sources.Ramp VbattSignal(
    duration=0.1,
    startTime=10,
    offset=12.6,
    height=9.6 - 12.6)
    annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
  Modelica.Blocks.Sources.Ramp RloadSignal(
    duration=0.1,
    startTime=10,
    offset=2.5,
    height=6.67 - 2.5)
    annotation (Placement(transformation(extent={{90,60},{70,80}})));
  Modelica.Blocks.Sources.BooleanExpression modeCommand(y=time > 10)
    annotation (Placement(transformation(extent={{-82,-80},{-50,-60}})));
equation
  connect(Rbatt.n, conv.p1) annotation (Line(points={{-20,80},{-6,80},{-6,75},{
          4,75}}, color={0,0,255}));
  connect(buckVs.y, buckPI.u_s)
    annotation (Line(points={{-49,-40},{-32,-40}}, color={0,0,127}));
  connect(voutSense.y, buckPI.u_m)
    annotation (Line(points={{-49,-20},{-20,-20},{-20,-28}}, color={0,0,127}));
  connect(boostVs.y, boostPI.u_s)
    annotation (Line(points={{-49,0},{-32,0}}, color={0,0,127}));
  connect(conv.n2, ground.p) annotation (Line(points={{24,65},{34,65},{34,60},{
          50,60}}, color={0,0,255}));
  connect(voutSense.y, boostPI.u_m) annotation (Line(points={{-49,-20},{-34,-20},
          {-20,-20},{-20,-12}},color={0,0,127}));
  connect(modeSelector.y, conv.vc)
    annotation (Line(points={{10,41},{10,41},{10,58}}, color={0,0,127}));
  connect(boostPI.y, modeSelector.u1)
    annotation (Line(points={{-9,0},{2,0},{2,18}}, color={0,0,127}));
  connect(buckPI.y, modeSelector.u3)
    annotation (Line(points={{-9,-40},{18,-40},{18,18}}, color={0,0,127}));
  connect(Vbatt.p, Rbatt.p)
    annotation (Line(points={{-50,80},{-46,80},{-40,80}}, color={0,0,255}));
  connect(Vbatt.n, conv.n1) annotation (Line(points={{-50,60},{-50,60},{-6,60},
          {-6,65},{4,65}}, color={0,0,255}));
  connect(ground.p, Rload.n)
    annotation (Line(points={{50,60},{50,60}}, color={0,0,255}));
  connect(Rload.p, conv.p2) annotation (Line(points={{50,80},{34,80},{34,75},{
          24,75}}, color={0,0,255}));
  connect(VbattSignal.y, Vbatt.v)
    annotation (Line(points={{-69,70},{-57,70}}, color={0,0,127}));
  connect(RloadSignal.y, Rload.R)
    annotation (Line(points={{69,70},{61,70}}, color={0,0,127}));
  connect(modeCommand.y, modeSelector.u2) annotation (Line(points={{-48.4,-70},
          {10,-70},{10,18}}, color={255,0,255}));
  connect(modeCommand.y, conv.mode) annotation (Line(points={{-48.4,-70},{30,
          -70},{30,50},{18,50},{18,58}}, color={255,0,255}));
  annotation (experiment(StopTime=5, Interval=0.001));
end USBBatteryConverter;
