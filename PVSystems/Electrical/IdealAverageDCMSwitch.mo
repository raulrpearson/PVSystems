within PVSystems.Electrical;
model IdealAverageDCMSwitch
  "Average switch model for any ideal 2-switch PWM converter in DCM"
  extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  parameter Modelica.SIunits.Inductance Le "Equivalent DCM inductance";
  parameter Modelica.SIunits.Frequency fs "Switching frequency";
  Modelica.Blocks.Interfaces.RealInput d "Duty cycle" annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  Real mu "Effective switch conversion ratio";
  Real Re "Equivalent DCM port 1 resistance";
equation
  Re = 2*Le*fs/d^2;
  mu = max(d, 1/(1 + Re*i1/v2));
  v1 = (1 - mu)/mu*v2;
  -i2 = (1 - mu)/mu*i1;
  annotation (Diagram(graphics), Icon(graphics={
        Polygon(
          points={{60,20},{40,-20},{80,-20},{60,20}},
          lineColor={0,0,0},
          fillColor={255,255,255}),
        Line(points={{60,50},{60,-50}}),
        Line(points={{60,50},{90,50}}),
        Line(points={{80,20},{40,20}}, color={0,0,255}),
        Text(extent={{-100,100},{100,70}}, textString="%name"),
        Line(points={{60,-50},{90,-50}}),
        Line(points={{-60,-50},{-60,50}}),
        Line(points={{-60,30},{-80,30}}),
        Line(points={{-48,30},{-48,-30}}),
        Line(points={{-80,0},{-80,-50}}),
        Line(points={{-90,-50},{-80,-50}}),
        Line(points={{-80,30},{-80,50}}),
        Line(points={{-90,50},{-80,50}}),
        Polygon(
          points={{-60,0},{-70,5},{-70,-5},{-60,0}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,-30},{-80,-30}}),
        Line(points={{-60,0},{-80,0}}),
        Polygon(
          points={{0,-40},{-10,-60},{10,-60},{0,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255}),
        Line(points={{0,-60},{0,-100}}),
        Line(points={{0,0},{0,-40}}),
        Line(points={{-46,0},{0,0}})}));
end IdealAverageDCMSwitch;
