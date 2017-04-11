within PVSystems.Examples.Application;
model Inverter1phClosedSynch
  "Grid synchronized 1-phase closed-loop inverter fed by constant DC source"
  extends Modelica.Icons.Example;
  extends Modelica.Icons.UnderConstruction;
  Modelica.Electrical.Analog.Sources.ConstantVoltage DCsrc(V=580) annotation (
      Placement(transformation(
        origin={-80,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.SineVoltage Grid(freqHz=50, V=480)
    annotation (Placement(transformation(
        origin={56,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Control.PLL pll annotation (Placement(transformation(extent={{60,-4},{40,16}},
          rotation=0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor VSac annotation (Placement(
        transformation(
        origin={80,70},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  PVSystems.Electrical.Assemblies.HBridgeAveraged HB(d(start=0.5)) annotation (
      Placement(transformation(extent={{-60,60},{-40,80}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor L1(L=500e-6) annotation (Placement(
        transformation(extent={{10,80},{30,100}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=0.1) annotation (Placement(
        transformation(extent={{36,80},{56,100}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor L2(L=500e-6) annotation (Placement(
        transformation(
        origin={20,50},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Resistor R2(R=0.1) annotation (Placement(
        transformation(
        origin={46,50},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation (
      Placement(transformation(extent={{0,40},{-20,60}}, rotation=0)));
  Control.Assemblies.ControllerInverter1phCurrent control(d(start=0.5))
    annotation (Placement(transformation(
        origin={-50,10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor VSdc(v(start=DCsrc.V))
    annotation (Placement(transformation(
        origin={-108,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Step iqSetpoint(height=14.14, startTime=0.2)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}},
          rotation=0)));
  Modelica.Blocks.Sources.Step idSetpoint(
    offset=20,
    startTime=0.2,
    height=14.14 - 20) annotation (Placement(transformation(extent={{-100,-40},
            {-80,-20}}, rotation=0)));
equation
  connect(Grid.p, VSac.p)
    annotation (Line(points={{56,80},{80,80}}, color={0,0,255}));
  connect(Grid.n, VSac.n)
    annotation (Line(points={{56,60},{80,60}}, color={0,0,255}));
  connect(L1.n, R1.p)
    annotation (Line(points={{30,90},{36,90}}, color={0,0,255}));
  connect(R2.n, L2.p)
    annotation (Line(points={{36,50},{30,50}}, color={0,0,255}));
  connect(HB.acp, L1.p) annotation (Line(points={{-40,75},{-34,75},{-34,90},{10,
          90}}, color={0,0,255}));
  connect(R1.n, Grid.p)
    annotation (Line(points={{56,90},{56,80}}, color={0,0,255}));
  connect(Grid.n, R2.p)
    annotation (Line(points={{56,60},{56,50}}, color={0,0,255}));
  connect(DCsrc.p, HB.dcp) annotation (Line(points={{-80,80},{-64,80},{-64,75},
          {-60,75}}, color={0,0,255}));
  connect(DCsrc.n, HB.dcn) annotation (Line(points={{-80,60},{-64,60},{-64,65},
          {-60,65}}, color={0,0,255}));
  connect(currentSensor.p, L2.n)
    annotation (Line(points={{0,50},{10,50}}, color={0,0,255}));
  connect(HB.acn, currentSensor.n) annotation (Line(points={{-40,65},{-34,65},{
          -34,50},{-20,50}}, color={0,0,255}));
  connect(pll.v, VSac.v) annotation (Line(points={{62,6},{100,6},{100,70},{90,
          70}}, color={0,0,127}));
  connect(VSdc.p, DCsrc.p)
    annotation (Line(points={{-108,80},{-80,80}}, color={0,0,255}));
  connect(VSdc.n, DCsrc.n)
    annotation (Line(points={{-108,60},{-80,60}}, color={0,0,255}));
  connect(control.d, HB.d)
    annotation (Line(points={{-50,21},{-50,58}}, color={0,0,127}));
  connect(VSdc.v, control.udc) annotation (Line(points={{-118,70},{-126,70},{-126,
          30},{-30,30},{-30,14},{-38,14}}, color={0,0,127}));
  connect(pll.theta, control.theta)
    annotation (Line(points={{39,6},{0.5,6},{-38,6}}, color={0,0,127}));
  connect(currentSensor.i, control.i) annotation (Line(points={{-10,40},{-10,-20},
          {-50,-20},{-50,-2}}, color={0,0,127}));
  connect(iqSetpoint.y, control.iqSetpoint)
    annotation (Line(points={{-79,-70},{-44,-70},{-44,-2}}, color={0,0,127}));
  connect(idSetpoint.y, control.idSetpoint)
    annotation (Line(points={{-79,-30},{-56,-30},{-56,-2}}, color={0,0,127}));
  annotation (Diagram(graphics), experiment(
      StartTime=0,
      StopTime=0.1,
      Tolerance=1e-4));
end Inverter1phClosedSynch;
