within PVSystems.Electrical.Assemblies;
model HBridgeAveraged "Basic ideal H-bridge topology (averaged)"
  extends Interfaces.TwoPortConverter;
  Modelica.Blocks.Interfaces.RealInput d annotation (Placement(transformation(
        origin={0,-120},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  CCM1 s1 annotation (Placement(transformation(extent={{20,60},{40,80}},
          rotation=0)));
  CCM1 s2 annotation (Placement(transformation(extent={{-40,-80},{-20,-60}},
          rotation=0)));
equation
  connect(s1.p1, p1) annotation (Line(points={{20,75},{-68,75},{-68,50},{-100,
          50}}, color={0,0,255}));
  connect(s1.n1, p2)
    annotation (Line(points={{20,65},{20,50},{100,50}}, color={0,0,255}));
  connect(s2.n1, n1) annotation (Line(points={{-40,-75},{-70,-75},{-70,-50},{-100,
          -50}}, color={0,0,255}));
  connect(s2.p1, n2) annotation (Line(points={{-40,-65},{-48,-65},{-48,-50},{
          100,-50}}, color={0,0,255}));
  connect(s1.n2, n1) annotation (Line(points={{40,65},{40,-20},{-100,-20},{-100,
          -50}}, color={0,0,255}));
  connect(d, s2.d) annotation (Line(points={{0,-120},{0,-92},{-30,-92},{-30,-82}},
        color={0,0,127}));
  connect(d, s1.d) annotation (Line(points={{0,-120},{0,30},{30,30},{30,58}},
        color={0,0,127}));
  connect(s2.p2, p1)
    annotation (Line(points={{-20,-65},{-20,50},{-100,50}}, color={0,0,255}));
  connect(s1.p2, p2) annotation (Line(points={{40,75},{70,75},{70,50},{100,50}},
        color={0,0,255}));
  connect(s2.n2, n2) annotation (Line(points={{-20,-75},{42,-75},{42,-50},{100,
          -50}}, color={0,0,255}));
  annotation (
    Diagram(graphics),
    Icon(graphics={Text(
          extent={{-60,30},{60,-30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="1-ph"),Line(points={{-70,50},{-10,50}}, color={0,0,255}),
          Line(points={{-70,70},{-10,70}}, color={0,0,255}),Line(points={{10,-70},
          {70,-70}}, color={0,0,255}),Line(
          points={{10,-50},{24,-40},{40,-50},{56,-60},{70,-50}},
          color={0,0,255},
          smooth=Smooth.Bezier)}),
    Documentation(info="<html><p>This model further
    composes IdealAverageCCMSwitch to form a typical H-bridge
    configuration from which a 1-phase inverter can be constructed.
    This model is based in averaged switch models.</p></html>"));
end HBridgeAveraged;
