within PVSystems.Control;
model CPM "Current Peak Mode modulator for averaged models"
  extends Interfaces.CPMInterface;
protected
  Real d2;
equation
  d2 = min(L*fs*(vc - Va*d)/Rf/vm2, 1 - d);
  d = 2*(vc*(d + d2) - vs)/(vm1 + vm2)*d2*(d + d2) + 2*Va*(d + d2);
  annotation (Icon(graphics={
        Line(points={{-80,20},{-70,0},{-50,0},{-30,60},{10,0},{30,0},{50,60},{
              80,20}}, color={255,0,0}),
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
end CPM;
