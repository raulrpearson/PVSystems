within PVSystems.Examples.Application;
model PVInverter1ph "Simple PV system including PV array, inverter and no grid"
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
  PVSystems.Electrical.Assemblies.HBridgeAveraged Inverter
    annotation (Placement(transformation(extent={{0,60},{20,80}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor L(L=500e-6) annotation (Placement(
        transformation(
        origin={90,66},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor R(R=10) annotation (Placement(
        transformation(
        origin={90,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor C(C=5e-3, v(start=32.8))
    annotation (Placement(transformation(
        origin={-20,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor VSdc annotation (Placement(
        transformation(
        origin={-52,-70},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor CSdc annotation (Placement(
        transformation(extent={{-52,70},{-32,90}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.PowerSensor PSac annotation (Placement(
        transformation(extent={{60,80},{80,100}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.PowerSensor PSdc annotation (Placement(
        transformation(extent={{-102,70},{-82,90}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=1e-3, v(start=30))
    annotation (Placement(transformation(extent={{-76,70},{-56,90}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-62,-108},{-42,-88}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation (
      Placement(transformation(extent={{30,80},{50,100}}, rotation=0)));
  Modelica.Blocks.Sources.Sine sine(freqHz=50) annotation (Placement(
        transformation(extent={{-20,-100},{0,-80}}, rotation=0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMin=0) annotation (Placement(
        transformation(
        origin={10,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Math.Add add(k1=0.5) annotation (Placement(transformation(
        origin={16,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Constant const(k=0.5) annotation (Placement(
        transformation(extent={{-80,-40},{-60,-20}}, rotation=0)));
  PVSystems.Control.ControllerInverter1ph onePhaseInverterController
    annotation (Placement(transformation(
        origin={10,-50},
        extent={{-10,10},{10,-10}},
        rotation=90)));
equation
  connect(Gn.y, PV.G) annotation (Line(points={{-127,90},{-122,90},{-122,73},{-115.5,
          73}}, color={0,0,127}));
  connect(Tn.y, PV.T) annotation (Line(points={{-127,50},{-122,50},{-122,67},{-115.5,
          67}}, color={0,0,127}));
  connect(C.p, Inverter.dcp) annotation (Line(points={{-20,80},{-6,80},{-6,75},
          {0,75}}, color={0,0,255}));
  connect(PV.n, VSdc.n) annotation (Line(points={{-110,60},{-110,-80},{-52,-80}},
        color={0,0,255}));
  connect(VSdc.n, C.n)
    annotation (Line(points={{-52,-80},{-20,-80},{-20,60}}, color={0,0,255}));
  connect(CSdc.n, C.p)
    annotation (Line(points={{-32,80},{-20,80}}, color={0,0,255}));
  connect(VSdc.p, CSdc.p)
    annotation (Line(points={{-52,-60},{-52,80}}, color={0,0,255}));
  connect(L.n, R.p)
    annotation (Line(points={{90,56},{90,40}}, color={0,0,255}));
  connect(PSdc.pv, PV.p)
    annotation (Line(points={{-92,90},{-110,90},{-110,80}}, color={0,0,255}));
  connect(PSdc.nv, VSdc.n)
    annotation (Line(points={{-92,70},{-92,-80},{-52,-80}}, color={0,0,255}));
  connect(PSac.nc, L.p)
    annotation (Line(points={{80,90},{90,90},{90,76}}, color={0,0,255}));
  connect(PSac.pv, PSac.pc)
    annotation (Line(points={{70,100},{60,100},{60,90}}, color={0,0,255}));
  connect(resistor.n, CSdc.p)
    annotation (Line(points={{-56,80},{-52,80}}, color={0,0,255}));
  connect(PV.p, PSdc.pc)
    annotation (Line(points={{-110,80},{-102,80}}, color={0,0,255}));
  connect(PSdc.nc, resistor.p)
    annotation (Line(points={{-82,80},{-76,80}}, color={0,0,255}));
  connect(C.n, Inverter.dcn) annotation (Line(points={{-20,60},{-6,60},{-6,65},
          {0,65}}, color={0,0,255}));
  connect(ground.p, VSdc.n)
    annotation (Line(points={{-52,-88},{-52,-80}}, color={0,0,255}));
  connect(Inverter.acn, R.n) annotation (Line(points={{20,65},{50,65},{50,20},{
          90,20}}, color={0,0,255}));
  connect(PSac.nv, R.n)
    annotation (Line(points={{70,80},{70,20},{90,20}}, color={0,0,255}));
  connect(currentSensor.n, PSac.pc)
    annotation (Line(points={{50,90},{60,90}}, color={0,0,255}));
  connect(Inverter.acp, currentSensor.p) annotation (Line(points={{20,75},{26,
          75},{26,90},{30,90}}, color={0,0,255}));
  connect(limiter.y, Inverter.d)
    annotation (Line(points={{10,41},{10,58}}, color={0,0,127}));
  connect(const.y, add.u2)
    annotation (Line(points={{-59,-30},{22,-30},{22,-22}}, color={0,0,127}));
  connect(add.y, limiter.u) annotation (Line(points={{16,1},{16,10},{10,10},{10,
          18}}, color={0,0,127}));
  connect(onePhaseInverterController.d, add.u1)
    annotation (Line(points={{10,-39},{10,-22}}, color={0,0,127}));
  connect(sine.y, onePhaseInverterController.vac) annotation (Line(points={{1,-90},
          {14,-90},{14,-61},{13,-61}}, color={0,0,127}));
  connect(currentSensor.i, onePhaseInverterController.iac) annotation (Line(
        points={{40,80},{40,-90},{18,-90},{18,-61}}, color={0,0,127}));
  connect(VSdc.v, onePhaseInverterController.vdc)
    annotation (Line(points={{-42,-70},{3,-70},{3,-61}}, color={0,0,127}));
  connect(CSdc.i, onePhaseInverterController.idc) annotation (Line(points={{-42,
          70},{-36,70},{-36,-76},{7,-76},{7,-61}}, color={0,0,127}));
  annotation (Diagram(graphics));
end PVInverter1ph;
