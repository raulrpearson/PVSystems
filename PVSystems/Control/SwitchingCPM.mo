within PVSystems.Control;
block SwitchingCPM "Current Peak Mode modulator for switching models"
  extends Modelica.Blocks.Icons.Block;
  parameter Real dMin(
    final min=Modelica.Constants.small,
    final max=1) = 0 "Minimum duty cycle";
  parameter Real dMax(
    final min=Modelica.Constants.small,
    final max=1) = 1 "Maximum duty cycle";
  // TODO: assert dMax > dMin
  parameter Modelica.SIunits.Frequency fs(final min=Modelica.Constants.small)
    "Switching frequency";
  parameter Modelica.SIunits.Time startTime(final min=0) = 0
    "Time instant of first pulse";
  parameter Modelica.SIunits.Voltage Va(final min=0)
    "Amplitude of artificial ramp";
  parameter Modelica.SIunits.Voltage vcMax "Maximum control voltage";
  Modelica.Blocks.Interfaces.RealInput vc annotation (Placement(transformation(
          extent={{-140,20},{-100,60}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput vs annotation (Placement(transformation(
          extent={{-140,-60},{-100,-20}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput c annotation (Placement(
        transformation(extent={{100,30},{120,50}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput ramp annotation (Placement(
        transformation(extent={{100,-50},{120,-30}}, rotation=0)));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual
    annotation (Placement(transformation(extent={{-10,38},{10,58}})));
  Modelica.Blocks.Logical.RSFlipFlop rSFlipFlop
    annotation (Placement(transformation(extent={{70,36},{90,56}})));
  Modelica.Blocks.Math.Add addVa
    annotation (Placement(transformation(extent={{-50,-56},{-30,-36}})));
  Modelica.Blocks.Sources.SawTooth artificialRamp(
    amplitude=Va,
    period=1/fs,
    nperiod=-1,
    offset=0,
    startTime=startTime)
    annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  Modelica.Blocks.Nonlinear.Limiter vcLimiter(uMax=vcMax, uMin=0)
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Modelica.Blocks.Sources.BooleanPulse dMinLimiter(
    period=1/fs,
    startTime=startTime,
    width=100*dMin)
    annotation (Placement(transformation(extent={{32,0},{52,20}})));
  Modelica.Blocks.Sources.BooleanPulse dMaxLimiter(
    period=1/fs,
    startTime=startTime + dMax/fs,
    width=100*(1 - dMax))
    annotation (Placement(transformation(extent={{-10,66},{10,86}})));
  Modelica.Blocks.Logical.Or orBlock
    annotation (Placement(transformation(extent={{32,66},{52,86}})));
equation
  connect(addVa.u1, vs)
    annotation (Line(points={{-52,-40},{-120,-40}}, color={0,0,127}));
  connect(artificialRamp.y, addVa.u2) annotation (Line(points={{-69,-70},{-60,-70},
          {-60,-52},{-52,-52}}, color={0,0,127}));
  connect(ramp, artificialRamp.y) annotation (Line(points={{110,-40},{80,-40},{
          80,-70},{-69,-70}}, color={0,0,127}));
  connect(rSFlipFlop.QI, c)
    annotation (Line(points={{91,40},{110,40}}, color={255,0,255}));
  connect(addVa.y, greaterEqual.u1) annotation (Line(points={{-29,-46},{-20,-46},
          {-20,48},{-12,48}}, color={0,0,127}));
  connect(vc, vcLimiter.u)
    annotation (Line(points={{-120,40},{-52,40}}, color={0,0,127}));
  connect(vcLimiter.y, greaterEqual.u2)
    annotation (Line(points={{-29,40},{-12,40}}, color={0,0,127}));
  connect(dMinLimiter.y, rSFlipFlop.R) annotation (Line(points={{53,10},{60,10},
          {60,40},{68,40}}, color={255,0,255}));
  connect(greaterEqual.y, orBlock.u2) annotation (Line(points={{11,48},{20,48},
          {20,68},{30,68}},color={255,0,255}));
  connect(orBlock.y, rSFlipFlop.S) annotation (Line(points={{53,76},{60,76},{60,
          52},{68,52}}, color={255,0,255}));
  connect(dMaxLimiter.y, orBlock.u1)
    annotation (Line(points={{11,76},{30,76}}, color={255,0,255}));
  annotation (Icon(graphics={
        Line(points={{-80,20},{-50,-20},{-30,60},{30,-20},{50,60},{80,20}},
            color={255,0,0}),
        Line(points={{-52,-140}}, color={0,0,255}),
        Line(points={{-80.1563,45.078},{-50,30},{-50,70},{30,30},{30,70},{
              79.531,45.234}}, color={0,0,255}),
        Line(
          points={{-50,80},{-50,-80}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-30,80},{-30,-80}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{30,80},{30,-80}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{50,80},{50,-80}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(points={{-80,-80},{-50,-80},{-50,-40},{-30,-40},{-30,-80},{30,-80},
              {30,-40},{50,-40},{50,-80},{80,-80}}, color={255,0,255})}));
end SwitchingCPM;
