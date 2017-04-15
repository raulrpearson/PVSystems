within PVSystems.Examples.Application;
model Inverter1phClosedSynch
  "Grid synchronized 1-phase closed-loop inverter fed by constant DC source"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Sources.ConstantVoltage DCsrc(V=580) annotation (
      Placement(transformation(
        origin={-18,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.SineVoltage Grid(freqHz=50, V=480)
    annotation (Placement(transformation(
        origin={80,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Control.PLL pll annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-40,-50})));
  PVSystems.Electrical.Assemblies.HBridgeAveraged HB(d(start=0.5))
    annotation (Placement(transformation(extent={{2,60},{22,80}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor L(L=500e-6) annotation (Placement(
        transformation(extent={{34,80},{54,100}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R(R=0.1) annotation (Placement(
        transformation(extent={{60,80},{80,100}}, rotation=0)));
  Control.Assemblies.Inverter1phCurrentController control(d(start=0.5))
    annotation (Placement(transformation(
        origin={-10,10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant idSetpoint(k=400)
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Modelica.Blocks.Sources.Constant iqSetpoint(k=0)
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-28,40},{-8,60}})));
  Modelica.Blocks.Sources.RealExpression vacSense(y=Grid.v)
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));
  Modelica.Blocks.Sources.RealExpression iacSense(y=Grid.i)
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  Modelica.Blocks.Sources.RealExpression vdcSense(y=DCsrc.v)
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
equation
  connect(L.n, R.p)
    annotation (Line(points={{54,90},{60,90}}, color={0,0,255}));
  connect(HB.p2, L.p) annotation (Line(points={{22,75},{28,75},{28,90},{34,90}},
        color={0,0,255}));
  connect(R.n, Grid.p)
    annotation (Line(points={{80,90},{80,80}}, color={0,0,255}));
  connect(DCsrc.p, HB.p1) annotation (Line(points={{-18,80},{-2,80},{-2,75},{2,
          75}}, color={0,0,255}));
  connect(DCsrc.n, HB.n1) annotation (Line(points={{-18,60},{-2,60},{-2,65},{2,
          65}}, color={0,0,255}));
  connect(iqSetpoint.y, control.iqs) annotation (Line(points={{-69,-20},{-40,-20},
          {-40,4},{-22,4}}, color={0,0,127}));
  connect(idSetpoint.y, control.ids) annotation (Line(points={{-69,40},{-40,40},
          {-40,16},{-22,16}}, color={0,0,127}));
  connect(DCsrc.n, ground.p)
    annotation (Line(points={{-18,60},{-18,60}}, color={0,0,255}));
  connect(Grid.n, HB.n2) annotation (Line(points={{80,60},{80,50},{28,50},{28,
          65},{22,65}}, color={0,0,255}));
  connect(control.d, HB.d)
    annotation (Line(points={{1,10},{12,10},{12,58}}, color={0,0,127}));
  connect(iacSense.y, control.i)
    annotation (Line(points={{-69,10},{-22,10}}, color={0,0,127}));
  connect(pll.theta, control.theta) annotation (Line(points={{-29,-50},{-29,-50},
          {-14,-50},{-14,-2}}, color={0,0,127}));
  connect(vacSense.y, pll.v)
    annotation (Line(points={{-69,-50},{-52,-50},{-52,-50}}, color={0,0,127}));
  connect(vdcSense.y, control.vdc)
    annotation (Line(points={{-69,-80},{-6,-80},{-6,-2}}, color={0,0,127}));
  annotation (experiment(StopTime=0.3));
end Inverter1phClosedSynch;
