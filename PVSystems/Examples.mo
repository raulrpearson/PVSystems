within PVSystems;
package Examples "Application and validation examples"
  extends Modelica.Icons.Library;

  package Validation "Simple examples for validation of library's components"
    extends Modelica.Icons.Library;
      model PVArrayValidation "Model to validate PVArray"
        extends Modelica.Icons.Example;
        Modelica.Electrical.Analog.Sources.RampVoltage rampVoltage(duration=1,V=45,offset=-10) annotation (Placement(
            transformation(
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
      connect(Gn.y, pVArray.G) annotation (Line(points={{-29,20},{-16,20},{-16,
              13},{-5.5,13}}, color={0,0,127}));
      connect(Tn.y, pVArray.T) annotation (Line(points={{-29,-14},{-16,-14},{
              -16,7},{-5.5,7}}, color={0,0,127}));
      connect(pVArray.p, rampVoltage.p) annotation (Line(points={{1.83691e-015,
              20},{40,20}}, color={0,0,255}));
      connect(pVArray.n, rampVoltage.n) annotation (Line(points={{-1.83691e-015,
              0},{40,0}}, color={0,0,255}));
      connect(ground.p, rampVoltage.n)
        annotation (Line(points={{40,-20},{40,0}}, color={0,0,255}));
        annotation (
          Diagram(graphics),
          Documentation(
            info="<html>
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
          <p><img src=\"../Resources/Images/PVArrayValidationResults.png\"
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
          experiment(StartTime=0, StopTime=1, Tolerance=1e-4));
      end PVArrayValidation;

    model IdealCBSwitchValidation
      "Ideal current bidirectional switch validation"
      extends Modelica.Icons.Example;
      Electrical.IdealCBSwitch idealCBSwitch annotation (Placement(
            transformation(
            origin={-30,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz=5) annotation (Placement(
            transformation(
            origin={30,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.45) annotation (Placement(
            transformation(extent={{-80,0},{-60,20}}, rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
            transformation(extent={{20,-60},{40,-40}}, rotation=0)));
      Modelica.Electrical.Analog.Basic.Resistor resistor(R=2) annotation (Placement(
            transformation(
            origin={0,40},
            extent={{-10,-10},{10,10}},
            rotation=180)));
    equation
      connect(booleanStep.y, idealCBSwitch.fire) annotation (Line(points={{-59,
              10},{-48,10},{-48,10},{-37,10}}, color={255,0,255}));
      connect(idealCBSwitch.p, resistor.n) annotation (Line(points={{-30,20},{
              -30,40},{-10,40}}, color={0,0,255}));
      connect(idealCBSwitch.n, sineVoltage.n) annotation (Line(points={{-30,0},
              {-30,-20},{30,-20},{30,0}}, color={0,0,255}));
      connect(resistor.p, sineVoltage.p) annotation (Line(points={{10,40},{30,
              40},{30,20}}, color={0,0,255}));
      connect(ground.p, sineVoltage.n) annotation (Line(points={{30,-40},{30,
              -20},{30,0},{30,0}}, color={0,0,255}));
      annotation (
        Diagram(graphics),
        experiment(StartTime=0, StopTime=1, Tolerance=1e-4),
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
        <p><img src=\"../Resources/Images/IdealCBSwitchValidationResults.png\"
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

    model SignalPWMValidation "Simple model to validate SignalPWM behaviour"
      extends Modelica.Icons.Example;
      Control.SignalPWM signalPWM(period=0.01) annotation (Placement(
            transformation(extent={{20,0},{40,20}}, rotation=0)));
      Modelica.Blocks.Sources.Step step(height=0.3,offset=0.2,startTime=0.3) annotation (Placement(
            transformation(extent={{-80,20},{-60,40}}, rotation=0)));
      Modelica.Blocks.Sources.Step step1(height=0.3,startTime=0.6) annotation (Placement(
            transformation(extent={{-80,-20},{-60,0}}, rotation=0)));
      Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent=
                {{-20,0},{0,20}}, rotation=0)));
    equation
      connect(step.y, add.u1) annotation (Line(points={{-59,30},{-40,30},{-40,
              16},{-22,16}}, color={0,0,127}));
      connect(step1.y, add.u2) annotation (Line(points={{-59,-10},{-40,-10},{
              -40,4},{-22,4}}, color={0,0,127}));
      connect(add.y, signalPWM.duty)
        annotation (Line(points={{1,10},{20,10}}, color={0,0,127}));
      annotation (
        Diagram(graphics),
        experiment(StartTime=0, StopTime=1, Tolerance=1e-4),
        Documentation(info="<html>
      <p>
        SignalPWMValidation presents a very simple model aimed at validating
        the behaviour of the SignalPWM block. It provides a changing duty
        cycle with the use of two step blocks. When running the simulation
        with the provided values, plotting the fire output generates the
        following graph:
      </p>


      <div class=\"figure\">
        <p><img src=\"../Resources/Images/SignalPWMValidationResults.png\"
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
    end SignalPWMValidation;

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
        <p><img src=\"../Resources/Images/PLLValidationResults.png\"
                alt=\"PLLValidationResults.png\" />
        </p>
      </div>
      </html>"));
    end PLLValidation;

      model MPPTControllerValidation "Model to validate MPPT controller"
        extends Modelica.Icons.Example;
        Modelica.Electrical.Analog.Basic.Ground ground
          annotation (Placement(transformation(extent={{-2,-80},{18,-60}},
              rotation=0)));
        Electrical.PVArray pVArray
          annotation (Placement(transformation(
            origin={-60,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
        Modelica.Electrical.Analog.Sources.SignalVoltage sink
          annotation (Placement(transformation(
            origin={8,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
        PVSystems.Control.ControllerMPPT controller(
          vrefStep=1,
          sampleTime=1,
          pkThreshold=0.01)
          annotation (Placement(transformation(
            origin={80,4},
            extent={{-10,-10},{10,10}},
            rotation=180)));
        Modelica.Electrical.Analog.Sensors.CurrentSensor CS
          annotation (Placement(transformation(extent={{-50,30},{-30,10}},
              rotation=0)));
        Modelica.Electrical.Analog.Sensors.VoltageSensor VS
          annotation (Placement(transformation(
            origin={30,-30},
            extent={{-10,10},{10,-10}},
            rotation=270)));
        Modelica.Electrical.Analog.Sensors.PowerSensor PS
          annotation (Placement(transformation(extent={{-24,10},{-4,30}},
              rotation=0)));
        Modelica.Blocks.Sources.Ramp G(
          offset=1000,
          height=-500,
          startTime=30,
          duration=10)
          annotation (Placement(transformation(extent={{-100,20},{-80,40}},
              rotation=0)));
        Modelica.Blocks.Sources.Ramp T(
          height=-25,
          offset=273.15 + 25,
          duration=50,
          startTime=50)
          annotation (Placement(transformation(extent={{-100,-18},{-80,2}},
              rotation=0)));
        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(
            origin={46,10},
            extent={{-10,-10},{10,10}},
            rotation=180)));
        Modelica.Blocks.Sources.Ramp Perturbation(
          height=10,
          offset=0,
          duration=20,
          startTime=130)
          annotation (Placement(transformation(
            origin={80,36},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      equation
        connect(ground.p, sink.n)
          annotation (Line(points={{8,-60},{8,-30},{8,0},{8,0}}, color={0,0,255}));
        connect(pVArray.n, sink.n)
          annotation (Line(points={{-60,0},{8,0}}, color={0,0,255}));
        connect(pVArray.p, CS.p)
          annotation (Line(points={{-60,20},{-50,20}}, color={0,0,255}));
        connect(CS.i, controller.u2)
          annotation (Line(points={{-40,30},{-40,60},{100,60},{100,10},{92,10}},
            color={0,0,127}));
        connect(VS.p, sink.p)
          annotation (Line(points={{30,-20},{30,20},{8,20}}, color={0,0,255}));
        connect(VS.n, ground.p)
          annotation (Line(points={{30,-40},{30,-60},{8,-60}}, color={0,0,255}));
        connect(VS.v, controller.u1)
          annotation (Line(points={{40,-30},{100,-30},{100,-2},{92,-2}}, color=
              {0,0,127}));
        connect(CS.n, PS.pc)
          annotation (Line(points={{-30,20},{-24,20}}, color={0,0,255}));
        connect(PS.nc, sink.p)
          annotation (Line(points={{-4,20},{8,20}}, color={0,0,255}));
        connect(PS.pv, sink.p)
          annotation (Line(points={{-14,30},{8,30},{8,20}}, color={0,0,255}));
        connect(PS.nv, sink.n)
          annotation (Line(points={{-14,10},{-14,0},{8,0}}, color={0,0,255}));
        connect(G.y, pVArray.G)
          annotation (Line(points={{-79,30},{-74,30},{-74,13},{-65.5,13}},
            color={0,0,127}));
        connect(T.y, pVArray.T)
          annotation (Line(points={{-79,-8},{-74,-8},{-74,7},{-65.5,7}}, color=
              {0,0,127}));
        connect(add.u1, controller.y)
          annotation (Line(points={{58,4},{60.75,4},{60.75,4},{63.5,4},{63.5,4},
              {69,4}}, color={0,0,127}));
        connect(add.y, sink.v)
          annotation (Line(points={{35,10},{30,10},{30,10},{25,10},{25,10},{15,
              10}}, color={0,0,127}));
        connect(Perturbation.y, add.u2)
          annotation (Line(points={{69,36},{64,36},{64,16},{58,16}}, color={0,0,
              127}));
        annotation (
          Diagram(graphics),
          experiment(StopTime=180),
          Documentation(info="<html>
      <p>
        This examples places the MPPT controller closing the loop for a
        voltage source connected to a PV array. The MPPT controller senses
        the power coming out of the PV array and provides a setpoint for the
        voltage source. This changes the operation point of the PV array
        with the goal of maximizing its output power for any given solar
        irradiation and junction temperature conditions.
      </p>

      <p>
        The model is designed to challenge the control by ramping solar
        irradiation, temperature at different times and by injecting a
        perturbation into the control loop. The MPPT controller successfully
        deals with these changing conditions as shown in the following plot:
      </p>


      <div class=\"figure\">
        <p><img src=\"../Resources/Images/MPPTControllerValidationResults.png\"
      	  alt=\"MPPTControllerValidationResults.png\" />
        </p>
      </div>
      </html>"));
      end MPPTControllerValidation;

    model ParkValidation "Validation of the Park transformations"
      extends Modelica.Icons.Example;
      Control.Park park
        annotation (Placement(transformation(extent={{0,20},{20,40}}, rotation=
                0)));
      Control.InversePark inversePark
        annotation (Placement(transformation(extent={{40,20},{60,40}}, rotation=
               0)));
      Modelica.Blocks.Sources.SawTooth sawTooth(
        amplitude=2*Modelica.Constants.pi,period=0.02)
        annotation (Placement(transformation(extent={{-80,-40},{-60,-20}},
              rotation=0)));
      Modelica.Blocks.Math.Sin sin annotation (Placement(transformation(extent=
                {{-40,0},{-20,20}}, rotation=0)));
      Modelica.Blocks.Math.Cos cos annotation (Placement(transformation(extent=
                {{-40,40},{-20,60}}, rotation=0)));
    equation
      connect(park.d, inversePark.d)
        annotation (Line(points={{21,34},{38,34}}, color={0,0,127}));
      connect(park.q, inversePark.q)
        annotation (Line(points={{21,26},{38,26}}, color={0,0,127}));
      connect(cos.u, sawTooth.y) annotation (Line(points={{-42,50},{-50,50},{
              -50,-30},{-59,-30}}, color={0,0,127}));
      connect(sin.u, sawTooth.y) annotation (Line(points={{-42,10},{-50,10},{
              -50,-30},{-59,-30}}, color={0,0,127}));
      connect(cos.y, park.alpha) annotation (Line(points={{-19,50},{-10,50},{
              -10,34},{-2,34}}, color={0,0,127}));
      connect(sin.y, park.beta) annotation (Line(points={{-19,10},{-10,10},{-10,
              26},{-2,26}}, color={0,0,127}));
      connect(park.theta, sawTooth.y) annotation (Line(points={{10,18},{10,-30},
              {-59,-30}}, color={0,0,127}));
      connect(inversePark.theta, sawTooth.y) annotation (Line(points={{50,18},{
              50,-30},{-59,-30}}, color={0,0,127}));
      annotation (
        Diagram(graphics),
        experiment(startTime=0,stopTime=0.1,tolerance=1e-4),
        Documentation(info="<html>
      <p>
        This example provides some easy input for the Park transform blocks
        to check that calculations are being done as expected. Run the
        simulation and you should get something like the following figure:
      </p>

      <div class=\"figure\">
        <p><img src=\"../Resources/Images/ParkValidationResults.png\"
      	  alt=\"ParkValidationResults.png\" />
        </p>
      </div>

      <p>
        As expected, <i>d</i> is equal to the peak amplitude of the input
        signal and <i>q</i> sets at zero. Feeding the signals back to the
        inverse transformation block recreates the original signals.
      </p>
      </html>"));
    end ParkValidation;
  end Validation;

  package Application "More complete application examples"
    extends Modelica.Icons.Library;
    model BuckOpen "Ideal synchronous open-loop buck converter"
      extends Modelica.Icons.Example;
      Modelica.Electrical.Analog.Sources.ConstantVoltage src(V=5)
        annotation (Placement(transformation(
            origin={-20,-32},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor resav(R=0.4)
        annotation (Placement(transformation(
            origin={80,-42},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Inductor indav(L=1e-6)
        annotation (Placement(transformation(extent={{30,-32},{50,-12}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Capacitor capav(C=200e-6)
        annotation (Placement(transformation(
            origin={60,-42},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      PVSystems.Electrical.IdealAverageCCMSwitch idealAverageCCMSwitch
        annotation (Placement(transformation(extent={{0,-28},{20,-8}}, rotation=
               0)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch
        annotation (Placement(transformation(extent={{-10,38},{10,58}},
              rotation=0)));
      Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode
        annotation (Placement(transformation(
            origin={20,28},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Control.SignalPWM signalPWM(period=1e-5)
        annotation (Placement(transformation(extent={{-30,58},{-10,78}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Resistor ressw(R=0.4)
        annotation (Placement(transformation(
            origin={80,28},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Inductor indsw(L=1e-6)
        annotation (Placement(transformation(extent={{30,38},{50,58}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Capacitor capsw(C=200e-6)
        annotation (Placement(transformation(
            origin={60,28},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.Step iStep(
        height=0.4,
        startTime=0.01,
        offset=0.2)
        annotation (Placement(transformation(extent={{-100,-22},{-80,-2}},
              rotation=0)));
      Modelica.Blocks.Sources.Step fStep(
        height=0.1,
        offset=0,
        startTime=0.015)
        annotation (Placement(transformation(extent={{-100,20},{-80,40}},
              rotation=0)));
      Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent=
                {{-62,-2},{-42,18}}, rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground gsrc
        annotation (Placement(transformation(extent={{-30,-68},{-10,-48}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground gsw
        annotation (Placement(transformation(extent={{30,-2},{50,18}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Ground gav
        annotation (Placement(transformation(extent={{30,-72},{50,-52}},
              rotation=0)));
    equation
      connect(capav.n, gav.p)
        annotation (Line(points={{60,-52},{40,-52}}, color={0,0,255}));
      connect(resav.n, gav.p)
        annotation (Line(points={{80,-52},{40,-52}}, color={0,0,255}));
      connect(indav.n, resav.p)
        annotation (Line(points={{50,-22},{80,-22},{80,-32}}, color={0,0,255}));
      connect(capav.p, indav.n)
        annotation (Line(points={{60,-32},{60,-22},{50,-22}}, color={0,0,255}));
      connect(src.p, idealAverageCCMSwitch.p1)
        annotation (Line(points={{-20,-22},{-20,-13},{0,-13}}, color={0,0,255}));
      connect(idealAverageCCMSwitch.p2, indav.p)
        annotation (Line(points={{20,-13},{30,-13},{30,-22}}, color={0,0,255}));
      connect(idealAverageCCMSwitch.n2, gav.p)
        annotation (Line(points={{20,-23},{20,-52},{40,-52}}, color={0,0,255}));
      connect(idealAverageCCMSwitch.n1, indav.p)
        annotation (Line(points={{0,-23},{0,-42},{30,-42},{30,-22}}, color={0,0,
              255}));
      connect(signalPWM.fire,idealClosingSwitch. control)
        annotation (Line(points={{-10,73},{0,73},{0,55}}, color={255,0,255}));
      connect(idealClosingSwitch.p, src.p)
        annotation (Line(points={{-10,48},{-20,48},{-20,-22}}, color={0,0,255}));
      connect(idealClosingSwitch.n, idealDiode.n)
        annotation (Line(points={{10,48},{20,48},{20,38}}, color={0,0,255}));
      connect(indsw.n, ressw.p)
        annotation (Line(points={{50,48},{80,48},{80,38}}, color={0,0,255}));
      connect(capsw.p, indsw.n)
        annotation (Line(points={{60,38},{60,48},{50,48}}, color={0,0,255}));
      connect(indsw.p, idealDiode.n)
        annotation (Line(points={{30,48},{20,48},{20,38}}, color={0,0,255}));
      connect(fStep.y, add.u1)
        annotation (Line(points={{-79,30},{-70,30},{-70,14},{-64,14}}, color={0,
              0,127}));
      connect(iStep.y, add.u2)
        annotation (Line(points={{-79,-12},{-70,-12},{-70,2},{-64,2}}, color={0,
              0,127}));
      connect(add.y, idealAverageCCMSwitch.d)
        annotation (Line(points={{-41,8},{10,8},{10,-30}}, color={0,0,127}));
      connect(signalPWM.duty, add.y)
        annotation (Line(points={{-30,68},{-36,68},{-36,8},{-41,8}}, color={0,0,
              127}));
      connect(capsw.n, ressw.n)
        annotation (Line(points={{60,18},{80,18}}, color={0,0,255}));
      connect(idealDiode.p, gsw.p)
        annotation (Line(points={{20,18},{40,18}}, color={0,0,255}));
      connect(gsw.p, capsw.n)
        annotation (Line(points={{40,18},{60,18}}, color={0,0,255}));
      connect(gsrc.p, src.n)
        annotation (Line(points={{-20,-48},{-20,-45},{-20,-42},{-20,-42}},
            color={0,0,255}));
      annotation (
        Diagram(graphics={Text(
              extent={{20,70},{64,62}},
              lineColor={0,0,255},
              textString=
                   "Switched buck"), Text(
              extent={{18,-74},{62,-82}},
              lineColor={0,0,255},
              textString=
                   "Averaged buck")}),
        experiment(StartTime=0, StopTime=0.02, Tolerance=1e-4),
        Documentation(info="<html>
      <p>
        This compares two implementations of a buck DC-DC converter. The
        switched version is built using mostly blocks
        from <a href=\"Modelica://Modelica.Electrical.Analog\">Modelica's
          electrical library</a> but also includes
        the <a href=\"Modelica://PVSystems.Control.SignalPWM\">SignalPWM</a>
        model. The averaged version is built around the average switch model
        for CCM (continuous conduction mode).
      </p>

      <p>
        This example showcases how components from PVSystems can be mixed with
        components from the Modelica Standard Library to build systems that
        might be of interest. Additionally, it aims validating the average
        switch model performance by comparison with the more
        accurate/detailed switched model.
      </p>

      <p>
        This is still an open-loop system. A duty cycle value is fed to the
        SignalPWM block to drive the ideal closing switch or to the
        IdealAverageCCMSwitch model. The duty cycle value begins at 0.2 and
        changes to 0.6 and finally to 0.7. The effect of this change can be
        observed by plotting the output voltage:
      </p>

      <div class=\"figure\">
        <p><img src=\"../Resources/Images/BuckOpenResultsA.png\"
      	  alt=\"BuckOpenResultsA.png\" />
        </p>
      </div>

      <p>
        This figure also displays the input voltage for the sake of
        comparison. It make the point that the function of the buck
        converter is to reduce the voltage level from the input to the
        output.
      </p>

      <p>
        Additionally, one can see that the output voltage for both
        implementations is not exactly the same. The main difference can be
        found at the begining of the simulation, when the duty cycle is
        0.2. By close inspection of the inductor current one can see that
        the converters are not operating in CCM but rather are working in
        DCM (Discontinuous Conduction Mode). This condition is defined by
        the fact that the inductor current remains at 0 for a certain part
        of the switching period, as shown in the following figure:
      </p>


      <div class=\"figure\">
        <p><img src=\"../Resources/Images/BuckOpenResultsB.png\"
      	  alt=\"BuckOpenResultsB.png\" />
        </p>
      </div>

      <p>
        Since the average model used is valid only in CCM, this innaccuaricy
        is to be expected.
      </p>

      <p>
        An interesting exercise to complete this example would be to build a
        controller to close the loop and study the system's behaviour.
      </p>
      </html>"));
    end BuckOpen;

    model Inverter1phOpen
      "Basic 1-phase open-loop inverter with constant DC voltage source and no synchronization"
      extends Modelica.Icons.Example;
      PVSystems.Electrical.HBridgeSwitched HBsw
        annotation (Placement(transformation(extent={{0,40},{20,60}}, rotation=
                0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage dcsrc(V=500)
        annotation (Placement(transformation(
            origin={-60,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{-70,14},{-50,34}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Resistor ressw(R=2)
        annotation (Placement(transformation(
            origin={70,30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Inductor indsw(L=500e-6)
        annotation (Placement(transformation(
            origin={70,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.Sine duty(amplitude=0.4,offset=0.5,freqHz=50)
        annotation (Placement(transformation(extent={{-80,-60},{-60,-40}},
              rotation=0)));
      Control.SignalPWM signalPWM(period=320e-6)
        annotation (Placement(transformation(extent={{-20,0},{0,20}}, rotation=
                0)));
      PVSystems.Electrical.HBridgeAveraged HBav
        annotation (Placement(transformation(extent={{0,-40},{20,-20}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Resistor resav(R=2)
        annotation (Placement(transformation(
            origin={70,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Inductor indav(L=500e-6)
        annotation (Placement(transformation(
            origin={70,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(duty.y, signalPWM.duty)
        annotation (Line(points={{-59,-50},{-48,-50},{-48,10},{-20,10}}, color=
              {0,0,127}));
      connect(dcsrc.n, ground.p)
        annotation (Line(points={{-60,40},{-60,34}}, color={0,0,255}));
      connect(HBsw.dcn, dcsrc.n)
        annotation (Line(points={{0,45},{-26,45},{-26,40},{-60,40}}, color={0,0,
              255}));
      connect(HBsw.dcp, dcsrc.p)
        annotation (Line(points={{0,55},{-26,55},{-26,60},{-60,60}}, color={0,0,
              255}));
      connect(HBsw.acp, indsw.p)
        annotation (Line(points={{20,55},{40,55},{40,80},{70,80}}, color={0,0,
              255}));
      connect(HBsw.acn, ressw.n)
        annotation (Line(points={{20,45},{40,45},{40,20},{70,20}}, color={0,0,
              255}));
      connect(ressw.p, indsw.n)
        annotation (Line(points={{70,40},{70,60}}, color={0,0,255}));
      connect(signalPWM.fire, HBsw.fireA)
        annotation (Line(points={{0,15},{8,15},{8,40},{7,40}}, color={255,0,255}));
      connect(signalPWM.notFire, HBsw.fireB)
        annotation (Line(points={{0,5},{14,5},{14,40},{13,40}}, color={255,0,
              255}));
      connect(resav.p, indav.n)
        annotation (Line(points={{70,-40},{70,-20}}, color={0,0,255}));
      connect(HBav.acp, indav.p)
        annotation (Line(points={{20,-25},{40,-25},{40,0},{70,0}}, color={0,0,
              255}));
      connect(resav.n, HBav.acn)
        annotation (Line(points={{70,-60},{40,-60},{40,-35},{20,-35}}, color={0,
              0,255}));
      connect(HBav.d, duty.y)
        annotation (Line(points={{10,-42},{10,-50},{-59,-50}}, color={0,0,127}));
      connect(HBav.dcp, dcsrc.p)
        annotation (Line(points={{0,-25},{-32,-25},{-32,60},{-60,60}}, color={0,
              0,255}));
      connect(HBav.dcn, dcsrc.n)
        annotation (Line(points={{0,-35},{-40,-35},{-40,40},{-60,40}}, color={0,
              0,255}));
      annotation (
        Diagram(graphics={Text(
              extent={{-10,74},{28,62}},
              lineColor={0,0,255},
              textString=
                   "Switched model"), Text(
              extent={{-8,-6},{30,-18}},
              lineColor={0,0,255},
              textString=
                   "Averaged model")}),
        experiment(StartTime=0, StopTime=0.05, Tolerance=1e-4),
        Documentation(info="<html>
      <p>
        IdealInverter1phOpen presents two implementations of an open loop
        1-phase inverter. The function of the inverter is to convert DC
        voltage and current into AC voltage and current. To keep things
        simple, a constant DC source is included on the DC side and an LC
        load is included on the AC side. Typically, inverters are placed
        inside a more complicated setup, which might require MPPT (Maximum
        Power Point Tracking) on the DC side when connected to a PV array
        and AC synchronization when connected to a grid on the AC side
        instead of just a simple passive load.
      </p>

      <p>
        Nevertheless, the example still showcases an interesting
        application. Upon running the simulation with the provided values,
        plotting the resistor voltage and current and the DC source voltage
        yields the following figure:
      </p>


      <div class=\"figure\">
        <p><img src=\"../Resources/Images/Inverter1phOpenResults.png\"
      	  alt=\"Inverter1phOpenResults.png\" />
        </p>
      </div>

      <p>
        The AC is achieved with the inverter topology (called an H-bridge)
        as well as with the duty cycle sinusoidal modulation. Have a look at
        the duty cycle driving the SignalPWM block and compare it with the
        voltage drop in the resistor.
      </p>

      <p>
        Compare it with the voltage drop in the inductor. The voltage coming
        out of the inverter is actually a square wave and the inductor is
        providing some crude (but enough for some applications)
        filtering. Play around with the value of the inductor to see how it
        provides a better or worse filtering performance (decreasing or
        increasing the voltage and current ripple in the resistor, which in
        this example is assumed to be the load being fed). Since this is an
        open loop configuration, it will also change the peak value of the
        voltage drop in the resistor, as well as its phase.
      </p>

      <p>
        Importantly, see how the the average model provides a very good
        approximation for low frequencies. This kind of model won't be
        useful to study ripples and to evaluate the performance of different
        PWM modulations (sinusoidal modulation is being used in this
        example) or of different filter configurations, since those are
        concerned with the high frequencies in the system. On the other
        hand, the average models will be very useful to study controllers
        and to perform longer simulations since the simulation step doesn't
        need to be so small as to accurately represent the switching
        dynamics.
      </p>
      </html>"));
    end Inverter1phOpen;

    model Inverter1phOpenSynch
      "Grid synchronized 1-phase open-loop inverter fed by constant DC source"
      extends Modelica.Icons.Example;
      PVSystems.Electrical.HBridgeSwitched HBsw
        annotation (Placement(transformation(extent={{-60,80},{-40,100}},
              rotation=0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage DCsrc(V=580)
        annotation (Placement(transformation(
            origin={-90,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Sources.SineVoltage Grid(freqHz=50, V=480)
        annotation (Placement(transformation(
            origin={90,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Inductor Lsw1(L=500e-6)
        annotation (Placement(transformation(
            origin={90,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Control.PLL pLL
        annotation (Placement(transformation(
            origin={-74,-60},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Electrical.Analog.Sensors.VoltageSensor VSac
        annotation (Placement(transformation(
            origin={70,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Control.SignalPWM signalPWM(period=320e-6)
        annotation (Placement(transformation(
            origin={-50,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Math.Cos sin
        annotation (Placement(transformation(
            origin={-44,-60},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Blocks.Math.Add add(k2=1, k1=580/580/2)
        annotation (Placement(transformation(
            origin={-10,-54},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Blocks.Sources.Constant const(k=0.5)
        annotation (Placement(transformation(
            origin={-70,-30},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Electrical.Analog.Basic.Ground gsrc
        annotation (Placement(transformation(extent={{-100,12},{-80,32}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Resistor Rsw1(R=0.1)
        annotation (Placement(transformation(
            origin={90,40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      PVSystems.Electrical.HBridgeAveraged HBav
        annotation (Placement(transformation(extent={{0,48},{20,68}}, rotation=
                0)));
      Modelica.Electrical.Analog.Basic.Inductor Lav1(L=500e-6)
        annotation (Placement(transformation(
            origin={50,38},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor Rav1(R=0.1)
        annotation (Placement(transformation(
            origin={50,8},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground gsw
        annotation (Placement(transformation(extent={{-80,62},{-60,82}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground gav
        annotation (Placement(transformation(extent={{-20,28},{0,48}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Inductor Lsw2(L=500e-6)
        annotation (Placement(transformation(
            origin={-28,40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor Rsw2(R=0.1)
        annotation (Placement(transformation(
            origin={-28,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Inductor Lav2(L=500e-6)
        annotation (Placement(transformation(
            origin={28,22},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor Rav2(R=0.1)
        annotation (Placement(transformation(
            origin={28,-8},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(HBsw.acp, Lsw1.p)
        annotation (Line(points={{-40,95},{90,95},{90,80}}, color={0,0,255}));
      connect(Lsw1.n, Rsw1.p)
        annotation (Line(points={{90,60},{90,50}}, color={0,0,255}));
      connect(Rsw1.n, Grid.p)
        annotation (Line(points={{90,30},{90,-20}}, color={0,0,255}));
      connect(Grid.p, VSac.p)
        annotation (Line(points={{90,-20},{70,-20}}, color={0,0,255}));
      connect(Grid.n, VSac.n)
        annotation (Line(points={{90,-40},{70,-40}}, color={0,0,255}));
      connect(Lav1.n, Rav1.p)
        annotation (Line(points={{50,28},{50,18}}, color={0,0,255}));
      connect(HBav.acp, Lav1.p)
        annotation (Line(points={{20,63},{50,63},{50,48}}, color={0,0,255}));
      connect(DCsrc.p, HBsw.dcp)
        annotation (Line(points={{-90,60},{-90,95},{-60,95}}, color={0,0,255}));
      connect(HBav.dcp, DCsrc.p)
        annotation (Line(points={{0,63},{-90,63},{-90,60}}, color={0,0,255}));
      connect(gsrc.p, DCsrc.n)
        annotation (Line(points={{-90,32},{-90,40}}, color={0,0,255}));
      connect(gsw.p, HBsw.dcn)
        annotation (Line(points={{-70,82},{-70,85},{-60,85}}, color={0,0,255}));
      connect(pLL.theta, sin.u)
        annotation (Line(points={{-63,-60},{-56,-60}}, color={0,0,127}));
      connect(const.y, add.u2)
        annotation (Line(points={{-59,-30},{-30,-30},{-30,-48},{-22,-48}},
            color={0,0,127}));
      connect(HBav.dcn, gav.p)
        annotation (Line(points={{0,53},{-10,53},{-10,48}}, color={0,0,255}));
      connect(sin.y, add.u1)
        annotation (Line(points={{-33,-60},{-22,-60}}, color={0,0,127}));
      connect(signalPWM.duty, add.y)
        annotation (Line(points={{-50,20},{-50,-10},{10,-10},{10,-54},{1,-54}},
            color={0,0,127}));
      connect(HBav.d, add.y)
        annotation (Line(points={{10,46},{10,-54},{1,-54}}, color={0,0,127}));
      connect(Rav1.n, VSac.p)
        annotation (Line(points={{50,-2},{50,-20},{70,-20}}, color={0,0,255}));
      connect(VSac.v, pLL.v)
        annotation (Line(points={{60,-30},{50,-30},{50,-90},{-94,-90},{-94,-60},
              {-86,-60}}, color={0,0,127}));
      connect(signalPWM.fire, HBsw.fireA) annotation (Line(points={{-55,40},{
              -54,40},{-54,80},{-53,80}}, color={255,0,255}));
      connect(signalPWM.notFire, HBsw.fireB) annotation (Line(points={{-45,40},
              {-47,40},{-47,80}}, color={255,0,255}));
      connect(Lsw2.n, Rsw2.p)
        annotation (Line(points={{-28,30},{-28,27.5},{-28,27.5},{-28,25},{-28,
              20},{-28,20}}, color={0,0,255}));
      connect(HBsw.acn, Lsw2.p)   annotation (Line(points={{-40,85},{-28,85},{
              -28,50}}, color={0,0,255}));
      connect(Rsw2.n, VSac.n)   annotation (Line(points={{-28,0},{-28,-40},{70,
              -40}}, color={0,0,255}));
      connect(Lav2.n, Rav2.p)
        annotation (Line(points={{28,12},{28,9.5},{28,9.5},{28,7},{28,2},{28,2}},
            color={0,0,255}));
      connect(HBav.acn, Lav2.p)   annotation (Line(points={{20,53},{28,53},{28,
              32}}, color={0,0,255}));
      connect(Rav2.n, VSac.n)   annotation (Line(points={{28,-18},{28,-40},{70,
              -40}}, color={0,0,255}));
      annotation (
        Diagram(graphics),
        experiment(StartTime=0, StopTime=0.1, Tolerance=1e-4),
        Documentation(info="<html>
      <p>
        This example goes a step further
        than <a href=\"Modelica://PVSystems.Examples.Application.Inverter1phOpen\">Inverter1phOpen</a>
        and includes grid synchronization. Typically this is the condition
        for inverters in real-life situations. Both switched and averaged
        implementations are presented for comparison purposes and it can be
        seen that they both provide very similar results (excluding the fact
        that high frequencies are left out in the averaged model).
      </p>


      <div class=\"figure\">
        <p><img src=\"../Resources/Images/Inverter1phOpenSynchResults.png\"
      	  alt=\"Inverter1phOpenSynchResults.png\" />
        </p>
      </div>

      <p>
        Since this is still open-loop and there's no in-quadrature
        separation, the value of the current can't comfortably be specified
        to be of a certain value. Since the RL load has almost equal real
        and imaginary parts, the current that is drawn from the inverter has
        a power factor different than one.
      </p>

      <p>
        A key value to pay attention to in this example is the gain that is
        placed in the <i>Add</i> block.
      </p>


      <div class=\"figure\">
        <p><img src=\"../Resources/Images/Inverter1phOpenSynchDialog.png\"
      	  alt=\"Inverter1phOpenSynchDialog.png\" />
        </p>
      </div>

      <p>
        It's initially set at 0.5. The value is expressed as 580/580/2 to
        highlight the fact that this gain should be normalized to the DC
        voltage value. Above that, over-modulation will occur and the output
        current of the inverter will become quite ugly. Play around with
        this value (using values between 0 and 0.5) to see how the output
        current of the inverter changes.
      </p>
      </html>"));
    end Inverter1phOpenSynch;

    model Inverter1phClosed
      "Basic 1-phase closed-loop inverter with constant DC voltage source and no synchronization"
      extends Modelica.Icons.Example;
      Modelica.Electrical.Analog.Sources.ConstantVoltage dcsrc(V=500)
        annotation (Placement(transformation(
            origin={-20,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{-30,34},{-10,54}},
              rotation=0)));
      PVSystems.Electrical.HBridgeAveraged HBav
        annotation (Placement(transformation(extent={{20,60},{40,80}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Resistor resav(R=0.1)
        annotation (Placement(transformation(
            origin={90,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Inductor indav(L=500e-6)
        annotation (Placement(transformation(
            origin={90,90},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.Step iqSetpoint(
        height=14.14,
        startTime=0.2)
        annotation (Placement(transformation(extent={{0,-30},{20,-10}},
              rotation=0)));
      Modelica.Blocks.Sources.Step idSetpoint(
        offset=20,
        startTime=0.2,
        height=14.14 - 20)
        annotation (Placement(transformation(extent={{0,-64},{20,-44}},
              rotation=0)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor CSac
        annotation (Placement(transformation(
            origin={60,40},
            extent={{-10,10},{10,-10}},
            rotation=180)));
      Modelica.Blocks.Sources.SawTooth sawTooth(
        amplitude=2*Modelica.Constants.pi,period=0.02)
        annotation (Placement(transformation(extent={{-92,-4},{-72,16}},
              rotation=0)));
      Modelica.Blocks.Math.Cos cos annotation (Placement(transformation(extent=
                {{-50,-100},{-30,-80}}, rotation=0)));
      Modelica.Blocks.Math.Gain gain(k=50) annotation (Placement(transformation(
              extent={{-20,-100},{0,-80}}, rotation=0)));
      Control.ControllerInverter1phCurrent control
        annotation (Placement(transformation(
            origin={30,10},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Electrical.Analog.Sensors.VoltageSensor VSdc
        annotation (Placement(transformation(
            origin={-50,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(dcsrc.n, ground.p)
        annotation (Line(points={{-20,60},{-20,57},{-20,57},{-20,54}}, color={0,
              0,255}));
      connect(resav.p, indav.n)
        annotation (Line(points={{90,60},{90,80}}, color={0,0,255}));
      connect(HBav.dcp, dcsrc.p)
        annotation (Line(points={{20,75},{0,75},{0,80},{-20,80}}, color={0,0,
              255}));
      connect(HBav.dcn, dcsrc.n)
        annotation (Line(points={{20,65},{0,65},{0,60},{-20,60}}, color={0,0,
              255}));
      connect(CSac.p, resav.n)
        annotation (Line(points={{70,40},{90,40}}, color={0,0,255}));
      connect(HBav.acn, CSac.n) annotation (Line(points={{40,65},{46,65},{46,40},
              {50,40}}, color={0,0,255}));
      connect(HBav.acp, indav.p) annotation (Line(points={{40,75},{46,75},{46,
              100},{90,100}}, color={0,0,255}));
      connect(cos.u, sawTooth.y) annotation (Line(points={{-52,-90},{-60,-90},{
              -60,6},{-71,6}}, color={0,0,127}));
      connect(cos.y, gain.u) annotation (Line(points={{-29,-90},{-22,-90}},
            color={0,0,127}));
      connect(control.d, HBav.d)
        annotation (Line(points={{30,21},{30,58}}, color={0,0,127}));
      connect(CSac.i, control.i) annotation (Line(points={{60,30},{60,-20},{30,
              -20},{30,-2}}, color={0,0,127}));
      connect(iqSetpoint.y, control.iqSetpoint) annotation (Line(points={{21,
              -20},{24,-20},{24,-2}}, color={0,0,127}));
      connect(idSetpoint.y, control.idSetpoint) annotation (Line(points={{21,
              -54},{36,-54},{36,-2}}, color={0,0,127}));
      connect(control.theta, sawTooth.y) annotation (Line(points={{18,6},{-26.5,
              6},{-26.5,6},{-71,6}}, color={0,0,127}));
      connect(VSdc.p, dcsrc.p)
        annotation (Line(points={{-50,80},{-20,80}}, color={0,0,255}));
      connect(VSdc.n, dcsrc.n)
        annotation (Line(points={{-50,60},{-20,60}}, color={0,0,255}));
      connect(VSdc.v, control.udc) annotation (Line(points={{-60,70},{-66,70},{
              -66,14},{18,14}}, color={0,0,127}));
      annotation (
        Diagram(graphics),
        experiment(StartTime=0, StopTime=0.4, Tolerance=1e-4),
        Documentation(info="<html>
      <p>
        This example explores a closed-loop inverter. No grid is present,
        which simplifies things. But, since the controller is implemented in
        the synchronous (dq) refrecen frame, a synchronization source needs
        to exist. This is implemented with the saw tooth generator, which
        emulates the output of the PLL.
      </p>

      <p>
        As can be seen in the following figure, one can now comfortably
        specify the setpoint for the output current of the inverter:
      </p>

      <div class=\"figure\">
        <p><img src=\"../Resources/Images/Inverter1phClosedResults.png\"
      	  alt=\"Inverter1phClosedResults.png\" />
        </p>
      </div>

      <p>
        Having the posibility to separately control the current in each dq
        axis enables one to control the power factor (i.e. the phase lag
        between the voltage and the current) as well as the amplitude of the
        current.
      </p>

      <p>
        In this example, the equivalent synchronization signal is plotted to
        see this phase shift as the setpoints change. Notice how, when the q
        component of the current is 0, the d component is equal to the peak
        current.
      </p>
      </html>"));
    end Inverter1phClosed;

    model Inverter1phClosedSynch
      "Grid synchronized 1-phase closed-loop inverter fed by constant DC source"
      extends Modelica.Icons.Example;
      extends Modelica.Icons.UnderConstruction;
      Modelica.Electrical.Analog.Sources.ConstantVoltage DCsrc(V=580)
        annotation (Placement(transformation(
            origin={-80,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Sources.SineVoltage Grid(freqHz=50, V=480)
        annotation (Placement(transformation(
            origin={56,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Control.PLL pll
        annotation (Placement(transformation(extent={{60,-4},{40,16}}, rotation=
               0)));
      Modelica.Electrical.Analog.Sensors.VoltageSensor VSac
        annotation (Placement(transformation(
            origin={80,70},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      PVSystems.Electrical.HBridgeAveraged HB(d(start=0.5))
        annotation (Placement(transformation(extent={{-60,60},{-40,80}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Inductor L1(L=500e-6)
        annotation (Placement(transformation(extent={{10,80},{30,100}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Resistor R1(R=0.1)
        annotation (Placement(transformation(extent={{36,80},{56,100}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Inductor L2(L=500e-6)
        annotation (Placement(transformation(
            origin={20,50},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Electrical.Analog.Basic.Resistor R2(R=0.1)
        annotation (Placement(transformation(
            origin={46,50},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{0,40},{-20,60}}, rotation=
               0)));
      Control.ControllerInverter1phCurrent control(d(start=0.5))
        annotation (Placement(transformation(
            origin={-50,10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.Analog.Sensors.VoltageSensor VSdc(v(start=DCsrc.V))
        annotation (Placement(transformation(
            origin={-108,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.Step iqSetpoint(height=14.14,startTime=0.2)
        annotation (Placement(transformation(extent={{-100,-80},{-80,-60}},
              rotation=0)));
      Modelica.Blocks.Sources.Step idSetpoint(
        offset=20,
        startTime=0.2,
        height=14.14 - 20)
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}},
              rotation=0)));
    equation
      connect(Grid.p, VSac.p)
        annotation (Line(points={{56,80},{80,80}}, color={0,0,255}));
      connect(Grid.n, VSac.n)
        annotation (Line(points={{56,60},{80,60}}, color={0,0,255}));
      connect(L1.n, R1.p)
        annotation (Line(points={{30,90},{36,90}}, color={0,0,255}));
      connect(R2.n, L2.p)
        annotation (Line(points={{36,50},{30,50}}, color={0,0,255}));
      connect(HB.acp, L1.p) annotation (Line(points={{-40,75},{-34,75},{-34,90},
              {10,90}}, color={0,0,255}));
      connect(R1.n, Grid.p)
        annotation (Line(points={{56,90},{56,80}}, color={0,0,255}));
      connect(Grid.n, R2.p)
        annotation (Line(points={{56,60},{56,50}}, color={0,0,255}));
      connect(DCsrc.p, HB.dcp) annotation (Line(points={{-80,80},{-64,80},{-64,
              75},{-60,75}}, color={0,0,255}));
      connect(DCsrc.n, HB.dcn) annotation (Line(points={{-80,60},{-64,60},{-64,
              65},{-60,65}}, color={0,0,255}));
      connect(currentSensor.p, L2.n)
        annotation (Line(points={{0,50},{10,50}}, color={0,0,255}));
      connect(HB.acn, currentSensor.n) annotation (Line(points={{-40,65},{-34,
              65},{-34,50},{-20,50}}, color={0,0,255}));
      connect(pll.v, VSac.v) annotation (Line(points={{62,6},{100,6},{100,70},{
              90,70}}, color={0,0,127}));
      connect(VSdc.p, DCsrc.p) annotation (Line(points={{-108,80},{-80,80}},
            color={0,0,255}));
      connect(VSdc.n, DCsrc.n) annotation (Line(points={{-108,60},{-80,60}},
            color={0,0,255}));
      connect(control.d, HB.d) annotation (Line(points={{-50,21},{-50,58}},
            color={0,0,127}));
      connect(VSdc.v, control.udc) annotation (Line(points={{-118,70},{-126,70},
              {-126,30},{-30,30},{-30,14},{-38,14}}, color={0,0,127}));
      connect(pll.theta, control.theta) annotation (Line(points={{39,6},{0.5,6},
              {0.5,6},{-38,6}}, color={0,0,127}));
      connect(currentSensor.i, control.i) annotation (Line(points={{-10,40},{
              -10,-20},{-50,-20},{-50,-2}}, color={0,0,127}));
      connect(iqSetpoint.y, control.iqSetpoint) annotation (Line(points={{-79,
              -70},{-44,-70},{-44,-2}}, color={0,0,127}));
      connect(idSetpoint.y, control.idSetpoint) annotation (Line(points={{-79,
              -30},{-56,-30},{-56,-2}}, color={0,0,127}));
      annotation (
        Diagram(graphics),
        experiment(StartTime=0, StopTime=0.1, Tolerance=1e-4));
    end Inverter1phClosedSynch;

    model PVInverter1ph
      "Simple PV system including PV array, inverter and no grid"
      extends Modelica.Icons.Example;
      extends Modelica.Icons.UnderConstruction;
      Electrical.PVArray PV(          v(start=450))
        annotation (Placement(transformation(
            origin={-110,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.Constant Gn(k=1000) annotation (Placement(
            transformation(extent={{-148,80},{-128,100}}, rotation=0)));
      Modelica.Blocks.Sources.Constant Tn(k=298.15) annotation (Placement(
            transformation(extent={{-148,40},{-128,60}}, rotation=0)));
      PVSystems.Electrical.HBridgeAveraged Inverter annotation (Placement(
            transformation(extent={{0,60},{20,80}}, rotation=0)));
      Modelica.Electrical.Analog.Basic.Inductor L(L=500e-6)
        annotation (Placement(transformation(
            origin={90,66},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor R(R=10)
        annotation (Placement(transformation(
            origin={90,30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Capacitor C(C=5e-3, v(start=32.8))
        annotation (Placement(transformation(
            origin={-20,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Sensors.VoltageSensor VSdc
        annotation (Placement(transformation(
            origin={-52,-70},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor CSdc
        annotation (Placement(transformation(extent={{-52,70},{-32,90}},
              rotation=0)));
      Modelica.Electrical.Analog.Sensors.PowerSensor PSac
        annotation (Placement(transformation(extent={{60,80},{80,100}},
              rotation=0)));
      Modelica.Electrical.Analog.Sensors.PowerSensor PSdc
        annotation (Placement(transformation(extent={{-102,70},{-82,90}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Resistor resistor(R=1e-3, v(start=30))
        annotation (Placement(transformation(extent={{-76,70},{-56,90}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{-62,-108},{-42,-88}},
              rotation=0)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{30,80},{50,100}},
              rotation=0)));
      Modelica.Blocks.Sources.Sine sine(freqHz=50)
        annotation (Placement(transformation(extent={{-20,-100},{0,-80}},
              rotation=0)));
      Modelica.Blocks.Nonlinear.Limiter limiter(uMin=0)
        annotation (Placement(transformation(
            origin={10,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Math.Add add(k1=0.5)
        annotation (Placement(transformation(
            origin={16,-10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant const(k=0.5)
        annotation (Placement(transformation(extent={{-80,-40},{-60,-20}},
              rotation=0)));
      PVSystems.Control.ControllerInverter1ph onePhaseInverterController
        annotation (Placement(transformation(
            origin={10,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
    equation
      connect(Gn.y, PV.G) annotation (Line(points={{-127,90},{-122,90},{-122,73},
              {-115.5,73}}, color={0,0,127}));
      connect(Tn.y, PV.T) annotation (Line(points={{-127,50},{-122,50},{-122,67},
              {-115.5,67}}, color={0,0,127}));
      connect(C.p, Inverter.dcp)         annotation (Line(points={{-20,80},{-6,
              80},{-6,75},{0,75}}, color={0,0,255}));
      connect(PV.n, VSdc.n) annotation (Line(points={{-110,60},{-110,-80},{-52,
              -80}}, color={0,0,255}));
      connect(VSdc.n, C.n)         annotation (Line(points={{-52,-80},{-20,-80},
              {-20,60}}, color={0,0,255}));
      connect(CSdc.n, C.p)
        annotation (Line(points={{-32,80},{-20,80}}, color={0,0,255}));
      connect(VSdc.p, CSdc.p)
        annotation (Line(points={{-52,-60},{-52,80}}, color={0,0,255}));
      connect(L.n, R.p)
        annotation (Line(points={{90,56},{90,40}}, color={0,0,255}));
      connect(PSdc.pv, PV.p) annotation (Line(points={{-92,90},{-110,90},{-110,
              80}}, color={0,0,255}));
      connect(PSdc.nv, VSdc.n) annotation (Line(points={{-92,70},{-92,-80},{-52,
              -80}}, color={0,0,255}));
      connect(PSac.nc, L.p) annotation (Line(points={{80,90},{90,90},{90,76}},
            color={0,0,255}));
      connect(PSac.pv, PSac.pc) annotation (Line(points={{70,100},{60,100},{60,
              90}}, color={0,0,255}));
      connect(resistor.n, CSdc.p) annotation (Line(points={{-56,80},{-52,80}},
            color={0,0,255}));
      connect(PV.p, PSdc.pc) annotation (Line(points={{-110,80},{-102,80}},
            color={0,0,255}));
      connect(PSdc.nc, resistor.p) annotation (Line(points={{-82,80},{-76,80}},
            color={0,0,255}));
      connect(C.n, Inverter.dcn)         annotation (Line(points={{-20,60},{-6,
              60},{-6,65},{0,65}}, color={0,0,255}));
      connect(ground.p, VSdc.n) annotation (Line(points={{-52,-88},{-52,-80}},
            color={0,0,255}));
      connect(Inverter.acn, R.n) annotation (Line(points={{20,65},{50,65},{50,
              20},{90,20}}, color={0,0,255}));
      connect(PSac.nv, R.n) annotation (Line(points={{70,80},{70,20},{90,20}},
            color={0,0,255}));
      connect(currentSensor.n, PSac.pc)
        annotation (Line(points={{50,90},{60,90}}, color={0,0,255}));
      connect(Inverter.acp, currentSensor.p) annotation (Line(points={{20,75},{
              26,75},{26,90},{30,90}}, color={0,0,255}));
      connect(limiter.y, Inverter.d) annotation (Line(points={{10,41},{10,58}},
            color={0,0,127}));
      connect(const.y, add.u2) annotation (Line(points={{-59,-30},{22,-30},{22,
              -22}}, color={0,0,127}));
      connect(add.y, limiter.u) annotation (Line(points={{16,1},{16,10},{10,10},
              {10,18}}, color={0,0,127}));
      connect(onePhaseInverterController.d, add.u1) annotation (Line(points={{
              10,-39},{10,-22}}, color={0,0,127}));
      connect(sine.y, onePhaseInverterController.vac) annotation (Line(points={
              {1,-90},{14,-90},{14,-62},{13,-62}}, color={0,0,127}));
      connect(currentSensor.i, onePhaseInverterController.iac) annotation (Line(
            points={{40,80},{40,-90},{18,-90},{18,-62}}, color={0,0,127}));
      connect(VSdc.v, onePhaseInverterController.vdc) annotation (Line(points={
              {-42,-70},{2,-70},{2,-62}}, color={0,0,127}));
      connect(CSdc.i, onePhaseInverterController.idc) annotation (Line(points={
              {-42,70},{-36,70},{-36,-76},{7,-76},{7,-62}}, color={0,0,127}));
      annotation (Diagram(graphics));
    end PVInverter1ph;

    model PVInverter1phSynch
      "Simple PV system including PV array, inverter and grid"
      extends Modelica.Icons.Example;
      extends Modelica.Icons.UnderConstruction;
      Electrical.PVArray PV(          v(start=450))
        annotation (Placement(transformation(
            origin={-110,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.Constant Gn(k=1000) annotation (Placement(
            transformation(extent={{-148,80},{-128,100}}, rotation=0)));
      Modelica.Blocks.Sources.Constant Tn(k=298.15) annotation (Placement(
            transformation(extent={{-148,40},{-128,60}}, rotation=0)));
      PVSystems.Electrical.HBridgeAveraged Inverter annotation (Placement(
            transformation(extent={{-10,60},{10,80}}, rotation=0)));
      Modelica.Electrical.Analog.Sources.SineVoltage Grid(freqHz=50, V=25)
        annotation (Placement(transformation(
            origin={90,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Inductor L(L=500e-6)
        annotation (Placement(transformation(
            origin={90,66},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor R(R=10e-3)
        annotation (Placement(transformation(
            origin={90,30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Sensors.VoltageSensor VSac
        annotation (Placement(transformation(
            origin={60,-10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Capacitor C(C=5e-3, v(start=32.8))
        annotation (Placement(transformation(
            origin={-26,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      PVSystems.Control.ControllerInverter1ph Controller
        annotation (Placement(transformation(
            origin={0,28},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Electrical.Analog.Sensors.VoltageSensor VSdc
        annotation (Placement(transformation(
            origin={-52,-10},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor CSdc
        annotation (Placement(transformation(extent={{-52,70},{-32,90}},
              rotation=0)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor CSac
        annotation (Placement(transformation(extent={{30,80},{50,100}},
              rotation=0)));
      Modelica.Electrical.Analog.Sensors.PowerSensor PSac
        annotation (Placement(transformation(extent={{60,80},{80,100}},
              rotation=0)));
      Modelica.Electrical.Analog.Sensors.PowerSensor PSdc
        annotation (Placement(transformation(extent={{-102,70},{-82,90}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Inductor L1(
                                                  L=500e-6)
        annotation (Placement(transformation(
            origin={26,42},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor R1(
                                                  R=10e-3)
        annotation (Placement(transformation(
            origin={26,6},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor resistor(R=1e-3, v(start=30))
        annotation (Placement(transformation(extent={{-76,70},{-56,90}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{-62,-48},{-42,-28}},
              rotation=0)));
    equation
      connect(Gn.y, PV.G) annotation (Line(points={{-127,90},{-122,90},{-122,73},
              {-115.5,73}}, color={0,0,127}));
      connect(Tn.y, PV.T) annotation (Line(points={{-127,50},{-122,50},{-122,67},
              {-115.5,67}}, color={0,0,127}));
      connect(C.p, Inverter.dcp)         annotation (Line(points={{-26,80},{-16,
              80},{-16,75},{-10,75}}, color={0,0,255}));
      connect(Controller.d, Inverter.d) annotation (Line(points={{-6.73533e-016,
              39},{-6.73533e-016,58},{0,58}}, color={0,0,127}));
      connect(PV.n, VSdc.n) annotation (Line(points={{-110,60},{-110,-20},{-52,
              -20}}, color={0,0,255}));
      connect(VSdc.n, C.n)         annotation (Line(points={{-52,-20},{-26,-20},
              {-26,60}}, color={0,0,255}));
      connect(VSdc.v, Controller.vdc) annotation (Line(points={{-42,-10},{-8,
              -10},{-8,16}}, color={0,0,127}));
      connect(CSdc.n, C.p)
        annotation (Line(points={{-32,80},{-26,80}}, color={0,0,255}));
      connect(CSdc.i, Controller.idc) annotation (Line(points={{-42,70},{-42,6},
              {-3,6},{-3,16}}, color={0,0,127}));
      connect(VSdc.p, CSdc.p)
        annotation (Line(points={{-52,0},{-52,80}}, color={0,0,255}));
      connect(VSac.n, Grid.n)
        annotation (Line(points={{60,-20},{90,-20}}, color={0,0,255}));
      connect(VSac.p, Grid.p)
        annotation (Line(points={{60,0},{90,0}}, color={0,0,255}));
      connect(Controller.vac, VSac.v) annotation (Line(points={{3,16},{4,16},{4,
              -10},{50,-10}}, color={0,0,127}));
      connect(R.n, Grid.p)
        annotation (Line(points={{90,20},{90,0}}, color={0,0,255}));
      connect(L.n, R.p)
        annotation (Line(points={{90,56},{90,40}}, color={0,0,255}));
      connect(Inverter.acp, CSac.p) annotation (Line(points={{10,75},{26,75},{
              26,90},{30,90}}, color={0,0,255}));
      connect(CSac.i, Controller.iac) annotation (Line(points={{40,80},{40,6},{
              8,6},{8,16}}, color={0,0,127}));
      connect(PSdc.pv, PV.p) annotation (Line(points={{-92,90},{-110,90},{-110,
              80}}, color={0,0,255}));
      connect(PSdc.nv, VSdc.n) annotation (Line(points={{-92,70},{-92,-20},{-52,
              -20}}, color={0,0,255}));
      connect(PSac.pc, CSac.n)
        annotation (Line(points={{60,90},{50,90}}, color={0,0,255}));
      connect(PSac.nc, L.p) annotation (Line(points={{80,90},{90,90},{90,76}},
            color={0,0,255}));
      connect(PSac.pv, PSac.pc) annotation (Line(points={{70,100},{60,100},{60,
              90}}, color={0,0,255}));
      connect(PSac.nv, VSac.n) annotation (Line(points={{70,80},{70,-20},{60,
              -20}}, color={0,0,255}));
      connect(L1.n, R1.p)
        annotation (Line(points={{26,32},{26,28},{26,28},{26,24},{26,16},{26,16}},
            color={0,0,255}));
      connect(Inverter.acn, L1.p) annotation (Line(points={{10,65},{26,65},{26,
              52}}, color={0,0,255}));
      connect(R1.n, VSac.n) annotation (Line(points={{26,-4},{26,-20},{60,-20}},
            color={0,0,255}));
      connect(resistor.n, CSdc.p) annotation (Line(points={{-56,80},{-52,80}},
            color={0,0,255}));
      connect(PV.p, PSdc.pc) annotation (Line(points={{-110,80},{-102,80}},
            color={0,0,255}));
      connect(PSdc.nc, resistor.p) annotation (Line(points={{-82,80},{-76,80}},
            color={0,0,255}));
      connect(C.n, Inverter.dcn)         annotation (Line(points={{-26,60},{-16,
              60},{-16,65},{-10,65}}, color={0,0,255}));
      connect(ground.p, VSdc.n) annotation (Line(points={{-52,-28},{-52,-20}},
            color={0,0,255}));
      annotation (Diagram(graphics),
                           Icon(graphics));
    end PVInverter1phSynch;

  end Application;
end Examples;