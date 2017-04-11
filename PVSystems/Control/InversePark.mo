within PVSystems.Control;
block InversePark "Inverse Park transformation"
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput d annotation (Placement(transformation(
          extent={{-140,20},{-100,60}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput q annotation (Placement(transformation(
          extent={{-140,-60},{-100,-20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput alpha annotation (Placement(
        transformation(extent={{100,30},{120,50}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput beta annotation (Placement(
        transformation(extent={{100,-50},{120,-30}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput theta annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{-20,-20},{20,20}},
        rotation=90)));
equation
  d = alpha*cos(theta) + beta*sin(theta);
  q = -alpha*sin(theta) + beta*cos(theta);
  annotation (
    Diagram(graphics),
    Icon(graphics={
        Line(
          points={{0,0},{15,60},{30,0},{45,-60},{60,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-96,-234}},
          color={255,0,0},
          smooth=Smooth.Bezier),
        Line(points={{-80,20},{-20,20}}, color={128,0,255}),
        Line(points={{-80,-20},{-20,-20}}, color={0,255,0}),
        Line(
          points={{15,0},{30,60},{45,0},{60,-60},{75,0}},
          color={255,0,0},
          smooth=Smooth.Bezier)}),
    Documentation(info="<html>
        <p>
          Perform inverse Park transformation. This transformation translates
          from the synchronous reference frame (d-q) to the static reference
          frame (alfa-beta).
        </p>
      </html>"));
end InversePark;
