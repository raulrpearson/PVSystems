within PVSystems.Examples.Application;
model PVInverter1ph "Simple PV system including PV array, inverter and no grid"
  extends Modelica.Icons.Example;
  extends Modelica.Icons.UnderConstruction;
  Electrical.PVArray PV(v(start=450)) annotation (Placement(transformation(
        origin={-40,60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Constant Gn(k=1000) annotation (Placement(
        transformation(extent={{-80,70},{-60,90}}, rotation=0)));
  Modelica.Blocks.Sources.Constant Tn(k=298.15) annotation (Placement(
        transformation(extent={{-80,30},{-60,50}}, rotation=0)));
  PVSystems.Electrical.Assemblies.HBridgeAveraged Inverter annotation (
      Placement(transformation(extent={{40,50},{60,70}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor L(L=200e-6) annotation (Placement(
        transformation(
        origin={90,74},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor R(R=0.5) annotation (Placement(
        transformation(
        origin={90,48},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor C(v(start=32.8), C=5e-1)
    annotation (Placement(transformation(
        origin={20,60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor Rdc(R=1e-3, v(start=30))
    annotation (Placement(transformation(extent={{-20,70},{0,90}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-20,20},{0,40}}, rotation=0)));
  Modelica.Blocks.Sources.Cosine sine(freqHz=50) annotation (Placement(
        transformation(extent={{-40,-70},{-20,-50}},rotation=0)));
  Control.Assemblies.Inverter1phCompleteController controller(
    fline=50,
    iqMax=10,
    idMax=15,
    vdcMax=40,
    ik=0.1,
    iT=0.01,
    vk=10,
    vT=0.5) annotation (Placement(transformation(
        origin={30,-30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.RealExpression iacSense(y=L.i)
    annotation (Placement(transformation(extent={{-40,-44},{-20,-24}})));
  Modelica.Blocks.Sources.RealExpression idcSense(y=-PV.i)
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Blocks.Sources.RealExpression vdcSense(y=PV.v)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=0.4*sin(100*Modelica.Constants.pi
        *time) + 0.5)
    annotation (Placement(transformation(extent={{-80,-100},{40,-80}})));
  Modelica.Blocks.Sources.RealExpression dcPower(y=-PV.i*PV.v)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.RealExpression acPower(y=R.i*R.v)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Math.Mean mean(f=50)
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
equation
  connect(Gn.y, PV.G) annotation (Line(points={{-59,80},{-54,80},{-54,63},{-45.5,
          63}}, color={0,0,127}));
  connect(Tn.y, PV.T) annotation (Line(points={{-59,40},{-54,40},{-54,57},{-45.5,
          57}}, color={0,0,127}));
  connect(C.p, Inverter.p1) annotation (Line(points={{20,70},{34,70},{34,65},{
          40,65}},color={0,0,255}));
  connect(L.n, R.p)
    annotation (Line(points={{90,64},{90,58}}, color={0,0,255}));
  connect(C.n, Inverter.n1) annotation (Line(points={{20,50},{34,50},{34,55},{
          40,55}},color={0,0,255}));
  connect(PV.p, Rdc.p) annotation (Line(points={{-40,70},{-40,70},{-40,80},{-20,
          80}}, color={0,0,255}));
  connect(C.n, ground.p) annotation (Line(points={{20,50},{20,48},{20,40},{-10,
          40}}, color={0,0,255}));
  connect(PV.n, ground.p)
    annotation (Line(points={{-40,50},{-40,40},{-10,40}}, color={0,0,255}));
  connect(Rdc.n, C.p) annotation (Line(points={{0,80},{10,80},{20,80},{20,70}},
        color={0,0,255}));
  connect(Inverter.p2, L.p) annotation (Line(points={{60,65},{70,65},{70,90},{
          90,90},{90,84}}, color={0,0,255}));
  connect(Inverter.n2, R.n) annotation (Line(points={{60,55},{70,55},{70,30},{
          90,30},{90,38}}, color={0,0,255}));
  connect(idcSense.y, controller.idc) annotation (Line(points={{-19,-10},{0,-10},
          {0,-26},{18,-26}}, color={0,0,127}));
  connect(vdcSense.y, controller.vdc) annotation (Line(points={{-19,10},{10,10},
          {10,-22},{18,-22}}, color={0,0,127}));
  connect(sine.y, controller.vac) annotation (Line(points={{-19,-60},{0,-60},{0,
          -38},{18,-38}}, color={0,0,127}));
  connect(iacSense.y, controller.iac)
    annotation (Line(points={{-19,-34},{-0.5,-34},{18,-34}}, color={0,0,127}));
  connect(acPower.y, mean.u) annotation (Line(points={{-79,-30},{-75.5,-30},{-72,
          -30}}, color={0,0,127}));
  connect(controller.d, Inverter.d)
    annotation (Line(points={{41,-30},{50,-30},{50,48}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(initialScale=0.1)));
end PVInverter1ph;
