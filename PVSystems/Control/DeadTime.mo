within PVSystems.Control;
block DeadTime "Introduces a dead time in complementary PWM firing signals"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Time deadTime=0 "Dead time";
  Modelica.Blocks.Interfaces.BooleanInput c "PWM input"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput c1 "PWM output" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,40})));
  Modelica.Blocks.Interfaces.BooleanOutput c2 "PWM complement" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-40})));
  Modelica.Blocks.MathBoolean.OnDelay c1_onDelay(delayTime=deadTime)
    annotation (Placement(transformation(extent={{56,36},{64,44}})));
  Modelica.Blocks.MathBoolean.OnDelay c2_onDelay(delayTime=deadTime)
    annotation (Placement(transformation(extent={{56,-44},{64,-36}})));
  Modelica.Blocks.Logical.Not notBlock
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
equation
  connect(c1_onDelay.y, c1)
    annotation (Line(points={{64.8,40},{110,40}}, color={255,0,255}));
  connect(c2_onDelay.y, c2)
    annotation (Line(points={{64.8,-40},{110,-40}}, color={255,0,255}));
  connect(notBlock.y, c2_onDelay.u)
    annotation (Line(points={{11,-40},{54.4,-40}}, color={255,0,255}));
  connect(c, c1_onDelay.u) annotation (Line(points={{-120,0},{-60,0},{-60,40},{
          54.4,40}}, color={255,0,255}));
  connect(c, notBlock.u) annotation (Line(points={{-120,0},{-60,0},{-60,-40},{-12,
          -40}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),graphics={
        Rectangle(
          extent={{-20,80},{20,-80}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          lineColor={0,0,255}),
        Line(points={{-70,70},{-20,70},{-20,10},{70,10}}, color={255,0,255}),
        Line(points={{-70,-70},{20,-70},{20,-10},{70,-10}}, color={255,0,255}),
        Line(
          points={{20,80},{20,-80}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-20,80},{-20,-80}},
          color={0,0,255},
          pattern=LinePattern.Dash)}),
    Documentation(info="<html>
        <p>
          Given an input boolean firing signal, output that signal and it's
          complement with <i>deadTime</i> seconds of dead time.</p>
      </html>"));
end DeadTime;
