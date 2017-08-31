within PVSystems.Examples.Verification;
model IdealCBSwitchVerification
  "Ideal current bidirectional switch verification"
  extends Modelica.Icons.Example;
  Electrical.IdealCBSwitch idealCBSwitch annotation (Placement(transformation(
        origin={-30,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz=5, V=1)
    annotation (Placement(transformation(
        origin={30,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startValue=true, startTime=
        0.5)   annotation (Placement(transformation(extent={{-70,0},{-50,20}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-10,-30},{10,-10}},rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=2) annotation (Placement(
        transformation(
        origin={0,30},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  connect(booleanStep.y, idealCBSwitch.c)
    annotation (Line(points={{-49,10},{-49,10},{-37,10}}, color={255,0,255}));
  connect(idealCBSwitch.p, resistor.n)
    annotation (Line(points={{-30,20},{-30,30},{-10,30}}, color={0,0,255}));
  connect(resistor.p, sineVoltage.p)
    annotation (Line(points={{10,30},{30,30},{30,20}}, color={0,0,255}));
  connect(idealCBSwitch.n, ground.p)
    annotation (Line(points={{-30,0},{-30,-10},{0,-10}}, color={0,0,255}));
  connect(ground.p, sineVoltage.n) annotation (Line(points={{0,-10},{16,-10},{
          30,-10},{30,0}}, color={0,0,255}));
  annotation (
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-3),
    Documentation(info="<html>
        <p>
          This example presents a circuit composed of a resistor
          in series with a sinusoidal AC voltage source and the
          ideal current bidirectional switch. The switch is
          operated by a step block that changes from 0 to 1 in the
          middle of the simulation. This changes the state of the
          switch from open to closed.
        </p>
      
        <p>
          To use the example, simulate the model as provided and
          plot the source voltage as well as the switch voltage,
          the plot should look like this:
        </p>
      
      
        <div class=\"figure\">
          <p><img src=\"modelica://PVSystems/Resources/Images/IdealCBSwitchVerificationResults.png\"
                  alt=\"IdealCBSwitchVerificationResults.png\" />
          </p>
        </div>
      
        <p>
          Notice how at the begining of the simulation, when the
          switch is not closed, it blocks all the positive
          voltage, preventing current from flowing. On the other
          hand, the negative voltage is not blocked, so the
          current can flow (through the anti-parallel diode). When
          the switch is closed using the firing signal, it never
          blocks voltage, allowing bidirectional flow of current.
        </p>
      
        <p>
          Plot the voltage drop in the resistor to confirm these
          results or play with the parameter values to see what
          effects they have.</p>
      </html>"),
    Diagram(graphics={Rectangle(extent={{-80,40},{48,-30}}, lineColor={255,255,
              255})}));
end IdealCBSwitchVerification;
