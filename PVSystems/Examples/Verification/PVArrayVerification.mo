within PVSystems.Examples.Verification;
model PVArrayVerification "PVArray verification"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Sources.RampVoltage rampVoltage(
    duration=1,
    V=45,
    offset=-10) annotation (Placement(transformation(
        origin={40,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{30,-40},{50,-20}}, rotation=0)));
  Electrical.PVArray pVArray annotation (Placement(transformation(
        origin={0,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Constant Gn(k=1000) annotation (Placement(
        transformation(extent={{-50,10},{-30,30}}, rotation=0)));
  Modelica.Blocks.Sources.Constant Tn(k=298.15) annotation (Placement(
        transformation(extent={{-50,-24},{-30,-4}}, rotation=0)));
equation
  connect(Gn.y, pVArray.G) annotation (Line(points={{-29,20},{-16,20},{-16,13},
          {-5.5,13}}, color={0,0,127}));
  connect(Tn.y, pVArray.T) annotation (Line(points={{-29,-14},{-16,-14},{-16,7},
          {-5.5,7}}, color={0,0,127}));
  connect(pVArray.p, rampVoltage.p)
    annotation (Line(points={{1.83691e-015,20},{40,20}}, color={0,0,255}));
  connect(pVArray.n, rampVoltage.n)
    annotation (Line(points={{-1.83691e-015,0},{40,0}}, color={0,0,255}));
  connect(ground.p, rampVoltage.n)
    annotation (Line(points={{40,-20},{40,0}}, color={0,0,255}));
  annotation (
    Diagram(graphics),
    Documentation(info="<html>
        <p>
          PVArrayValidation presents a ramp DC voltage source in parallel with
          an instance of the PVArray model. The voltage ramp is configured to
          sweep from -10 volts to 35 volts in 1 second. This provides the
          enough voltage range to cover all of the PV array's working range
          when initialized with default values.
        </p>

        <p>
          To use the example, simulate the model and start by displaying both
          voltage and current of the ramp voltage source. A figure like the
          following should be displayed:
        </p>


        <div class=\"figure\">
          <p><img src=\"modelica://PVSystems/Resources/Images/PVArrayValidationResults.png\"
                  alt=\"PVArrayValidationResults.png\" />
          </p>
        </div>

        <p>
          Notice how the variation in the current delivered by the PV array
          (sinked by the voltage source) reflects the familiar PV module
          curve.
        </p>

        <p>
          Modify the values for the irradiance and temperature blocks and see
          how these changes are reflected in a change in the PV curve,
          accurately reflecting the effects of these variables in the PV
          module performance.
        </p>
        </html>"),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-4));
end PVArrayVerification;
