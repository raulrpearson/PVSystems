within PVSystems.Examples.Application;
model PVInverter1phSynch
  "Simple PV system including PV array, inverter and grid"
  extends Modelica.Icons.Example;
  extends Modelica.Icons.UnderConstruction;
  Electrical.PVArray PV(v(start=450)) annotation (Placement(transformation(
        origin={-110,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Constant Gn(k=1000) annotation (Placement(
        transformation(extent={{-148,80},{-128,100}}, rotation=0)));
  Modelica.Blocks.Sources.Constant Tn(k=298.15) annotation (Placement(
        transformation(extent={{-148,40},{-128,60}}, rotation=0)));
  PVSystems.Electrical.Assemblies.HBridgeAveraged Inverter annotation (
      Placement(transformation(extent={{-10,60},{10,80}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.SineVoltage Grid(freqHz=50, V=25)
    annotation (Placement(transformation(
        origin={90,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor L(L=500e-6) annotation (Placement(
        transformation(
        origin={90,66},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor R(R=10e-3) annotation (Placement(
        transformation(
        origin={90,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor VSac annotation (Placement(
        transformation(
        origin={60,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor C(C=5e-3, v(start=32.8))
    annotation (Placement(transformation(
        origin={-26,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Control.Assemblies.ControllerInverter1ph Controller annotation (Placement(
        transformation(
        origin={0,28},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor VSdc annotation (Placement(
        transformation(
        origin={-52,-10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor CSdc annotation (Placement(
        transformation(extent={{-52,70},{-32,90}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor CSac annotation (Placement(
        transformation(extent={{30,80},{50,100}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.PowerSensor PSac annotation (Placement(
        transformation(extent={{60,80},{80,100}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.PowerSensor PSdc annotation (Placement(
        transformation(extent={{-102,70},{-82,90}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor L1(L=500e-6) annotation (Placement(
        transformation(
        origin={26,42},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=10e-3) annotation (Placement(
        transformation(
        origin={26,6},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=1e-3, v(start=30))
    annotation (Placement(transformation(extent={{-76,70},{-56,90}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-62,-48},{-42,-28}}, rotation=0)));
equation
  connect(Gn.y, PV.G) annotation (Line(points={{-127,90},{-122,90},{-122,73},{-115.5,
          73}}, color={0,0,127}));
  connect(Tn.y, PV.T) annotation (Line(points={{-127,50},{-122,50},{-122,67},{-115.5,
          67}}, color={0,0,127}));
  connect(C.p, Inverter.p1) annotation (Line(points={{-26,80},{-16,80},{-16,75},
          {-10,75}}, color={0,0,255}));
  connect(Controller.d, Inverter.d) annotation (Line(points={{-6.73533e-016,39},
          {-6.73533e-016,58},{0,58}}, color={0,0,127}));
  connect(PV.n, VSdc.n) annotation (Line(points={{-110,60},{-110,-20},{-52,-20}},
        color={0,0,255}));
  connect(VSdc.n, C.n)
    annotation (Line(points={{-52,-20},{-26,-20},{-26,60}}, color={0,0,255}));
  connect(VSdc.v, Controller.vdc)
    annotation (Line(points={{-42,-10},{-7,-10},{-7,17}}, color={0,0,127}));
  connect(CSdc.n, C.p)
    annotation (Line(points={{-32,80},{-26,80}}, color={0,0,255}));
  connect(CSdc.i, Controller.idc) annotation (Line(points={{-42,70},{-42,6},{-3,
          6},{-3,17}}, color={0,0,127}));
  connect(VSdc.p, CSdc.p)
    annotation (Line(points={{-52,0},{-52,80}}, color={0,0,255}));
  connect(VSac.n, Grid.n)
    annotation (Line(points={{60,-20},{90,-20}}, color={0,0,255}));
  connect(VSac.p, Grid.p)
    annotation (Line(points={{60,0},{90,0}}, color={0,0,255}));
  connect(Controller.vac, VSac.v) annotation (Line(points={{3,17},{4,17},{4,-10},
          {50,-10}}, color={0,0,127}));
  connect(R.n, Grid.p)
    annotation (Line(points={{90,20},{90,0}}, color={0,0,255}));
  connect(L.n, R.p)
    annotation (Line(points={{90,56},{90,40}}, color={0,0,255}));
  connect(Inverter.p2, CSac.p) annotation (Line(points={{10,75},{26,75},{26,90},
          {30,90}}, color={0,0,255}));
  connect(CSac.i, Controller.iac)
    annotation (Line(points={{40,80},{40,6},{8,6},{8,17}}, color={0,0,127}));
  connect(PSdc.pv, PV.p)
    annotation (Line(points={{-92,90},{-110,90},{-110,80}}, color={0,0,255}));
  connect(PSdc.nv, VSdc.n)
    annotation (Line(points={{-92,70},{-92,-20},{-52,-20}}, color={0,0,255}));
  connect(PSac.pc, CSac.n)
    annotation (Line(points={{60,90},{50,90}}, color={0,0,255}));
  connect(PSac.nc, L.p)
    annotation (Line(points={{80,90},{90,90},{90,76}}, color={0,0,255}));
  connect(PSac.pv, PSac.pc)
    annotation (Line(points={{70,100},{60,100},{60,90}}, color={0,0,255}));
  connect(PSac.nv, VSac.n)
    annotation (Line(points={{70,80},{70,-20},{60,-20}}, color={0,0,255}));
  connect(L1.n, R1.p) annotation (Line(points={{26,32},{26,28},{26,28},{26,24},
          {26,16},{26,16}}, color={0,0,255}));
  connect(Inverter.n2, L1.p)
    annotation (Line(points={{10,65},{26,65},{26,52}}, color={0,0,255}));
  connect(R1.n, VSac.n)
    annotation (Line(points={{26,-4},{26,-20},{60,-20}}, color={0,0,255}));
  connect(resistor.n, CSdc.p)
    annotation (Line(points={{-56,80},{-52,80}}, color={0,0,255}));
  connect(PV.p, PSdc.pc)
    annotation (Line(points={{-110,80},{-102,80}}, color={0,0,255}));
  connect(PSdc.nc, resistor.p)
    annotation (Line(points={{-82,80},{-76,80}}, color={0,0,255}));
  connect(C.n, Inverter.n1) annotation (Line(points={{-26,60},{-16,60},{-16,65},
          {-10,65}}, color={0,0,255}));
  connect(ground.p, VSdc.n)
    annotation (Line(points={{-52,-28},{-52,-20}}, color={0,0,255}));
  annotation (Diagram(graphics), Icon(graphics));
end PVInverter1phSynch;
