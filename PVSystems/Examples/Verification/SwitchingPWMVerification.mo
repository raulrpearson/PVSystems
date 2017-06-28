within PVSystems.Examples.Verification;
model SwitchingPWMVerification "Simple model to verify SwitchingPWM behaviour"
  extends Modelica.Icons.Example;
  Control.SwitchingPWM signalPWM(fs=100)
    annotation (Placement(transformation(extent={{20,0},{40,20}}, rotation=0)));
  Modelica.Blocks.Sources.Step step(
    height=0.3,
    offset=0.2,
    startTime=0.3) annotation (Placement(transformation(extent={{-80,20},{-60,
            40}}, rotation=0)));
  Modelica.Blocks.Sources.Step step1(height=0.3, startTime=0.6) annotation (
      Placement(transformation(extent={{-80,-20},{-60,0}}, rotation=0)));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-20,0},{0,20}}, rotation=0)));
equation
  connect(step.y, add.u1) annotation (Line(points={{-59,30},{-40,30},{-40,16},{
          -22,16}}, color={0,0,127}));
  connect(step1.y, add.u2) annotation (Line(points={{-59,-10},{-40,-10},{-40,4},
          {-22,4}}, color={0,0,127}));
  connect(add.y, signalPWM.vc)
    annotation (Line(points={{1,10},{18,10}}, color={0,0,127}));
  annotation (
    Diagram(graphics),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-4),
    Documentation(info="<html>
      <p>
        SignalPWMValidation presents a very simple model aimed at validating
        the behaviour of the SignalPWM block. It provides a changing duty
        cycle with the use of two step blocks. When running the simulation
        with the provided values, plotting the fire output generates the
        following graph:
      </p>


      <div class=\"figure\">
        <p><img src=\"modelica://PVSystems/Resources/Images/SignalPWMValidationResults.png\"
                alt=\"SignalPWMValidationResults.png\" />
        </p>
      </div>

      <p>
        Through inspection of the plot, it can be seen how the signal
        constitutes a PWM signal with a duty cycle changing in steps through
        the values 0.2, 0.5 and 0.8. Zoom into the signal to confirm this
        fact as well as the value of the period, set at 10 milliseconds.
      </p>
      </html>"));
end SwitchingPWMVerification;
