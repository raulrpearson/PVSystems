within PVSystems.Examples.Validation;
model IdealCBSwitchValidation "Ideal current bidirectional switch validation"
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
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.45, startValue=
        false) annotation (Placement(transformation(extent={{-80,0},{-60,20}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{20,-60},{40,-40}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=2) annotation (Placement(
        transformation(
        origin={0,40},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  connect(booleanStep.y, idealCBSwitch.c)
    annotation (Line(points={{-59,10},{-48,10},{-37,10}}, color={255,0,255}));
  connect(idealCBSwitch.p, resistor.n)
    annotation (Line(points={{-30,20},{-30,40},{-10,40}}, color={0,0,255}));
  connect(idealCBSwitch.n, sineVoltage.n) annotation (Line(points={{-30,0},{-30,
          -20},{30,-20},{30,0}}, color={0,0,255}));
  connect(resistor.p, sineVoltage.p)
    annotation (Line(points={{10,40},{30,40},{30,20}}, color={0,0,255}));
  connect(ground.p, sineVoltage.n)
    annotation (Line(points={{30,-40},{30,-20},{30,0}}, color={0,0,255}));
  annotation (
    Diagram(graphics),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-4),
    Documentation(info="<html>
      <p>
        IdealCBSwitchValidation presents a simple circuit to validate the
        behaviour of the corresponding component. The circuit is composed of
        a resistor in series with a sinusoidal AC voltage source and the
        ideal current bidirectional switch. The switch is operated by a step
        block that changes from 0 to 1 in the middle of the simulation. This
        changes the state of the switch from open to closed.
      </p>

      <p>
        To use the example, simulate the model as provided and plot the
        source voltage as well as the switch voltage, the plot should look
        like this:
      </p>


      <div class=\"figure\">
        <p><img src=\"modelica://PVSystems/Resources/Images/IdealCBSwitchValidationResults.png\"
                alt=\"IdealCBSwitchValidationResults.png\" />
        </p>
      </div>

      <p>
        Notice how at the begining of the simulation, when the switch is not
        closed, it blocks all the positive voltage, preventing current from
        flowing. On the other hand, the negative voltage is not blocked, so
        the current can flow (through the parallel diode). When the switch
        is closed using the firing signal, it never blocks voltage, allowing
        bidirectional flow of current.
      </p>

      <p>
        Plot the voltage drop in the result to confirm these results or play
        with the parameter values to see what effects they have.
      </p>

      </html>"));
end IdealCBSwitchValidation;
