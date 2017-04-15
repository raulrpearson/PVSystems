within PVSystems.Electrical.Interfaces;
partial model BatteryInterface "Partial model for battery"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  annotation (Documentation(info=
          "<html><p>Partial model for battery</p></html>"), Icon(
        coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Line(points={{-90,0},{-50,0}}, color={0,0,0}),
          Line(points={{50,0},{90,0}}, color={0,0,0}),Line(points={{-50,40},{-50,
          -40}}, color={0,0,0}),Line(points={{-20,20},{-20,-20}}, color={0,0,0}),
          Line(points={{-20,0},{20,0}}, color={0,0,0}),Line(points={{20,40},{20,
          -40}}, color={0,0,0}),Line(points={{50,20},{50,-20}}, color={0,0,0}),
          Text(
          extent={{-80,-40},{80,-80}},
          lineColor={28,108,200},
          textString="%name")}));
end BatteryInterface;
