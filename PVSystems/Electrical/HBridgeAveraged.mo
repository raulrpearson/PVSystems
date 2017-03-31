within PVSystems.Electrical;
model HBridgeAveraged "Basic ideal H-bridge topology (averaged)"
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
  Modelica.Blocks.Interfaces.RealInput d annotation (Placement(transformation(
        origin={0,-120},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  Modelica.SIunits.Voltage vdc "DC voltage";
  Modelica.SIunits.Voltage vac "AC voltage";
  // Components
  IdealAverageCCMSwitch s1 annotation (Placement(transformation(extent={{20,60},
            {40,80}}, rotation=0)));
  IdealAverageCCMSwitch s2 annotation (Placement(transformation(extent={{-40,-80},
            {-20,-60}}, rotation=0)));
equation
  vdc = dcp.v - dcn.v;
  vac = acp.v - acn.v;
  connect(s1.p1, dcp) annotation (Line(points={{20,75},{-68,75},{-68,50},{-100,
          50}}, color={0,0,255}));
  connect(s1.n1, acp)
    annotation (Line(points={{20,65},{20,50},{100,50}}, color={0,0,255}));
  connect(s2.n1, dcn) annotation (Line(points={{-40,-75},{-70,-75},{-70,-50},{-100,
          -50}}, color={0,0,255}));
  connect(s2.p1, acn) annotation (Line(points={{-40,-65},{-48,-65},{-48,-50},{
          100,-50}}, color={0,0,255}));
  connect(s1.n2, dcn) annotation (Line(points={{40,65},{40,-20},{-100,-20},{-100,
          -50}}, color={0,0,255}));
  connect(d, s2.d) annotation (Line(points={{0,-120},{0,-92},{-30,-92},{-30,-82}},
        color={0,0,127}));
  connect(d, s1.d) annotation (Line(points={{0,-120},{0,30},{30,30},{30,58}},
        color={0,0,127}));
  connect(s2.p2, dcp)
    annotation (Line(points={{-20,-65},{-20,50},{-100,50}}, color={0,0,255}));
  connect(s1.p2, acp) annotation (Line(points={{40,75},{70,75},{70,50},{100,50}},
        color={0,0,255}));
  connect(s2.n2, acn) annotation (Line(points={{-20,-75},{42,-75},{42,-50},{100,
          -50}}, color={0,0,255}));
  annotation (
    Diagram(graphics),
    Icon(graphics={
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
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html><p>This model further
    composes IdealAverageCCMSwitch to form a typical H-bridge
    configuration from which a 1-phase inverter can be constructed.
    This model is based in averaged switch models.</p></html>"));
end HBridgeAveraged;
