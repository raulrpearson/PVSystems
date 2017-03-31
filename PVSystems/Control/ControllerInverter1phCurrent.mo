within PVSystems.Control;
block ControllerInverter1phCurrent
  "Simple synchronous reference frame PI current controller"
  extends Modelica.Blocks.Interfaces.BlockIcon;
  extends Modelica.Icons.UnderConstruction;
  Park park annotation (Placement(transformation(extent={{-50,-14},{-30,6}},
          rotation=0)));
  Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime=1/50/4) annotation
    (Placement(transformation(extent={{-88,-30},{-68,-10}}, rotation=0)));
  Modelica.Blocks.Continuous.PI idPI(k=0.1, T=0.01) annotation (Placement(
        transformation(extent={{-8,50},{12,70}}, rotation=0)));
  Modelica.Blocks.Math.Feedback idFB annotation (Placement(transformation(
          extent={{-34,50},{-14,70}}, rotation=0)));
  Modelica.Blocks.Continuous.PI iqPI(k=0.1, T=0.01) annotation (Placement(
        transformation(extent={{-8,-70},{12,-50}}, rotation=0)));
  Modelica.Blocks.Math.Feedback iqFB annotation (Placement(transformation(
          extent={{-34,-50},{-14,-70}}, rotation=0)));
  InversePark inversePark annotation (Placement(transformation(extent={{24,-14},
            {44,6}}, rotation=0)));
  Modelica.Blocks.Sources.Constant dOffset(k=0.5) annotation (Placement(
        transformation(extent={{38,26},{58,46}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput i "Sensed current" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput idSetpoint
    "Current d component setpoint" annotation (Placement(transformation(extent=
            {{-140,40},{-100,80}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput iqSetpoint
    "Current q component setpoint" annotation (Placement(transformation(extent=
            {{-140,-80},{-100,-40}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput theta "Sensed AC voltage phase"
    annotation (Placement(transformation(
        origin={-40,-120},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealInput udc "Sensed DC voltage" annotation (
      Placement(transformation(
        origin={40,-120},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput d "Duty cycle output" annotation (
      Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(
          extent={{56,-16},{76,4}}, rotation=0)));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{72,
            20},{92,40}}, rotation=0)));
equation
  // Connections
  connect(park.beta, fixedDelay.y) annotation (Line(points={{-52,-8},{-60,-8},{
          -60,-20},{-67,-20}}, color={0,0,127}));
  connect(idFB.y, idPI.u)
    annotation (Line(points={{-15,60},{-10,60}}, color={0,0,127}));
  connect(park.d, idFB.u2)
    annotation (Line(points={{-29,0},{-24,0},{-24,52}}, color={0,0,127}));
  connect(iqFB.y, iqPI.u)
    annotation (Line(points={{-15,-60},{-10,-60}}, color={0,0,127}));
  connect(park.q, iqFB.u2)
    annotation (Line(points={{-29,-8},{-24,-8},{-24,-52}}, color={0,0,127}));
  connect(iqPI.y, inversePark.q) annotation (Line(points={{13,-60},{16,-60},{16,
          -8},{22,-8}}, color={0,0,127}));
  connect(idPI.y, inversePark.d)
    annotation (Line(points={{13,60},{16,60},{16,0},{22,0}}, color={0,0,127}));
  connect(i, park.alpha)
    annotation (Line(points={{-120,0},{-52,0}}, color={0,0,127}));
  connect(i, fixedDelay.u) annotation (Line(points={{-120,0},{-96,0},{-96,-20},
          {-90,-20}}, color={0,0,127}));
  connect(idSetpoint, idFB.u1)
    annotation (Line(points={{-120,60},{-32,60}}, color={0,0,127}));
  connect(iqSetpoint, iqFB.u1)
    annotation (Line(points={{-120,-60},{-32,-60}}, color={0,0,127}));
  connect(inversePark.theta, theta) annotation (Line(points={{34,-16},{34,-80},
          {-40,-80},{-40,-120}}, color={0,0,127}));
  connect(park.theta, theta) annotation (Line(points={{-40,-16},{-40,-120},{-40,
          -120}}, color={0,0,127}));
  connect(inversePark.alpha, division.u1)
    annotation (Line(points={{45,0},{54,0}}, color={0,0,127}));
  connect(udc, division.u2) annotation (Line(points={{40,-120},{40,-80},{48,-80},
          {48,-12},{54,-12}}, color={0,0,127}));
  connect(dOffset.y, add.u1)
    annotation (Line(points={{59,36},{70,36}}, color={0,0,127}));
  connect(division.y, add.u2)
    annotation (Line(points={{77,-6},{70,-6},{70,24}}, color={0,0,127}));
  connect(add.y, d) annotation (Line(points={{93,30},{96,30},{96,0},{110,0}},
        color={0,0,127}));
  annotation (
    Diagram(graphics),
    Icon(graphics={Text(
          extent={{-70,25},{70,-25}},
          lineColor={0,0,255},
          textString="Control")}),
    Documentation(info="<html>
      <p>
        Partial current controller for monophasic inverter. Currently
        under construction.
      </p>
      </html>"));
end ControllerInverter1phCurrent;
