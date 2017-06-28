within PVSystems.Examples.Verification;
model ParkVerification "Park transformations verification"
  extends Modelica.Icons.Example;
  Control.Park park
    annotation (Placement(transformation(extent={{0,20},{20,40}}, rotation=0)));
  Control.InversePark inversePark annotation (Placement(transformation(extent={
            {40,20},{60,40}}, rotation=0)));
  Modelica.Blocks.Sources.SawTooth sawTooth(amplitude=2*Modelica.Constants.pi,
      period=0.02) annotation (Placement(transformation(extent={{-80,-40},{-60,
            -20}}, rotation=0)));
  Modelica.Blocks.Math.Sin sin annotation (Placement(transformation(extent={{-40,
            0},{-20,20}}, rotation=0)));
  Modelica.Blocks.Math.Cos cos annotation (Placement(transformation(extent={{-40,
            40},{-20,60}}, rotation=0)));
equation
  connect(park.d, inversePark.d)
    annotation (Line(points={{21,34},{38,34}}, color={0,0,127}));
  connect(park.q, inversePark.q)
    annotation (Line(points={{21,26},{38,26}}, color={0,0,127}));
  connect(cos.u, sawTooth.y) annotation (Line(points={{-42,50},{-50,50},{-50,-30},
          {-59,-30}}, color={0,0,127}));
  connect(sin.u, sawTooth.y) annotation (Line(points={{-42,10},{-50,10},{-50,-30},
          {-59,-30}}, color={0,0,127}));
  connect(cos.y, park.alpha) annotation (Line(points={{-19,50},{-10,50},{-10,34},
          {-2,34}}, color={0,0,127}));
  connect(sin.y, park.beta) annotation (Line(points={{-19,10},{-10,10},{-10,26},
          {-2,26}}, color={0,0,127}));
  connect(park.theta, sawTooth.y)
    annotation (Line(points={{10,18},{10,-30},{-59,-30}}, color={0,0,127}));
  connect(inversePark.theta, sawTooth.y)
    annotation (Line(points={{50,18},{50,-30},{-59,-30}}, color={0,0,127}));
  annotation (
    Diagram(graphics),
    experiment(StopTime=0.1),
    Documentation(info="<html>
      <p>
        This example provides some easy input for the Park transform blocks
        to check that calculations are being done as expected. Run the
        simulation and you should get something like the following figure:
      </p>

      <div class=\"figure\">
        <p><img src=\"modelica://PVSystems/Resources/Images/ParkValidationResults.png\"
                alt=\"ParkValidationResults.png\" />
        </p>
      </div>

      <p>
        As expected, <i>d</i> is equal to the peak amplitude of the input
        signal and <i>q</i> sets at zero. Feeding the signals back to the
        inverse transformation block recreates the original signals.
      </p>
      </html>"));
end ParkVerification;
