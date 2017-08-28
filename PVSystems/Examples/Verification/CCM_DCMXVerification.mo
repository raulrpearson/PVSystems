within PVSystems.Examples.Verification;
model CCM_DCMXVerification "Averaged CCM_DCM models verification"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp duty(
    duration=0.8,
    startTime=0.1,
    height=0.8,
    offset=0.1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,-30})));
  Electrical.CCM_DCM1 ccm_dcm1(fs=100e3, Le=0.6e-6)
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V=10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,70})));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=1) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={80,70})));
  Modelica.Electrical.Analog.Basic.Ground g1
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
  Modelica.Electrical.Analog.Basic.Ground g2
    annotation (Placement(transformation(extent={{50,40},{70,60}})));
  Modelica.Electrical.Analog.Basic.Resistor Ri1(R=1e-3)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Electrical.CCM_DCM2 ccm_dcm2(
    fs=100e3,
    n=2,
    Le=0.6e-6)
         annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V=10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,10})));
  Modelica.Electrical.Analog.Basic.Resistor R2(R=1) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={80,10})));
  Modelica.Electrical.Analog.Basic.Ground g3
    annotation (Placement(transformation(extent={{10,-20},{30,0}})));
  Modelica.Electrical.Analog.Basic.Ground g4
    annotation (Placement(transformation(extent={{50,-20},{70,0}})));
  Modelica.Electrical.Analog.Basic.Resistor Ri2(R=1e-3)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
equation
  connect(V1.p,Ri1. p)
    annotation (Line(points={{-20,80},{-15,80},{-10,80}},    color={0,0,255}));
  connect(Ri1.n, ccm_dcm1.p1) annotation (Line(points={{10,80},{20,80},{20,75},{
          30,75}}, color={0,0,255}));
  connect(g1.p, ccm_dcm1.n1) annotation (Line(points={{20,60},{20,60},{20,65},{30,
          65}}, color={0,0,255}));
  connect(R1.p, ccm_dcm1.p2) annotation (Line(points={{80,80},{60,80},{60,75},{50,
          75}}, color={0,0,255}));
  connect(g2.p, ccm_dcm1.n2) annotation (Line(points={{60,60},{60,60},{60,65},{50,
          65}}, color={0,0,255}));
  connect(R1.n, g2.p)
    annotation (Line(points={{80,60},{60,60}}, color={0,0,255}));
  connect(V1.n,g1. p)
    annotation (Line(points={{-20,60},{0,60},{20,60}},    color={0,0,255}));
  connect(V2.p,Ri2. p)
    annotation (Line(points={{-20,20},{-20,20},{-10,20}},    color={0,0,255}));
  connect(V2.n,g3. p)
    annotation (Line(points={{-20,0},{-10,0},{20,0}},     color={0,0,255}));
  connect(Ri2.n, ccm_dcm2.p1) annotation (Line(points={{10,20},{20,20},{20,15},{
          30,15}}, color={0,0,255}));
  connect(g3.p, ccm_dcm2.n1)
    annotation (Line(points={{20,0},{20,5},{30,5}}, color={0,0,255}));
  connect(g4.p, ccm_dcm2.n2)
    annotation (Line(points={{60,0},{60,5},{50,5}}, color={0,0,255}));
  connect(R2.n, g4.p)
    annotation (Line(points={{80,0},{70,0},{60,0}}, color={0,0,255}));
  connect(R2.p, ccm_dcm2.p2) annotation (Line(points={{80,20},{60,20},{60,15},{50,
          15}}, color={0,0,255}));
  connect(duty.y, ccm_dcm2.d)
    annotation (Line(points={{-59,-30},{40,-30},{40,-2}}, color={0,0,127}));
  connect(duty.y, ccm_dcm1.d) annotation (Line(points={{-59,-30},{-40,-30},{-40,
          40},{40,40},{40,58}}, color={0,0,127}));
  annotation (
    experiment(StartTime=0, StopTime=1, Tolerance=1e-3));
end CCM_DCMXVerification;
