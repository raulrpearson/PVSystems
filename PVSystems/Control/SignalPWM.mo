within PVSystems.Control;
block SignalPWM "Generates a pulse width modulated (PWM) boolean fire signal"
  extends Modelica.Blocks.Interfaces.BlockIcon;
  // Parameters
  parameter Modelica.SIunits.Time period(final min=Modelica.Constants.small) =
    1 "Time for one period";
  // Interface
  Modelica.Blocks.Interfaces.RealInput duty annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput fire annotation (Placement(
        transformation(extent={{90,40},{110,60}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput notFire annotation (Placement(
        transformation(extent={{90,-60},{110,-40}}, rotation=0)));
  // Elements
  Modelica.Blocks.Sources.SawTooth sawTooth(period=period) annotation (
      Placement(transformation(extent={{-80,40},{-60,60}}, rotation=0)));
  Modelica.Blocks.Logical.Less lessBlock annotation (Placement(transformation(
          extent={{-20,40},{0,60}}, rotation=0)));
  Modelica.Blocks.Logical.Not notBlock annotation (Placement(transformation(
          extent={{40,-60},{60,-40}}, rotation=0)));
equation
  connect(sawTooth.y, lessBlock.u1)
    annotation (Line(points={{-59,50},{-22,50}}, color={0,0,127}));
  connect(duty, lessBlock.u2) annotation (Line(points={{-100,0},{-40,0},{-40,42},
          {-22,42}}, color={0,0,127}));
  connect(lessBlock.y, fire) annotation (Line(points={{1,50},{48,50},{48,50},{
          100,50}}, color={255,0,255}));
  connect(notBlock.u, lessBlock.y) annotation (Line(points={{38,-50},{20,-50},{
          20,50},{1,50}}, color={255,0,255}));
  connect(notBlock.y, notFire)
    annotation (Line(points={{61,-50},{100,-50}}, color={255,0,255}));
  annotation (
    Diagram(graphics),
    Icon(graphics={Text(
          extent={{-50,52},{56,-50}},
          lineColor={0,0,255},
          textString="PWM")}),
    Documentation(info="<html>
          <p>This block provides the switching
            signal needed to drive the ideal switch models. It's
             input <i>duty</i> receives the desired duty cycle and
             the outputs <i>fire</i> and <i>notFire</i> provide the
             PWM and negated PWM signals.
          </p>
        </html>"));
end SignalPWM;
