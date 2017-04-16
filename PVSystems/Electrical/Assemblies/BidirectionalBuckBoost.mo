within PVSystems.Electrical.Assemblies;
model BidirectionalBuckBoost "Bidirectional Buck Boost converter"
  extends Interfaces.TwoPortConverter;
  parameter Modelica.SIunits.Capacitance Cin "Input capacitance"
    annotation (Dialog(group="Power stage"));
  parameter Modelica.SIunits.Resistance Rcin
    "Series resistance of input capacitor"
    annotation (Dialog(group="Power stage"));
  parameter Modelica.SIunits.Capacitance Cout "Output capacitance"
    annotation (Dialog(group="Power stage"));
  parameter Modelica.SIunits.Resistance Rcout
    "Series resistance of output capacitor"
    annotation (Dialog(group="Power stage"));
  parameter Modelica.SIunits.Inductance L "Inductance"
    annotation (Dialog(group="Power stage"));
  parameter Modelica.SIunits.Resistance RL "Series resistance of inductor"
    annotation (Dialog(group="Power stage"));
  parameter Modelica.SIunits.Voltage vCin_ini=0
    "Guess for initial voltage of Cin"
    annotation (Dialog(group="Initialization"));
  parameter Modelica.SIunits.Voltage vCout_ini=0
    "Guess for initial voltage of Cout"
    annotation (Dialog(group="Initialization"));
  parameter Modelica.SIunits.Current iL_ini=0 "Guess for initial current of L"
    annotation (Dialog(group="Initialization"));
  parameter Real dmax(final unit="1") = 1 "Maximum duty cycle"
    annotation (Dialog(group="Switches"));
  parameter Real dmin(final unit="1") = 1e-3 "Minimum duty cycle"
    annotation (Dialog(group="Switches"));
  Modelica.Electrical.Analog.Basic.Capacitor outCap(C=Cout, v(start=vCout_ini))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={80,20})));
  Modelica.Electrical.Analog.Basic.Capacitor inCap(C=Cin, v(start=vCin_ini))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,20})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(start=iL_ini))
    annotation (Placement(transformation(extent={{-24,50},{-4,70}})));
  Electrical.CCM1 buckSw(dmin=dmin, dmax=dmax)
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Electrical.CCM1 boostSw(dmin=dmin, dmax=dmax)
    annotation (Placement(transformation(extent={{30,30},{50,50}})));
  Modelica.Blocks.Interfaces.RealInput dbuck "Buck control voltage" annotation
    (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-120})));
  Modelica.Blocks.Interfaces.RealInput dboost "Boost control voltage"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={40,-120})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=RL)
    annotation (Placement(transformation(extent={{4,50},{24,70}})));
  Modelica.Electrical.Analog.Basic.Resistor inESR(R=Rcin) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-20})));
  Modelica.Electrical.Analog.Basic.Resistor outESR(R=Rcout) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={80,-20})));
equation
  connect(buckSw.n1, inductor.p) annotation (Line(points={{-50,35},{-60,35},{-60,
          60},{-24,60}}, color={0,0,255}));
  connect(buckSw.p2, inductor.p)
    annotation (Line(points={{-30,45},{-30,60},{-24,60}}, color={0,0,255}));
  connect(boostSw.n1, buckSw.n2) annotation (Line(points={{30,35},{30,-50},{-30,
          -50},{-30,35}},color={0,0,255}));
  connect(boostSw.n2, boostSw.p1) annotation (Line(points={{50,35},{60,35},{60,
          60},{30,60},{30,45}}, color={0,0,255}));
  connect(p1, buckSw.p1) annotation (Line(points={{-100,50},{-100,50},{-70,50},
          {-70,45},{-50,45}},color={0,0,255}));
  connect(outCap.p, boostSw.p2) annotation (Line(points={{80,30},{80,50},{70,50},
          {70,45},{50,45}}, color={0,0,255}));
  connect(inCap.p, buckSw.p1) annotation (Line(points={{-80,30},{-80,50},{-70,
          50},{-70,45},{-50,45}}, color={0,0,255}));
  connect(resistor.n, boostSw.p1)
    annotation (Line(points={{24,60},{30,60},{30,45}}, color={0,0,255}));
  connect(inductor.n, resistor.p)
    annotation (Line(points={{-4,60},{4,60}}, color={0,0,255}));
  connect(p2, boostSw.p2) annotation (Line(points={{100,50},{100,50},{70,50},{
          70,45},{50,45}}, color={0,0,255}));
  connect(inCap.n, inESR.p)
    annotation (Line(points={{-80,10},{-80,-10}},color={0,0,255}));
  connect(outCap.n, outESR.p)
    annotation (Line(points={{80,10},{80,10},{80,-10}}, color={0,0,255}));
  connect(outESR.n, n2)
    annotation (Line(points={{80,-30},{80,-50},{100,-50}}, color={0,0,255}));
  connect(inESR.n, n1) annotation (Line(points={{-80,-30},{-80,-50},{-100,-50}},
        color={0,0,255}));
  connect(inESR.n, buckSw.n2) annotation (Line(points={{-80,-30},{-80,-50},{-30,
          -50},{-30,35}}, color={0,0,255}));
  connect(outESR.n, buckSw.n2) annotation (Line(points={{80,-30},{80,-50},{-30,
          -50},{-30,35}}, color={0,0,255}));
  connect(dbuck, buckSw.d)
    annotation (Line(points={{-40,-120},{-40,28}}, color={0,0,127}));
  connect(dboost, boostSw.d)
    annotation (Line(points={{40,-120},{40,-46},{40,28}}, color={0,0,127}));
  annotation (Icon(graphics={
        Text(
          extent={{-60,30},{60,-30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="1-ph"),
        Line(points={{-70,50},{-10,50}}, color={0,0,255}),
        Line(points={{-70,70},{-10,70}}, color={0,0,255}),
        Line(points={{10,-70},{70,-70}}, color={0,0,255}),
        Line(points={{10,-50},{70,-50}}, color={0,0,255})}), Documentation(info
        ="<html><p>Bidirectional buck boost converter</p></html>"));
end BidirectionalBuckBoost;
