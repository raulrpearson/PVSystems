within PVSystems.Examples.Verification;
model CCMXVerification "CCMX models verification"
  extends Modelica.Icons.Example;
  Electrical.CCM1 ccm1
    annotation (Placement(transformation(extent={{30,110},{50,130}})));
  Modelica.Blocks.Sources.Ramp duty(
    duration=0.8,
    startTime=0.1,
    height=0.8,
    offset=0.1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,-120})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V=10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,120})));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=1) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={80,120})));
  Modelica.Electrical.Analog.Basic.Ground g1
    annotation (Placement(transformation(extent={{10,90},{30,110}})));
  Modelica.Electrical.Analog.Basic.Ground g2
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  Modelica.Electrical.Analog.Basic.Resistor Ri1(R=1e-3)
    annotation (Placement(transformation(extent={{-10,120},{10,140}})));
  Electrical.CCM2 ccm2(
    Ron=1,
    RD=0.01,
    VD=0.8)
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V=10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,70})));
  Modelica.Electrical.Analog.Basic.Resistor R2(R=1) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={80,70})));
  Modelica.Electrical.Analog.Basic.Ground g3
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
  Modelica.Electrical.Analog.Basic.Ground g4
    annotation (Placement(transformation(extent={{50,40},{70,60}})));
  Modelica.Electrical.Analog.Basic.Resistor Ri2(R=1e-3)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Electrical.CCM3 ccm3(n=2)
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V3(V=10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,20})));
  Modelica.Electrical.Analog.Basic.Resistor R3(R=1) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={80,20})));
  Modelica.Electrical.Analog.Basic.Ground g5
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Electrical.Analog.Basic.Ground g6
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Electrical.Analog.Basic.Resistor Ri3(R=1e-3)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Electrical.CCM4 ccm4(
    Ron=1,
    RD=0.01,
    n=2,
    VD=0.8)
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V4(V=10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-30})));
  Modelica.Electrical.Analog.Basic.Resistor R4(R=1) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={80,-30})));
  Modelica.Electrical.Analog.Basic.Ground g7
    annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
  Modelica.Electrical.Analog.Basic.Ground g8
    annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
  Modelica.Electrical.Analog.Basic.Resistor Ri4(R=1e-3)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Electrical.CCM5 ccm5(
    Ron=1,
    VD=0.8,
    fs=100e3,
    Qr=0.75e-6,
    tr=75e-9)
    annotation (Placement(transformation(extent={{30,-92},{50,-72}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V5(V=10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-82})));
  Modelica.Electrical.Analog.Basic.Resistor R5(R=1) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={80,-82})));
  Modelica.Electrical.Analog.Basic.Ground g9
    annotation (Placement(transformation(extent={{10,-112},{30,-92}})));
  Modelica.Electrical.Analog.Basic.Ground g10
    annotation (Placement(transformation(extent={{50,-112},{70,-92}})));
  Modelica.Electrical.Analog.Basic.Resistor Ri5(R=1e-3)
    annotation (Placement(transformation(extent={{-10,-82},{10,-62}})));
