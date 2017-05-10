within PVSystems.Examples.Application;
model PVInverter1phSynch
  "Simple PV system including PV array, inverter and grid"
  extends Modelica.Icons.Example;
  Electrical.PVArray PV(v(start=450)) annotation (Placement(transformation(
        origin={-40,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Constant Gn(k=1000) annotation (Placement(
        transformation(extent={{-80,70},{-60,90}}, rotation=0)));
  Modelica.Blocks.Sources.Constant Tn(k=298.15) annotation (Placement(
        transformation(extent={{-80,30},{-60,50}}, rotation=0)));
  PVSystems.Electrical.Assemblies.HBridge Inverter(redeclare model SwitchModel
      = Electrical.SwitchedSynchronousBidirectional (fs=3125)) annotation (
      Placement(transformation(extent={{40,60},{60,80}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.SineVoltage Grid(freqHz=50, V=15)
    annotation (Placement(transformation(
        origin={86,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor L(L=200e-6) annotation (Placement(
        transformation(
        origin={86,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor R(R=10e-3) annotation (Placement(
        transformation(
        origin={86,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor C(v(start=32.8), C=0.5)
    annotation (Placement(transformation(
        origin={24,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Control.Assemblies.Inverter1phCompleteController Controller(
    ik=0.1,
    iT=0.01,
    vdcMax=40,
    fline=50,
    idMax=15,
    iqMax=10,
    vk=10,
    vT=0.5) annotation (Placement(transformation(
        origin={30,-10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=1e-3, v(start=30))
    annotation (Placement(transformation(extent={{-20,70},{0,90}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-20,40},{0,60}}, rotation=0)));
  Modelica.Blocks.Sources.RealExpression vdcSense(y=PV.v)
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Sources.RealExpression idcSense(y=-PV.i)
    annotation (Placement(transformation(extent={{-40,-16},{-20,4}})));
  Modelica.Blocks.Sources.RealExpression iacSense(y=Grid.i)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Sources.RealExpression vacSense(y=Grid.v)
    annotation (Placement(transformation(extent={{-40,-64},{-20,-44}})));
  Modelica.Blocks.Sources.RealExpression dcPower(y=-PV.i*PV.v)
    annotation (Placement(transformation(extent={{40,-72},{60,-52}})));
  Modelica.Blocks.Sources.RealExpression acPower(y=Grid.v*Grid.i)
    annotation (Placement(transformation(extent={{40,-92},{60,-72}})));
  Modelica.Blocks.Math.Mean mean(f=50)
    annotation (Placement(transformation(extent={{70,-92},{90,-72}})));
equation
  connect(Gn.y, PV.G) annotation (Line(points={{-59,80},{-52,80},{-52,73},{-45.5,
          73}}, color={0,0,127}));
  connect(Tn.y, PV.T) annotation (Line(points={{-59,40},{-52,40},{-52,67},{-45.5,
          67}}, color={0,0,127}));
  connect(C.p, Inverter.p1) annotation (Line(points={{24,80},{34,80},{34,75},{
          40,75}}, color={0,0,255}));
  connect(R.n, Grid.p)
    annotation (Line(points={{86,30},{86,20}},color={0,0,255}));
  connect(L.n, R.p)
    annotation (Line(points={{86,60},{86,56},{86,50}}, color={0,0,255}));
  connect(C.n, Inverter.n1) annotation (Line(points={{24,60},{34,60},{34,65},{
          40,65}}, color={0,0,255}));
  connect(Inverter.p2, L.p) annotation (Line(points={{60,75},{70,75},{70,80},{
          86,80}}, color={0,0,255}));
  connect(Inverter.n2, Grid.n)
    annotation (Line(points={{60,65},{70,65},{70,0},{86,0}}, color={0,0,255}));
  connect(resistor.n, C.p)
    annotation (Line(points={{0,80},{24,80}}, color={0,0,255}));
  connect(PV.p, resistor.p)
    annotation (Line(points={{-40,80},{-30,80},{-20,80}}, color={0,0,255}));
  connect(PV.n, C.n)
    annotation (Line(points={{-40,60},{24,60}}, color={0,0,255}));
  connect(PV.n, ground.p)
    annotation (Line(points={{-40,60},{-10,60}}, color={0,0,255}));
  connect(Controller.d, Inverter.d)
    annotation (Line(points={{41,-10},{50,-10},{50,58}}, color={0,0,127}));
  connect(vdcSense.y, Controller.vdc) annotation (Line(points={{-19,20},{0,20},
          {0,-2},{18,-2}},color={0,0,127}));
  connect(idcSense.y, Controller.idc)
    annotation (Line(points={{-19,-6},{-10,-6},{18,-6}}, color={0,0,127}));
  connect(iacSense.y, Controller.iac) annotation (Line(points={{-19,-30},{-10,-30},
          {-10,-14},{18,-14}}, color={0,0,127}));
  connect(vacSense.y, Controller.vac) annotation (Line(points={{-19,-54},{0,-54},
          {0,-18},{18,-18}}, color={0,0,127}));
  connect(acPower.y, mean.u) annotation (Line(points={{61,-82},{64.5,-82},{68,
          -82}}, color={0,0,127}));
  annotation (Icon(graphics), experiment(StopTime=55, Interval=0.001));
end PVInverter1phSynch;
