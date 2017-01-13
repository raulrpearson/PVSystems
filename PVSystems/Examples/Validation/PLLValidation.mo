within PVSystems.Examples.Validation;
model PLLValidation "PLL validation example"
      extends Modelica.Icons.Example;
      Modelica.Blocks.Sources.Sine source(freqHz=50)
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}},
              rotation=0)));
      Control.PLL pLL
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
      Modelica.Blocks.Math.Cos sync
        annotation (Placement(transformation(extent={{30,-10},{50,10}},
              rotation=0)));
    equation
      connect(source.y, pLL.v)
        annotation (Line(points={{-29,0},{-12,0}}, color={0,0,127}));
      connect(pLL.theta, sync.u)
        annotation (Line(points={{11,0},{28,0}}, color={0,0,127}));
      annotation (
        Diagram(graphics),
        experiment(StartTime=0, StopTime=0.1, Tolerance=1e-4),
        Documentation(info="<html>
      <p>
        This simple example provides a sinusoidal input to the PLL block and
        applies the output provided by the PLL, the calculated phase of the
        input sine, to drive a sine block so that the synchronization
        capabilities of the PLL can be visualized.
      </p>
 
      <p>
        Run the model and plot the output of the sinusoidal source and the
        output of the sine block to see how, after some short transient, the
        PLL successfully follows the reference:
      </p>
 
 
      <div class=\"figure\">
        <p><img src=\"modelica://PVSystems/Resources/Images/PLLValidationResults.png\"
                alt=\"PLLValidationResults.png\" />
        </p>
      </div>
      </html>"));
    end PLLValidation;

      