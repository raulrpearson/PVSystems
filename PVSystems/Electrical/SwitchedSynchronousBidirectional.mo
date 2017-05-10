within PVSystems.Electrical;
model SwitchedSynchronousBidirectional
  "Switched model implemented with switch + anti-parallel diode x 2"
  extends Interfaces.SwitchNetworkInterface;
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch sw1(Ron=Ron) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,0})));
  Control.SignalPWM signalPWM(
    dMax=dMax,
    dMin=dMin,
    fs=fs,
    startTime=startTime)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=270,
        origin={0,-70})));
  parameter Real dMax=1 "Maximum duty cycle";
  parameter Real dMin=0 "Minimum duty cycle";
  parameter Modelica.SIunits.Frequency fs "Switching frequency";
  parameter Modelica.SIunits.Time startTime=0 "Start time";
  parameter Modelica.SIunits.Resistance RD=1.E-5
    "Forward state-on differential resistance (closed resistance)";
  parameter Modelica.SIunits.Voltage VD=0 "Forward threshold voltage";
  parameter Modelica.SIunits.Resistance Ron=1.E-5 "Closed switch resistance";
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch sw2(Ron=Ron) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={40,0})));
  Control.DeadTime deadTime annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  Modelica.Electrical.Analog.Ideal.IdealDiode d1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,0})));
  Modelica.Electrical.Analog.Ideal.IdealDiode d2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,0})));
equation
  connect(p1, sw1.p)
    annotation (Line(points={{-100,50},{-40,50},{-40,10}}, color={0,0,255}));
  connect(n1, sw1.n) annotation (Line(points={{-100,-50},{-40,-50},{-40,-10}},
        color={0,0,255}));
  connect(signalPWM.vc, d)
    annotation (Line(points={{0,-82},{0,-120}}, color={0,0,127}));
  connect(deadTime.c, signalPWM.c1)
    annotation (Line(points={{0,-42},{0,-59}}, color={255,0,255}));
  connect(deadTime.c1, sw1.control) annotation (Line(points={{-4,-19},{-4,-19},
          {-4,0},{-33,0}}, color={255,0,255}));
  connect(sw2.n, p2) annotation (Line(points={{40,10},{40,10},{40,50},{100,50}},
        color={0,0,255}));
  connect(n2, sw2.p)
    annotation (Line(points={{100,-50},{40,-50},{40,-10}}, color={0,0,255}));
  connect(deadTime.c2, sw2.control) annotation (Line(points={{4,-19},{4,-19},{4,
          0},{33,0}}, color={255,0,255}));
  connect(d1.n, sw1.p) annotation (Line(points={{-80,10},{-80,50},{-40,50},{-40,
          10}}, color={0,0,255}));
  connect(d1.p, sw1.n) annotation (Line(points={{-80,-10},{-80,-50},{-40,-50},{
          -40,-10}}, color={0,0,255}));
  connect(d2.n, p2) annotation (Line(points={{80,10},{80,10},{80,50},{100,50}},
        color={0,0,255}));
  connect(d2.p, n2) annotation (Line(points={{80,-10},{80,-10},{80,-50},{100,
          -50}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SwitchedSynchronousBidirectional;
