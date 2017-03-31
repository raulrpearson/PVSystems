within PVSystems.Electrical;
model Ideal2LevelLeg "Basic ideal two level switching leg"
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  // Interface
  Modelica.Blocks.Interfaces.BooleanInput fire annotation (Placement(
        transformation(
        origin={0,-70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Interfaces.Pin midPoint annotation (Placement(
        transformation(
        origin={0,100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  // Components
  Modelica.Blocks.Logical.Not notBlock annotation (Placement(transformation(
        origin={30,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  IdealCBSwitch topSwitch annotation (Placement(transformation(extent={{-40,-10},
            {-20,10}}, rotation=0)));
  IdealCBSwitch bottomSwitch annotation (Placement(transformation(extent={{20,-10},
            {40,10}}, rotation=0)));
equation
  connect(p, topSwitch.p)
    annotation (Line(points={{-100,0},{-40,0}}, color={0,0,255}));
  connect(topSwitch.n, bottomSwitch.p)
    annotation (Line(points={{-20,0},{20,0}}, color={0,0,255}));
  connect(bottomSwitch.n, n)
    annotation (Line(points={{40,0},{100,0}}, color={0,0,255}));
  connect(fire, notBlock.u) annotation (Line(points={{0,-70},{0,-52},{30,-52},{
          30,-42}}, color={255,0,255}));
  connect(fire, topSwitch.fire) annotation (Line(points={{0,-70},{0,-52},{-30,-52},
          {-30,-7}}, color={255,0,255}));
  connect(notBlock.y, bottomSwitch.fire)
    annotation (Line(points={{30,-19},{30,-7}}, color={255,0,255}));
  connect(midPoint, topSwitch.n)
    annotation (Line(points={{0,100},{0,0},{-20,0}}, color={0,0,255}));
  annotation (
    Diagram(graphics),
    Icon(graphics={
        Line(points={{-100,0},{-60,0},{-40,-10}}, color={0,0,255}),
        Line(points={{-40,0},{40,0},{60,-10}}, color={0,0,255}),
        Line(points={{60,0},{100,0}}, color={0,0,255}),
        Line(points={{-70,0},{-70,20},{-56,20}}, color={0,0,255}),
        Line(points={{-56,28},{-56,12}}, color={0,0,255}),
        Line(points={{-40,20},{-28,20},{-28,0}}, color={0,0,255}),
        Line(points={{28,0},{28,20},{42,20}}, color={0,0,255}),
        Line(points={{42,28},{42,12}}, color={0,0,255}),
        Line(points={{58,20},{70,20},{70,0}}, color={0,0,255}),
        Line(points={{0,-80},{0,-40},{-50,-40},{-50,-6}}, color={255,85,255}),
        Line(points={{0,-40},{50,-40},{50,-6}}, color={255,85,255}),
        Polygon(
          points={{54,-24},{46,-24},{50,-16},{54,-24}},
          lineColor={255,85,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{49,-16},{51,-18}},
          lineColor={255,85,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-56,20},{-40,10},{-40,28},{-56,20}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{42,20},{58,10},{58,28},{42,20}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,100},{0,0}}, color={0,0,255})}),
    Documentation(info="<html><p>This model composes
    IdealCBSwitch model into a two level leg, also very common in the
    constructoin of power converters. It provides input only for the
    firing signal of the top switch, generating the firing signal for
                              the bottom switch by logical negation.</p></html>"));
end Ideal2LevelLeg;