equation
  connect(R1.p, ccm1.p2) annotation (Line(points={{80,130},{60,130},{60,125},{
          50,125}},
                color={0,0,255}));
  connect(ccm1.n2,R1. n)
    annotation (Line(points={{50,115},{60,115},{60,110},{80,110}},
                                                           color={0,0,255}));
  connect(g1.p, ccm1.n1) annotation (Line(points={{20,110},{20,110},{20,115},{
          30,115}},
               color={0,0,255}));
  connect(V1.n, g1.p)
    annotation (Line(points={{-20,110},{20,110}},
                                               color={0,0,255}),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-3));
  connect(V1.p, Ri1.p)
    annotation (Line(points={{-20,130},{-10,130}}, color={0,0,255}));
  connect(Ri1.n, ccm1.p1) annotation (Line(points={{10,130},{20,130},{20,125},{
          30,125}}, color={0,0,255}));
  connect(duty.y, ccm5.d) annotation (Line(points={{-69,-120},{-14,-120},{40,
          -120},{40,-94}}, color={0,0,127}));
  connect(ccm4.d, ccm5.d) annotation (Line(points={{40,-42},{40,-60},{-52,-60},
          {-52,-120},{40,-120},{40,-94}}, color={0,0,127}));
  connect(ccm3.d, ccm5.d) annotation (Line(points={{40,8},{40,-10},{-52,-10},{
          -52,-120},{40,-120},{40,-94}}, color={0,0,127}));
  connect(ccm2.d, ccm5.d) annotation (Line(points={{40,58},{40,40},{-52,40},{
          -52,-120},{40,-120},{40,-94}}, color={0,0,127}));
  connect(ccm1.d, ccm5.d) annotation (Line(points={{40,108},{40,92},{-52,92},{
          -52,-120},{40,-120},{40,-94}}, color={0,0,127}));
  connect(V2.p, Ri2.p)
    annotation (Line(points={{-20,80},{-10,80},{-10,80}}, color={0,0,255}));
  connect(Ri2.n, ccm2.p1) annotation (Line(points={{10,80},{20,80},{20,75},{30,
          75}}, color={0,0,255}));
  connect(g3.p, ccm2.n1) annotation (Line(points={{20,60},{20,60},{20,65},{30,
          65}}, color={0,0,255}));
  connect(R2.p, ccm2.p2) annotation (Line(points={{80,80},{60,80},{60,75},{50,
          75}}, color={0,0,255}));
  connect(g4.p, ccm2.n2) annotation (Line(points={{60,60},{60,60},{60,65},{50,
          65}}, color={0,0,255}));
  connect(V3.p, Ri3.p)
    annotation (Line(points={{-20,30},{-15,30},{-10,30}}, color={0,0,255}));
  connect(Ri3.n, ccm3.p1) annotation (Line(points={{10,30},{20,30},{20,25},{30,
          25}}, color={0,0,255}));
  connect(g5.p, ccm3.n1) annotation (Line(points={{20,10},{20,10},{20,15},{30,
          15}}, color={0,0,255}));
  connect(R3.p, ccm3.p2) annotation (Line(points={{80,30},{72,30},{60,30},{60,
          25},{50,25}}, color={0,0,255}));
  connect(g6.p, ccm3.n2) annotation (Line(points={{60,10},{60,6},{60,15},{50,15}},
        color={0,0,255}));
  connect(V4.p, Ri4.p)
    annotation (Line(points={{-20,-20},{-15,-20},{-10,-20}}, color={0,0,255}));
  connect(Ri4.n, ccm4.p1) annotation (Line(points={{10,-20},{20,-20},{20,-25},{
          30,-25}}, color={0,0,255}));
  connect(g7.p, ccm4.n1) annotation (Line(points={{20,-40},{20,-40},{20,-35},{
          30,-35}}, color={0,0,255}));
  connect(V5.p, Ri5.p)
    annotation (Line(points={{-20,-72},{-15,-72},{-10,-72}}, color={0,0,255}));
  connect(Ri5.n, ccm5.p1) annotation (Line(points={{10,-72},{20,-72},{20,-77},{
          30,-77}}, color={0,0,255}));
  connect(g9.p, ccm5.n1) annotation (Line(points={{20,-92},{20,-92},{20,-87},{
          30,-87}}, color={0,0,255}));
  connect(R5.p, ccm5.p2) annotation (Line(points={{80,-72},{60,-72},{60,-77},{
          50,-77}}, color={0,0,255}));
  connect(g10.p, ccm5.n2) annotation (Line(points={{60,-92},{60,-92},{60,-87},{
          50,-87}}, color={0,0,255}));
  connect(R4.p, ccm4.p2) annotation (Line(points={{80,-20},{60,-20},{60,-25},{
          50,-25}}, color={0,0,255}));
  connect(g8.p, ccm4.n2) annotation (Line(points={{60,-40},{60,-40},{60,-35},{
          50,-35}}, color={0,0,255}));
  connect(ccm1.n2, g2.p)
    annotation (Line(points={{50,115},{60,115},{60,110}}, color={0,0,255}));
  connect(R2.n, g4.p)
    annotation (Line(points={{80,60},{70,60},{60,60}}, color={0,0,255}));
  connect(R3.n, g6.p)
    annotation (Line(points={{80,10},{78,10},{60,10}}, color={0,0,255}));
  connect(R4.n, g8.p)
    annotation (Line(points={{80,-40},{60,-40}}, color={0,0,255}));
  connect(R5.n, g10.p)
    annotation (Line(points={{80,-92},{60,-92}}, color={0,0,255}));
  connect(V2.n, g3.p)
    annotation (Line(points={{-20,60},{0,60},{20,60}}, color={0,0,255}));
  connect(V3.n, g5.p)
    annotation (Line(points={{-20,10},{0,10},{20,10}}, color={0,0,255}));
  connect(V4.n, g7.p)
    annotation (Line(points={{-20,-40},{0,-40},{20,-40}}, color={0,0,255}));
  connect(V5.n, g9.p)
    annotation (Line(points={{-20,-92},{0,-92},{20,-92}}, color={0,0,255}));
  annotation (
    experiment(
      StartTime=0, StopTime=1,Tolerance=1e-3),
    Diagram(
      coordinateSystem(extent={{-100,-140},{100,140}}, initialScale=0.1),
        graphics={Rectangle(extent={{-100,140},{100,-140}}, lineColor={255,255,
              255})}),
    Icon(
      coordinateSystem(extent={{-100,-100},{100,100}}, initialScale=0.1)));
end CCMXVerification;
