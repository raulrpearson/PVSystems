within PVSystems.Electrical.Assemblies;
model HBridgeSwitched "Basic ideal H-bridge topology (switched)"
  // Interface
  Modelica.Electrical.Analog.Interfaces.Pin dcp "Positive pin of the DC port"
    annotation (Placement(transformation(extent={{-110,40},{-90,60}}, rotation=
            0)));
  Modelica.Electrical.Analog.Interfaces.Pin dcn "Negative pin of the DC port"
    annotation (Placement(transformation(extent={{-110,-60},{-90,-40}},
          rotation=0)));
  Modelica.Electrical.Analog.Interfaces.Pin acp "Positive pin of the AC port"
    annotation (Placement(transformation(extent={{90,40},{110,60}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.Pin acn "Negative pin of the AC port"
    annotation (Placement(transformation(extent={{90,-60},{110,-40}}, rotation=
            0)));
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
  Modelica.SIunits.Voltage vdc "DC voltage";
  Modelica.SIunits.Voltage vac "AC voltage";
  // Components
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
  vdc = dcp.v - dcn.v;
  vac = acp.v - acn.v;
  connect(c1, idealCBSwitch.c) annotation (Line(points={{-40,-100},{-40,-100},{
          -40,24},{-40,30},{-7,30}}, color={255,0,255}));
  connect(c1, idealCBSwitch3.c) annotation (Line(points={{-40,-100},{-40,-60},{
          20,-60},{20,-30},{53,-30}}, color={255,0,255}));
  connect(c2, idealCBSwitch2.c) annotation (Line(points={{40,-100},{40,-50},{40,
          30},{53,30}}, color={255,0,255}));
  connect(c2, idealCBSwitch1.c) annotation (Line(points={{40,-100},{40,-70},{
          -20,-70},{-20,-30},{-7,-30}}, color={255,0,255}));
  connect(dcp, idealCBSwitch2.p) annotation (Line(points={{-100,50},{-40,50},{
          60,50},{60,40}}, color={0,0,255}));
  connect(idealCBSwitch.p, idealCBSwitch2.p)
    annotation (Line(points={{0,40},{0,50},{60,50},{60,40}}, color={0,0,255}));
  connect(idealCBSwitch1.p, idealCBSwitch.n)
    annotation (Line(points={{0,-20},{0,0},{0,20}}, color={0,0,255}));
  connect(idealCBSwitch2.n, idealCBSwitch3.p)
    annotation (Line(points={{60,20},{60,0},{60,-20}}, color={0,0,255}));
  connect(dcn, idealCBSwitch1.n) annotation (Line(points={{-100,-50},{0,-50},{0,
          -40},{-1.77636e-015,-40}}, color={0,0,255}));
  connect(idealCBSwitch3.n, idealCBSwitch1.n) annotation (Line(points={{60,-40},
          {60,-50},{0,-50},{0,-40},{-1.77636e-015,-40}}, color={0,0,255}));
  connect(acn, idealCBSwitch3.p) annotation (Line(points={{100,-50},{80,-50},{
          80,-10},{60,-10},{60,-20}}, color={0,0,255}));
  connect(acp, idealCBSwitch.n) annotation (Line(points={{100,50},{80,50},{80,
          10},{0,10},{0,20},{-1.77636e-015,20}}, color={0,0,255}));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,-100},{100,100}}, color={0,0,255}),
        Text(
          extent={{-76,38},{76,-22}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="1-ph"),
        Ellipse(
          extent={{2,-32},{38,-60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-68,56},{-10,56}}, color={0,0,255}),
        Line(points={{-68,76},{-10,76}}, color={0,0,255}),
        Line(points={{0,-82},{76,-82}}, color={0,0,255}),
        Ellipse(
          extent={{2,-36},{38,-64}},
          lineColor={28,108,200},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{38,-36},{74,-64}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{38,-28},{74,-56}},
          lineColor={28,108,200},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html><p>This model further
    composes IdealTwoLevelBranch to form a typical H-bridge
    configuration from which a 1-phase inverter can be constructed.
    This model is based on discrete switch models.</p></html>"));
end HBridgeSwitched;
