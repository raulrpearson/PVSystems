within PVSystems.Control;
block SignalPWM "Generates a pulse width modulated (PWM) boolean fire signal"
  extends Modelica.Blocks.Icons.Block;
  parameter Real dMax=1 "Maximum duty cycle";
  parameter Real dMin=0 "Minimum duty cycle";
  parameter Modelica.SIunits.Frequency fs "Switching frequency";
  parameter Modelica.SIunits.Time startTime=0 "Start time";
  Modelica.Blocks.Interfaces.RealInput vc "Control voltage"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput c1 "Firing PWM signal" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=dMax, uMin=dMin)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Logical.Less greaterEqual annotation (Placement(
        transformation(extent={{-10,10},{10,-10}}, origin={50,0})));
  Modelica.Blocks.Sources.SawTooth sawtooth(
    final period=1/fs,
    final amplitude=1,
    final nperiod=-1,
    final offset=0,
    final startTime=startTime) annotation (Placement(transformation(origin={0,-50},
          extent={{-10,-10},{10,10}})));
equation
  connect(vc, limiter.u)
    annotation (Line(points={{-120,0},{-94,0},{-62,0}}, color={0,0,127}));
  connect(sawtooth.y, greaterEqual.u1) annotation (Line(points={{11,-50},{20,-50},
          {20,0},{38,0}}, color={0,0,127}));
  connect(limiter.y, greaterEqual.u2)
    annotation (Line(points={{-39,0},{0,0},{0,8},{38,8}}, color={0,0,127}));
  connect(greaterEqual.y, c1)
    annotation (Line(points={{61,0},{110,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),graphics={
        Line(points={{-100,0},{-98,0},{12,0}}, color={0,0,255}),
        Line(points={{-60,-22},{-60,-64},{44,-64},{44,-36}}, color={0,0,255}),
        Line(points={{-80,-16},{-80,-20},{-40,20},{-40,-20},{-36,-16}}, color={
              0,0,255}),
        Line(points={{-62,0},{-76,4},{-76,-4},{-62,0}}, color={0,0,255}),
        Line(points={{44,-36},{44,-36},{40,-50},{44,-50},{48,-50},{44,-36}},
            color={0,0,255}),
        Line(points={{20,-20},{22,-20},{24,-20},{24,20},{44,20},{44,-20},{64,-20},
              {64,-16}}, color={255,0,255}),
        Line(points={{-40,-16},{-40,-20},{0,20},{0,-20},{4,-16}}, color={0,0,
              255}),
        Line(points={{60,-20},{62,-20},{64,-20},{64,20},{84,20},{84,-20},{84,-20},
              {88,-20}}, color={255,0,255})}), Documentation(info="<html>
        <p>
          Generate boolean firing signal from duty cycle input. Adapted
          from <a href=\"modelica://Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM\">SignalPWM</a>.</p>
      </html>"));
end SignalPWM;
