within PVSystems.Electrical;
model Switched "Switch network implemented with switched components"
  extends Interfaces.SwitchNetworkInterface;
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch(Ron=
        Ron) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,0})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode(Ron=RD, Vknee=VD)
                                                         annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,0})));
  Control.SignalPWM signalPWM(
    dMax=dMax,
    dMin=dMin,
    fs=fs,
    startTime=startTime)
    annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  parameter Real dMax=1 "Maximum duty cycle";
  parameter Real dMin=0 "Minimum duty cycle";
  parameter Modelica.SIunits.Frequency fs "Switching frequency";
  parameter Modelica.SIunits.Time startTime=0 "Start time";
  parameter Modelica.SIunits.Resistance RD=1.E-5
    "Forward state-on differential resistance (closed resistance)";
  parameter Modelica.SIunits.Voltage VD=0 "Forward threshold voltage";
  parameter Modelica.SIunits.Resistance Ron=1.E-5 "Closed switch resistance";
equation
  connect(p1, idealClosingSwitch.p)
    annotation (Line(points={{-100,50},{-80,50},{-80,10}}, color={0,0,255}));
  connect(n1, idealClosingSwitch.n) annotation (Line(points={{-100,-50},{-80,-50},
          {-80,-10}}, color={0,0,255}));
  connect(idealDiode.n, p2) annotation (Line(points={{80,10},{80,10},{80,50},{100,
          50}}, color={0,0,255}));
  connect(n2, idealDiode.p)
    annotation (Line(points={{100,-50},{80,-50},{80,-10}}, color={0,0,255}));
  connect(signalPWM.vc, d) annotation (Line(points={{-18,0},{-10,0},{0,0},{0,-120}},
        color={0,0,127}));
  connect(signalPWM.c1, idealClosingSwitch.control)
    annotation (Line(points={{-41,0},{-73,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Switched;
