within PVSystems.Control;
model CPM_CCM "Current Peak Mode modulator for averaged CCM models"
  extends Interfaces.CPMInterface;
equation
  d = 2*(vc - vs)/(Rf/L/fs*(vm1 + vm2)*(1 - d) + 2*Va);
  annotation (Icon(graphics={
        Line(points={{-80,20},{-50,-20},{-30,60},{30,-20},{50,60},{80,20}},
            color={255,0,0}),
        Line(points={{-52,-140}}, color={0,0,255}),
        Line(points={{-80.1563,45.078},{-50,30},{-50,70},{30,30},{30,70},{
              79.531,45.234}}, color={0,0,255}),
        Line(
          points={{-50,80},{-50,-30}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-30,80},{-30,-30}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{30,80},{30,-30}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{50,80},{50,-30}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-80,-80},{-50,-80},{-50,-40},{-30,-40},{-30,-80},{30,-80},{
              30,-40},{50,-40},{50,-80},{80,-80}},
          color={255,0,255},
          pattern=LinePattern.Dot),
        Line(points={{-80,-70},{80,-70}}, color={0,0,0})}));
end CPM_CCM;
