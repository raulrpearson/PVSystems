within PVSystems.Control;
block Park "Park transformation"
  extends Modelica.Blocks.Interfaces.BlockIcon;
  Modelica.Blocks.Interfaces.RealInput alpha annotation (Placement(
        transformation(extent={{-140,20},{-100,60}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput beta annotation (Placement(
        transformation(extent={{-140,-60},{-100,-20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput d annotation (Placement(transformation(
          extent={{100,30},{120,50}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput q annotation (Placement(transformation(
          extent={{100,-50},{120,-30}}, rotation=0)));
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
    Icon(graphics={Text(
          extent={{-60,30},{60,-30}},
          lineColor={0,0,255},
          textString="AB2dq")}),
    Documentation(info="<html>
        <p>
          Perform Park transformation. This transformation translates from the
          static reference frame (alfa-beta) to the synchronous reference
          frame (d-q).
        </p>
      </html>"));
end Park;
