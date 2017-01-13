within PVSystems.Electrical;
  model HBridgeSwitched "Basic ideal H-bridge topology (switched)"
    // Interface
    Modelica.Electrical.Analog.Interfaces.Pin dcp "Positive pin of the DC port"
      annotation (Placement(transformation(extent={{-110,40},{-90,60}},
            rotation=0)));
    Modelica.Electrical.Analog.Interfaces.Pin dcn "Negative pin of the DC port"
      annotation (Placement(transformation(extent={{-110,-60},{-90,-40}},
            rotation=0)));
    Modelica.Electrical.Analog.Interfaces.Pin acp "Positive pin of the AC port"
      annotation (Placement(transformation(extent={{90,40},{110,60}}, rotation=
              0)));
    Modelica.Electrical.Analog.Interfaces.Pin acn "Negative pin of the AC port"
      annotation (Placement(transformation(extent={{90,-60},{110,-40}},
            rotation=0)));
    Modelica.Blocks.Interfaces.BooleanInput fireA
      annotation (Placement(transformation(
          origin={-30,-100},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Blocks.Interfaces.BooleanInput fireB
      annotation (Placement(transformation(
          origin={30,-100},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.SIunits.Voltage vdc "DC voltage";
    Modelica.SIunits.Voltage vac "AC voltage";
    // Components
    Ideal2LevelLeg legA
      annotation (Placement(transformation(
          origin={10,30},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Ideal2LevelLeg legB
      annotation (Placement(transformation(
          origin={50,-30},
          extent={{-10,-10},{10,10}},
          rotation=270)));
  equation
    vdc = dcp.v - dcn.v;
    vac = acp.v - acn.v;
    connect(dcp, legA.p)
      annotation (Line(points={{-100,50},{10,50},{10,40}}, color={0,0,255}));
    connect(legA.n, dcn)
      annotation (Line(points={{10,20},{10,-50},{-100,-50}}, color={0,0,255}));
    connect(legA.midPoint, acp)
      annotation (Line(points={{20,30},{60,30},{60,50},{100,50}}, color={0,0,
            255}));
    connect(legB.midPoint, acn)
      annotation (Line(points={{60,-30},{80,-30},{80,-50},{100,-50}}, color={0,
            0,255}));
    connect(fireA, legA.fire)
      annotation (Line(points={{-30,-100},{-30,30},{3,30}}, color={255,0,255}));
    connect(fireB, legB.fire)
      annotation (Line(points={{30,-100},{30,-30},{43,-30}}, color={255,0,255}));
    connect(legB.p, dcp)
      annotation (Line(points={{50,-20},{50,50},{-100,50}}, color={0,0,255}));
    connect(legB.n, dcn)
      annotation (Line(points={{50,-40},{50,-50},{-100,-50}}, color={0,0,255}));
    annotation(Diagram(graphics),
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
            textString=
                   "1-ph"),
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
    composes IdealTwoLevelBranch to form a typical H-bridge
    configuration from which a 1-phase inverter can be constructed.
    This model is based on discrete switch models.</p></html>"));
  end HBridgeSwitched;