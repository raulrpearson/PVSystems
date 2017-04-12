within PVSystems.Electrical;
model Ideal2LevelLeg "Basic ideal two level switching leg"
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  // Interface
  Modelica.Blocks.Interfaces.BooleanInput c annotation (Placement(
        transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=90), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-70})));
  Modelica.Electrical.Analog.Interfaces.Pin m annotation (Placement(
        transformation(
        origin={0,100},
        extent={{-10,-10},{10,10}},
        rotation=90), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,60})));
  // Components
  IdealCBSwitch topSwitch annotation (Placement(transformation(extent={{-40,-10},
            {-20,10}}, rotation=0)));
  IdealCBSwitch bottomSwitch annotation (Placement(transformation(extent={{20,-10},
            {40,10}}, rotation=0)));
  Control.DeadTime deadTime annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-70})));
equation
  connect(p, topSwitch.p)
    annotation (Line(points={{-100,0},{-40,0}}, color={0,0,255}));
  connect(topSwitch.n, bottomSwitch.p)
    annotation (Line(points={{-20,0},{20,0}}, color={0,0,255}));
  connect(bottomSwitch.n, n)
    annotation (Line(points={{40,0},{100,0}}, color={0,0,255}));
  connect(m, topSwitch.n)
    annotation (Line(points={{0,100},{0,0},{-20,0}}, color={0,0,255}));
  connect(deadTime.c, c)
    annotation (Line(points={{0,-82},{0,-110}}, color={255,0,255}));
  connect(deadTime.c1, topSwitch.c) annotation (Line(points={{-4,-59},{-4,-59},
          {-4,-44},{-4,-40},{-30,-40},{-30,-7}}, color={255,0,255}));
  connect(deadTime.c2, bottomSwitch.c) annotation (Line(points={{4,-59},{4,-40},
          {30,-40},{30,-7}}, color={255,0,255}));
  annotation (Icon(graphics={
        Line(points={{-100,0},{-60,0},{-40,-10}}, color={0,0,255}),
        Line(points={{-40,0},{40,0},{60,-10}}, color={0,0,255}),
        Line(points={{60,0},{100,0}}, color={0,0,255}),
        Line(points={{-70,0},{-70,20},{-56,20}}, color={0,0,255}),
        Line(points={{-56,28},{-56,12}}, color={0,0,255}),
        Line(points={{-40,20},{-28,20},{-28,0}}, color={0,0,255}),
        Line(points={{28,0},{28,20},{42,20}}, color={0,0,255}),
        Line(points={{42,28},{42,12}}, color={0,0,255}),
        Line(points={{58,20},{70,20},{70,0}}, color={0,0,255}),
        Line(points={{0,-60},{0,-40},{-50,-40},{-50,-6}}, color={255,85,255}),
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
        Line(points={{0,60},{0,0}}, color={0,0,255})}), Documentation(info="<html><p>This model composes
    IdealCBSwitch model into a two level leg, also very common in the
    constructoin of power converters. It provides input only for the
    firing signal of the top switch, generating the firing signal for
                              the bottom switch by logical negation.</p></html>"));
end Ideal2LevelLeg;
