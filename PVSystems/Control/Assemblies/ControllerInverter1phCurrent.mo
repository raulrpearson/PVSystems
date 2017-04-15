within PVSystems.Control.Assemblies;
block ControllerInverter1phCurrent
  "Simple synchronous reference frame PI current controller"
  extends Modelica.Blocks.Icons.Block;
  parameter Real k(final unit="1") = 0.1 "PI controllers gain";
  parameter Modelica.SIunits.Time T(final min=Modelica.Constants.small) = 0.01
    "PI controllers time constant (T>0 required)";
  parameter Modelica.SIunits.Frequency fline=50 "AC line frequency";
  Park park annotation (Placement(transformation(extent={{-70,-14},{-50,6}},
          rotation=0)));
  Modelica.Blocks.Nonlinear.FixedDelay T4Delay(delayTime=1/4/fline) annotation
    (Placement(transformation(extent={{-108,-30},{-88,-10}}, rotation=0)));
  Modelica.Blocks.Continuous.PI idPI(k=k, T=T) annotation (Placement(
        transformation(extent={{-28,50},{-8,70}},rotation=0)));
  Modelica.Blocks.Math.Feedback idFB annotation (Placement(transformation(
          extent={{-54,50},{-34,70}}, rotation=0)));
  Modelica.Blocks.Continuous.PI iqPI(k=k, T=T) annotation (Placement(
        transformation(extent={{-28,-70},{-8,-50}},rotation=0)));
  Modelica.Blocks.Math.Feedback iqFB annotation (Placement(transformation(
          extent={{-54,-50},{-34,-70}}, rotation=0)));
  InversePark inversePark
    annotation (Placement(transformation(extent={{8,-14},{28,6}}, rotation=0)));
  Modelica.Blocks.Sources.Constant dOffset(k=0.5) annotation (Placement(
        transformation(extent={{50,20},{70,40}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput i "Sensed current" annotation (Placement(
        transformation(extent={{-160,-20},{-120,20}}, rotation=0),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput ids "Current d component setpoint"
    annotation (Placement(transformation(extent={{-160,40},{-120,80}}, rotation
          =0), iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput iqs "Current q component setpoint"
    annotation (Placement(transformation(extent={{-160,-80},{-120,-40}},
          rotation=0), iconTransformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput theta "Sensed AC voltage phase"
    annotation (Placement(transformation(
        origin={-40,-120},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealInput vdc "Sensed DC voltage" annotation (
      Placement(transformation(
        origin={40,-120},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput d "Duty cycle output" annotation (
      Placement(transformation(extent={{120,-10},{140,10}}, rotation=0),
        iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Division dScaling annotation (Placement(transformation(
          extent={{50,-16},{70,4}}, rotation=0)));
  Modelica.Blocks.Math.Add dCalc annotation (Placement(transformation(extent={{
            88,-10},{108,10}}, rotation=0)));
equation
  // Connections
  connect(park.beta, T4Delay.y) annotation (Line(points={{-72,-8},{-80,-8},{-80,
          -20},{-87,-20}}, color={0,0,127}));
  connect(idFB.y, idPI.u)
    annotation (Line(points={{-35,60},{-30,60}}, color={0,0,127}));
  connect(park.d, idFB.u2)
    annotation (Line(points={{-49,0},{-44,0},{-44,52}}, color={0,0,127}));
  connect(iqFB.y, iqPI.u)
    annotation (Line(points={{-35,-60},{-30,-60}}, color={0,0,127}));
  connect(park.q, iqFB.u2)
    annotation (Line(points={{-49,-8},{-44,-8},{-44,-52}}, color={0,0,127}));
  connect(iqPI.y, inversePark.q) annotation (Line(points={{-7,-60},{0,-60},{0,-8},
          {6,-8}}, color={0,0,127}));
  connect(idPI.y, inversePark.d)
    annotation (Line(points={{-7,60},{0,60},{0,0},{6,0}}, color={0,0,127}));
  connect(i, park.alpha)
    annotation (Line(points={{-140,0},{-140,0},{-72,0}}, color={0,0,127}));
  connect(i, T4Delay.u) annotation (Line(points={{-140,0},{-116,0},{-116,-20},{
          -110,-20}}, color={0,0,127}));
  connect(ids, idFB.u1)
    annotation (Line(points={{-140,60},{-52,60}}, color={0,0,127}));
  connect(iqs, iqFB.u1)
    annotation (Line(points={{-140,-60},{-52,-60}}, color={0,0,127}));
  connect(inversePark.theta, theta) annotation (Line(points={{18,-16},{18,-80},
          {-40,-80},{-40,-120}},color={0,0,127}));
  connect(inversePark.alpha, dScaling.u1)
    annotation (Line(points={{29,0},{48,0}}, color={0,0,127}));
  connect(vdc, dScaling.u2)
    annotation (Line(points={{40,-120},{40,-12},{48,-12}}, color={0,0,127}));
  connect(dScaling.y, dCalc.u2)
    annotation (Line(points={{71,-6},{86,-6}}, color={0,0,127}));
  connect(dCalc.y, d)
    annotation (Line(points={{109,0},{109,0},{130,0}}, color={0,0,127}));
  connect(theta, park.theta) annotation (Line(points={{-40,-120},{-40,-80},{-60,
          -80},{-60,-16}}, color={0,0,127}));
  connect(dOffset.y, dCalc.u1)
    annotation (Line(points={{71,30},{80,30},{80,6},{86,6}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-48,50},{12,-10}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-38,40},{-38,-4}}, color={192,192,192}),
        Polygon(
          points={{-38,40},{-42,32},{-34,32},{-38,40}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-42,0},{2,0}}, color={192,192,192}),
        Line(points={{-38,0},{-38,14},{-30,24},{2,24}}, color={0,0,127}),
        Line(
          visible=strict,
          points={{-30,24},{2,24}},
          color={255,0,0}),
        Polygon(
          points={{0,4},{-4,-4},{4,-4},{0,4}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          origin={-2,0},
          rotation=270),
        Line(points={{12,20},{52,20}}, color={0,0,127}),
        Line(points={{-88,20},{-48,20}}, color={0,0,127}),
        Line(points={{-68,20},{-68,-30},{32,-30},{32,20}}, color={0,0,127}),
        Polygon(
          points={{0,4},{-4,-4},{4,-4},{0,4}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          origin={56,20},
          rotation=270),
        Polygon(
          points={{0,4},{-4,-4},{4,-4},{0,4}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          origin={-52,20},
          rotation=270),
        Rectangle(
          extent={{-18,10},{42,-50}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-8,0},{-8,-44}}, color={192,192,192}),
        Polygon(
          points={{-8,0},{-12,-8},{-4,-8},{-8,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-12,-40},{32,-40}}, color={192,192,192}),
        Line(points={{-8,-40},{-8,-26},{0,-16},{32,-16}}, color={0,0,127}),
        Line(
          visible=strict,
          points={{0,-16},{32,-16}},
          color={255,0,0}),
        Polygon(
          points={{0,4},{-4,-4},{4,-4},{0,4}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          origin={28,-40},
          rotation=270),
        Line(points={{42,-20},{82,-20}}, color={0,0,127}),
        Line(points={{-58,-20},{-18,-20}}, color={0,0,127}),
        Line(points={{-38,-20},{-38,-70},{62,-70},{62,-20}}, color={0,0,127}),
        Polygon(
          points={{0,4},{-4,-4},{4,-4},{0,4}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          origin={86,-20},
          rotation=270),
        Polygon(
          points={{0,4},{-4,-4},{4,-4},{0,4}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          origin={-22,-20},
          rotation=270),
        Text(
          extent={{-100,80},{100,70}},
          lineColor={0,0,255},
          textString="Idq control")}),
    Documentation(info="<html>
      <p>
        Partial current controller for monophasic inverter. Currently
        under construction.
      </p>
      </html>"),
    Diagram(coordinateSystem(extent={{-120,-100},{120,100}}, initialScale=0.1)));
end ControllerInverter1phCurrent;
