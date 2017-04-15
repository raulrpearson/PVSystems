within PVSystems.Electrical.Assemblies;
model HBridgeSwitched "Basic ideal H-bridge topology (switched)"
  extends Interfaces.TwoPortConverter;
  Modelica.Blocks.Interfaces.BooleanInput c1 annotation (Placement(
        transformation(
        origin={-40,-100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.BooleanInput c2 annotation (Placement(
        transformation(
        origin={40,-100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  IdealCBSwitch idealCBSwitch annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,30})));
  IdealCBSwitch idealCBSwitch1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-30})));
  IdealCBSwitch idealCBSwitch2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,30})));
  IdealCBSwitch idealCBSwitch3 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-30})));
equation
  connect(c1, idealCBSwitch.c) annotation (Line(points={{-40,-100},{-40,-100},{
          -40,24},{-40,30},{-7,30}}, color={255,0,255}));
  connect(c1, idealCBSwitch3.c) annotation (Line(points={{-40,-100},{-40,-60},{
          20,-60},{20,-30},{53,-30}}, color={255,0,255}));
  connect(c2, idealCBSwitch2.c) annotation (Line(points={{40,-100},{40,-50},{40,
          30},{53,30}}, color={255,0,255}));
  connect(c2, idealCBSwitch1.c) annotation (Line(points={{40,-100},{40,-70},{-20,
          -70},{-20,-30},{-7,-30}}, color={255,0,255}));
  connect(p1, idealCBSwitch2.p) annotation (Line(points={{-100,50},{-40,50},{60,
          50},{60,40}}, color={0,0,255}));
  connect(idealCBSwitch.p, idealCBSwitch2.p)
    annotation (Line(points={{0,40},{0,50},{60,50},{60,40}}, color={0,0,255}));
  connect(idealCBSwitch1.p, idealCBSwitch.n)
    annotation (Line(points={{0,-20},{0,0},{0,20}}, color={0,0,255}));
  connect(idealCBSwitch2.n, idealCBSwitch3.p)
    annotation (Line(points={{60,20},{60,0},{60,-20}}, color={0,0,255}));
  connect(n1, idealCBSwitch1.n) annotation (Line(points={{-100,-50},{0,-50},{0,
          -40},{-1.77636e-015,-40}}, color={0,0,255}));
  connect(idealCBSwitch3.n, idealCBSwitch1.n) annotation (Line(points={{60,-40},
          {60,-50},{0,-50},{0,-40},{-1.77636e-015,-40}}, color={0,0,255}));
  connect(n2, idealCBSwitch3.p) annotation (Line(points={{100,-50},{80,-50},{80,
          -10},{60,-10},{60,-20}}, color={0,0,255}));
  connect(p2, idealCBSwitch.n) annotation (Line(points={{100,50},{80,50},{80,10},
          {0,10},{0,20},{-1.77636e-015,20}}, color={0,0,255}));
  annotation (Icon(graphics={Text(
          extent={{-60,30},{60,-30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="1-ph"),Line(points={{-70,50},{-10,50}}, color={0,0,255}),
          Line(points={{-70,70},{-10,70}}, color={0,0,255}),Line(points={{10,-70},
          {70,-70}}, color={0,0,255}),Line(
          points={{10,-50},{24,-40},{40,-50},{56,-60},{70,-50}},
          color={0,0,255},
          smooth=Smooth.Bezier)}), Documentation(info="<html><p>This model further
    composes IdealTwoLevelBranch to form a typical H-bridge
    configuration from which a 1-phase inverter can be constructed.
    This model is based on discrete switch models.</p></html>"));
end HBridgeSwitched;
