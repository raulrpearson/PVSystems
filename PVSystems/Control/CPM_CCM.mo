within PVSystems.Control;
model CPM_CCM "Current Peak Mode modulator for averaged CCM models"
  extends Interfaces.CPMInterface;
  parameter Real d_disabled(final unit="1") "Value of duty cycle when disabled";
  Modelica.Blocks.Interfaces.BooleanInput enable
    "Block enable/disable" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
equation
  if enable then
    d = 2*(vc - vs)/(Rf/L/fs*(vm1 + vm2)*(1 - d) + 2*Va);
  else
    d = d_disabled;
  end if;
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
        Line(points={{-80,-70},{80,-70}}, color={0,0,0})}),
    Documentation(info="<html>
        <p>
          Current-Programmed-Mode controller model. Computes duty ratio
          based on averaged inductor current, voltages applied to the
          inductor, and amplitude of the artificial ramp. This CPM
          controller model is valid <b>only for CCM operation</b> of the
          powerconverter. All parameters and inputs are referred to the
          primary side.
        </p>
      
        <p>
          <i>Limitation</i>: does not include sampling effects or preditions
          of period-doubling instability.
        </p>
      
        <p>
          Model taken
          from <a href=\"modelica://PVSystems.UsersGuide.References.EM01\">EM01</a>
          and <a href=\"modelica://PVSystems.UsersGuide.References.EMA16\">EMA16</a>.</p>
      </html>"));
end CPM_CCM;
