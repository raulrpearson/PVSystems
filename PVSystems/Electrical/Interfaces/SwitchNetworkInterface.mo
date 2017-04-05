within PVSystems.Electrical.Interfaces;
partial model SwitchNetworkInterface
  "Interface for the averaged switch network models"
  extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  annotation (Icon(graphics={
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
end SwitchNetworkInterface;
