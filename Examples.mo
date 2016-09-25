package Examples "Application and validation examples" 
  extends Modelica.Icons.Library;
  
  
  
  
  
  
  
  
  
  
  
  package Validation "Simple examples for validation of library's components" 
    extends Modelica.Icons.Library;
      model PVArrayValidation "Model to validate PVArray" 
        extends Modelica.Icons.Example;
        Modelica.Electrical.Analog.Sources.RampVoltage rampVoltage(duration=1,V=45,offset=-10) annotation(extent=[30,0; 50,20],rotation=270);
        Modelica.Electrical.Analog.Basic.Ground ground annotation(extent=[30,-40;50,-20]);
        Electrical.PVArray pVArray annotation(extent=[-10,0;10,20],rotation=270);
        Modelica.Blocks.Sources.Constant Gn(k=1000) annotation(extent=[-50,10;-30,30]);
        Modelica.Blocks.Sources.Constant Tn(k=298.15) annotation(extent=[-50,-24;-30,-4]);
        annotation (
          Diagram,
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
      equation 
      connect(Gn.y, pVArray.G) annotation (points=[-29,20; -16,20; -16,13; -5.5,
            13], style(color=74, rgbcolor={0,0,127}));
      connect(Tn.y, pVArray.T) annotation (points=[-29,-14; -16,-14; -16,7; 
            -5.5,7],
                style(color=74, rgbcolor={0,0,127}));
      connect(pVArray.p, rampVoltage.p) annotation (points=[1.83691e-015,20; 40,
            20], style(color=3, rgbcolor={0,0,255}));
      connect(pVArray.n, rampVoltage.n) annotation (points=[-1.83691e-015,0; 40,
            0],
          style(color=3, rgbcolor={0,0,255}));
      connect(ground.p, rampVoltage.n) 
        annotation (points=[40,-20; 40,0], style(color=3, rgbcolor={0,0,255}));
      end PVArrayValidation;

    model IdealCBSwitchValidation 
      "Ideal current bidirectional switch validation" 
      extends Modelica.Icons.Example;
      Electrical.IdealCBSwitch idealCBSwitch annotation(extent=[-40,0;-20,20],rotation=270);
      Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz=5) annotation(extent=[20,0;40,20],rotation=270);
      Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.45) annotation(extent=[-80,0;-60,20]);
      Modelica.Electrical.Analog.Basic.Ground ground annotation(extent=[20,-60;40,-40]);
      Modelica.Electrical.Analog.Basic.Resistor resistor(R=2) annotation(extent=[-10,30;10,50],rotation=180);
      annotation (
        Diagram,
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
    equation 
      connect(booleanStep.y, idealCBSwitch.fire) annotation (points=[-59,10; 
            -48,10; -48,10; -37,10],
                                 style(color=5, rgbcolor={255,0,255}));
      connect(idealCBSwitch.p, resistor.n) annotation (points=[-30,20; -30,40; 
            -10,40], style(color=3, rgbcolor={0,0,255}));
      connect(idealCBSwitch.n, sineVoltage.n) annotation (points=[-30,0; -30,
            -20; 30,-20; 30,0],
                           style(color=3, rgbcolor={0,0,255}));
      connect(resistor.p, sineVoltage.p) annotation (points=[10,40; 30,40; 30,
            20],
          style(color=3, rgbcolor={0,0,255}));
      connect(ground.p, sineVoltage.n) annotation (points=[30,-40; 30,-20; 30,0; 
            30,0], style(color=3, rgbcolor={0,0,255}));
    end IdealCBSwitchValidation;

    model SignalPWMValidation "Simple model to validate SignalPWM behaviour" 
      extends Modelica.Icons.Example;
      Control.SignalPWM signalPWM(period=0.01) annotation(extent=[20,0; 40,20]);
      Modelica.Blocks.Sources.Step step(height=0.3,offset=0.2,startTime=0.3) annotation(extent=[-80,20; -60,40]);
      Modelica.Blocks.Sources.Step step1(height=0.3,startTime=0.6) annotation(extent=[-80,-20;-60,0]);
      Modelica.Blocks.Math.Add add annotation(extent=[-20,0;0,20]);
      annotation (
        Diagram,
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
    equation 
      connect(step.y, add.u1) annotation (points=[-59,30; -40,30; -40,16; -22,16],
          style(color=74, rgbcolor={0,0,127}));
      connect(step1.y, add.u2) annotation (points=[-59,-10; -40,-10; -40,4; -22,4],
          style(color=74, rgbcolor={0,0,127}));
      connect(add.y, signalPWM.duty) 
        annotation (points=[1,10; 20,10], style(color=74, rgbcolor={0,0,127}));
    end SignalPWMValidation;

    model PLLValidation "PLL validation example" 
      extends Modelica.Icons.Example;
      annotation (uses(Modelica(version="2.2.1")), Diagram,
        experiment(StartTime=0, StopTime=0.15, Tolerance=1e-4));
      Modelica.Blocks.Sources.Sine sine(freqHz=50, phase=2.5) 
        annotation (extent=[-80,0; -60,20]);
      Control.PLL pLL annotation (extent=[-40,0; -20,20]);
      Modelica.Blocks.Math.Sin sin annotation (extent=[2,0; 22,20]);
    equation 
      connect(sine.y, pLL.v) annotation (points=[-59,10; -50.5,10; -50.5,10; 
            -42,10],
                 style(color=74, rgbcolor={0,0,127}));
      connect(pLL.theta, sin.u) annotation (points=[-19,10; -9.5,10; -9.5,10; 0,
            10], style(color=74, rgbcolor={0,0,127}));
    end PLLValidation;

      model MPPTControllerValidation "Model to validate MPPT controller" 
        extends Modelica.Icons.Example;
        Modelica.Electrical.Analog.Basic.Ground ground annotation(extent=[16,-100;
            36,-80]);
        Electrical.PVArray pVArray annotation(extent=[-60,0; -40,20],
                                                                   rotation=270);
        annotation (
          Diagram,
          experiment(StopTime=180));
        Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage 
          annotation (extent=[16,0; 36,20],  rotation=270);
        Control.MPPTController mPPTController(                 vrefStep=1,
        sampleTime=1,
        pkThreshold=0.01) 
          annotation (extent=[70,0; 90,20], rotation=180);
        Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor 
          annotation (extent=[-40,10; -20,30]);
        Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor 
          annotation (extent=[46,-40; 66,-20], rotation=270);
      Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor 
        annotation (extent=[-12,10; 8,30], rotation=0);
      Modelica.Blocks.Sources.Ramp G(
        duration=15,
        offset=1000,
        startTime=50,
        height=-500) annotation (extent=[-100,20; -80,40]);
      Modelica.Blocks.Sources.Ramp T(
        startTime=100,
        height=-25,
        offset=273.15 + 25,
        duration=50) annotation (extent=[-100,-18; -80,2]);
      Modelica.Blocks.Math.Add add 
        annotation (extent=[38,20; 58,40], rotation=180);
      Modelica.Blocks.Sources.Ramp Perturbation(
        height=10,
        duration=30,
        offset=0,
        startTime=125) annotation (extent=[70,26; 90,46], rotation=180);
      equation 
        connect(ground.p, signalVoltage.n) annotation (points=[26,-80; 26,-40; 
            26,0; 26,0],        style(color=3, rgbcolor={0,0,255}));
        connect(pVArray.n, signalVoltage.n) annotation (points=[-50,0; 26,0],
                  style(color=3, rgbcolor={0,0,255}));
        connect(pVArray.p, currentSensor.p) 
          annotation (points=[-50,20; -40,20], style(color=3, rgbcolor={0,0,255}));
        connect(currentSensor.i, mPPTController.u2) annotation (points=[-30,10; 
            -30,60; 100,60; 100,16; 92,16],
                                        style(color=74, rgbcolor={0,0,127}));
        connect(voltageSensor.p, signalVoltage.p) annotation (points=[56,-20; 
            42,-20; 42,20; 26,20],     style(color=3, rgbcolor={0,0,255}));
        connect(voltageSensor.n, ground.p) annotation (points=[56,-40; 42,-40; 42,
            -80; 26,-80],
                      style(color=3, rgbcolor={0,0,255}));
        connect(voltageSensor.v, mPPTController.u1) annotation (points=[46,-30; 
            100,-30; 100,4; 92,4],
                                style(color=74, rgbcolor={0,0,127}));
      connect(currentSensor.n, powerSensor.pc) 
        annotation (points=[-20,20; -12,20], style(color=3, rgbcolor={0,0,255}));
      connect(powerSensor.nc, signalVoltage.p) 
        annotation (points=[8,20; 26,20], style(color=3, rgbcolor={0,0,255}));
      connect(powerSensor.pv, signalVoltage.p) annotation (points=[-2,30; 8,30; 
            8,20; 26,20],
                        style(color=3, rgbcolor={0,0,255}));
      connect(powerSensor.nv, signalVoltage.n) annotation (points=[-2,10; 12,10; 
            12,0; 26,0], style(color=3, rgbcolor={0,0,255}));
      connect(G.y, pVArray.G) annotation (points=[-79,30; -68,30; -68,13; -55.5,
            13], style(color=74, rgbcolor={0,0,127}));
      connect(T.y, pVArray.T) annotation (points=[-79,-8; -68,-8; -68,7; -55.5,
            7],
          style(color=74, rgbcolor={0,0,127}));
      connect(add.u1, mPPTController.y) annotation (points=[60,24; 66,24; 66,10; 
            69,10], style(color=74, rgbcolor={0,0,127}));
      connect(add.y, signalVoltage.v) annotation (points=[37,30; 33,30; 33,10],
          style(color=74, rgbcolor={0,0,127}));
      connect(Perturbation.y, add.u2) 
        annotation (points=[69,36; 60,36], style(color=74, rgbcolor={0,0,127}));
      end MPPTControllerValidation;
  end Validation;

  package Application "More complete application examples" 
    extends Modelica.Icons.Library;
    model BuckOpenSwitched "Ideal synchronous open-loop buck converter" 
      extends Modelica.Icons.Example;
      Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=5) annotation(extent=[-90,-30;-70,-10],rotation=270);
      Modelica.Electrical.Analog.Basic.Ground ground annotation(extent=[30,-80; 50,-60]);
      Modelica.Electrical.Analog.Basic.Resistor resistor(R=0.4) annotation(extent=[70,-50;90,-30],rotation=270);
      Modelica.Electrical.Analog.Basic.Inductor inductor(L=1e-6) annotation(extent=[0,-30;20,-10]);
      Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=200e-6) annotation(extent=[30,-50;50,-30],rotation=270);
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch annotation(extent=[-50,0;-30,20],rotation=270);
      Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode annotation(extent=[-50,-50;-30,-30],rotation=90);
      Control.SignalPWM signalPWM(period=1e-5) annotation(extent=[20,40;40,60],rotation=0);
      Modelica.Blocks.Sources.Step step(height=0.4,offset=0.3,startTime=0.01) annotation(extent=[-20,40;0,60]);
      annotation (
        Diagram,
        experiment(StartTime=0, StopTime=0.02, Tolerance=1e-4),
        Documentation(info="<html>
      <p>
        IdealBuckOpen presents a buck DC-DC converter. It's build using
        mostly blocks
        from <a href=\"Modelica://Modelica.Electrical.Analog\">Modelica's
        electrical library</a> but also includes
        the <a href=\"Modelica://PVlib.Control.SignalPWM\">SignalPWM</a>
        model. It showcases how components from PVlib can be mixed with
        components from the Modelica Standard Library to build systems that
        might be of interest.
      </p>

      <p>
        It is still an open-loop system. A duty cycle value is fed to the
        SignalPWM block to drive the ideal closing switch. The duty cycle
        value begins at 0.3 and changes to 0.7 in the middle of the
        simulation. The effect of this change can be observed by plotting
        the output voltage:
      </p>


      <div class=\"figure\">
        <p><img src=\"../Resources/Images/IdealBuckOpenResults.png\"
      	  alt=\"IdealBuckOpenResults.png\" />
        </p>
      </div>

      <p>
        This figure also displays the input voltage for the sake of
        comparison. It make the point that the function of the buck
        converter is to reduce the voltage level from the input to the
        output.
      </p>

      <p>
        An interesting exercise to complete this example would be to build a
        controller to close the loop and study the system's behaviour.
      </p>
      </html>"));
    equation 
      connect(step.y, signalPWM.duty) 
        annotation (points=[1,50; 20,50], style(color=74, rgbcolor={0,0,127}));
      connect(idealClosingSwitch.n, idealDiode.n) 
        annotation (points=[-40,0; -40,-30], style(color=3, rgbcolor={0,0,255}));
      connect(ground.p, constantVoltage.n) annotation (points=[40,-60; -80,-60;
            -80,-30], style(color=3, rgbcolor={0,0,255}));
      connect(idealDiode.p, ground.p) annotation (points=[-40,-50; -40,-60; 40,
            -60], style(color=3, rgbcolor={0,0,255}));
      connect(constantVoltage.p, idealClosingSwitch.p) annotation (points=[-80,
            -10; -80,40; -40,40; -40,20], style(color=3, rgbcolor={0,0,255}));
      connect(inductor.p, idealClosingSwitch.n) annotation (points=[0,-20; -40,
            -20; -40,0], style(color=3, rgbcolor={0,0,255}));
      connect(capacitor.n, ground.p) 
        annotation (points=[40,-50; 40,-60], style(color=3, rgbcolor={0,0,255}));
      connect(resistor.n, ground.p) annotation (points=[80,-50; 80,-60; 40,-60],
          style(color=3, rgbcolor={0,0,255}));
      connect(inductor.n, resistor.p) annotation (points=[20,-20; 80,-20; 80,-30],
          style(color=3, rgbcolor={0,0,255}));
      connect(capacitor.p, inductor.n) annotation (points=[40,-30; 40,-20; 20,-20],
          style(color=3, rgbcolor={0,0,255}));
      connect(signalPWM.fire, idealClosingSwitch.control) annotation (points=[40,55; 
            60,55; 60,10; -33,10],     style(color=5, rgbcolor={255,0,255}));
    end BuckOpenSwitched;

    model BuckOpenAveraged 
      "Ideal synchronous open-loop buck converter using average switch model" 
      extends Modelica.Icons.Example;
      Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=5) annotation(extent=[-90,-20;
            -70,0],                                                                                               rotation=270);
      Modelica.Electrical.Analog.Basic.Ground ground annotation(extent=[30,-50;
            50,-30]);
      Modelica.Electrical.Analog.Basic.Resistor resistor(R=0.4) annotation(extent=[70,-20;
            90,0],                                                                                rotation=270);
      Modelica.Electrical.Analog.Basic.Inductor inductor(L=1e-6) annotation(extent=[0,0; 20,
            20]);
      Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=200e-6) annotation(extent=[30,-20;
            50,0],                                                                                     rotation=270);
      Modelica.Blocks.Sources.Step step(height=0.4,offset=0.3,startTime=0.01) annotation(extent=[-80,-80;
            -60,-60]);
      annotation (
        Diagram,
        experiment(StartTime=0, StopTime=0.02, Tolerance=1e-4),
        Documentation(info="<html>
      <p>
        IdealBuckOpen presents a buck DC-DC converter. It's build using
        mostly blocks
        from <a href=\"Modelica://Modelica.Electrical.Analog\">Modelica's
        electrical library</a> but also includes
        the <a href=\"Modelica://PVlib.Control.SignalPWM\">SignalPWM</a>
        model. It showcases how components from PVlib can be mixed with
        components from the Modelica Standard Library to build systems that
        might be of interest.
      </p>

      <p>
        It is still an open-loop system. A duty cycle value is fed to the
        SignalPWM block to drive the ideal closing switch. The duty cycle
        value begins at 0.3 and changes to 0.7 in the middle of the
        simulation. The effect of this change can be observed by plotting
        the output voltage:
      </p>


      <div class=\"figure\">
        <p><img src=\"../Resources/Images/IdealBuckOpenResults.png\"
      	  alt=\"IdealBuckOpenResults.png\" />
        </p>
      </div>

      <p>
        This figure also displays the input voltage for the sake of
        comparison. It make the point that the function of the buck
        converter is to reduce the voltage level from the input to the
        output.
      </p>

      <p>
        An interesting exercise to complete this example would be to build a
        controller to close the loop and study the system's behaviour.
      </p>
      </html>"));
      PVlib.Electrical.IdealAverageCCMSwitch idealAverage2Switch 
        annotation (extent=[-60,0; -40,20]);
    equation 
      connect(ground.p, constantVoltage.n) annotation (points=[40,-30; -80,-30;
            -80,-20], style(color=3, rgbcolor={0,0,255}));
      connect(capacitor.n, ground.p) 
        annotation (points=[40,-20; 40,-30], style(color=3, rgbcolor={0,0,255}));
      connect(resistor.n, ground.p) annotation (points=[80,-20; 80,-30; 40,-30],
          style(color=3, rgbcolor={0,0,255}));
      connect(inductor.n, resistor.p) annotation (points=[20,10; 80,10; 80,0],
          style(color=3, rgbcolor={0,0,255}));
      connect(capacitor.p, inductor.n) annotation (points=[40,0; 40,10; 20,10],
          style(color=3, rgbcolor={0,0,255}));
      connect(constantVoltage.p, idealAverage2Switch.p1) annotation (points=[-80,
            0; -80,15; -60,15], style(color=3, rgbcolor={0,0,255}));
      connect(step.y, idealAverage2Switch.d) annotation (points=[-59,-70; -50,-70;
            -50,-2], style(color=74, rgbcolor={0,0,127}));
      connect(idealAverage2Switch.p2, inductor.p) annotation (points=[-40,15; -20,
            15; -20,10; 0,10], style(color=3, rgbcolor={0,0,255}));
      connect(idealAverage2Switch.n2, ground.p) annotation (points=[-40,5; -40,
            -30; 40,-30], style(color=3, rgbcolor={0,0,255}));
      connect(idealAverage2Switch.n1, inductor.p) annotation (points=[-60,5; -60,
            -12; 0,-12; 0,10], style(color=3, rgbcolor={0,0,255}));
    end BuckOpenAveraged;

    model BuckOpenComparison 
      "Ideal synchronous open-loop buck converter using average switch model" 
      extends Modelica.Icons.Example;
      Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=5) annotation(extent=[-90,-20;
            -70,0],                                                                                               rotation=270);
      Modelica.Electrical.Analog.Basic.Ground ground annotation(extent=[30,-50;
            50,-30]);
      Modelica.Electrical.Analog.Basic.Resistor resistor(R=0.4) annotation(extent=[70,-20;
            90,0],                                                                                rotation=270);
      Modelica.Electrical.Analog.Basic.Inductor inductor(L=1e-6) annotation(extent=[0,0; 20,
            20]);
      Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=200e-6) annotation(extent=[30,-20;
            50,0],                                                                                     rotation=270);
      Modelica.Blocks.Sources.Step step(height=0.4,           startTime=0.01,
        offset=0.2)                                                           annotation(extent=[-170,-90;
            -150,-70]);
      annotation (
        Diagram,
        experiment(StartTime=0, StopTime=0.02, Tolerance=1e-4),
        Documentation(info="<html>
      <p>
        IdealBuckOpen presents a buck DC-DC converter. It's build using
        mostly blocks
        from <a href=\"Modelica://Modelica.Electrical.Analog\">Modelica's
        electrical library</a> but also includes
        the <a href=\"Modelica://PVlib.Control.SignalPWM\">SignalPWM</a>
        model. It showcases how components from PVlib can be mixed with
        components from the Modelica Standard Library to build systems that
        might be of interest.
      </p>

      <p>
        It is still an open-loop system. A duty cycle value is fed to the
        SignalPWM block to drive the ideal closing switch. The duty cycle
        value begins at 0.3 and changes to 0.7 in the middle of the
        simulation. The effect of this change can be observed by plotting
        the output voltage:
      </p>


      <div class=\"figure\">
        <p><img src=\"../Resources/Images/IdealBuckOpenResults.png\"
      	  alt=\"IdealBuckOpenResults.png\" />
        </p>
      </div>

      <p>
        This figure also displays the input voltage for the sake of
        comparison. It make the point that the function of the buck
        converter is to reduce the voltage level from the input to the
        output.
      </p>

      <p>
        An interesting exercise to complete this example would be to build a
        controller to close the loop and study the system's behaviour.
      </p>
      </html>"));
      PVlib.Electrical.IdealAverageCCMSwitch idealAverage2Switch(
                                                         Le=2*1e-6, fs=1e5) 
        annotation (extent=[-60,0; -40,20]);
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch annotation(extent=[-40,70;
            -20,90],                                                                                          rotation=0);
      Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode annotation(extent=[-18,48;
            2,68],                                                                               rotation=90);
      Control.SignalPWM signalPWM(period=1e-5) annotation(extent=[-80,90; -60,110],
                                                                               rotation=0);
      Modelica.Electrical.Analog.Basic.Resistor resistor1(
                                                         R=0.4) annotation(extent=[80,50;
            100,70],                                                                              rotation=270);
      Modelica.Electrical.Analog.Basic.Inductor inductor1(
                                                         L=1e-6) annotation(extent=[10,70;
            30,90]);
      Modelica.Electrical.Analog.Basic.Capacitor capacitor1(
                                                           C=200e-6) annotation(extent=[40,50;
            60,70],                                                                                    rotation=270);
      Modelica.Blocks.Sources.Step step1(
        height=0.1,
        offset=0,
        startTime=0.015)                                                      annotation(extent=[-170,-54;
            -150,-34]);
      Modelica.Blocks.Math.Add add annotation (extent=[-134,-70; -114,-50]);
    equation 
      connect(ground.p, constantVoltage.n) annotation (points=[40,-30; -80,-30;
            -80,-20], style(color=3, rgbcolor={0,0,255}));
      connect(capacitor.n, ground.p) 
        annotation (points=[40,-20; 40,-30], style(color=3, rgbcolor={0,0,255}));
      connect(resistor.n, ground.p) annotation (points=[80,-20; 80,-30; 40,-30],
          style(color=3, rgbcolor={0,0,255}));
      connect(inductor.n, resistor.p) annotation (points=[20,10; 80,10; 80,0],
          style(color=3, rgbcolor={0,0,255}));
      connect(capacitor.p, inductor.n) annotation (points=[40,0; 40,10; 20,10],
          style(color=3, rgbcolor={0,0,255}));
      connect(constantVoltage.p, idealAverage2Switch.p1) annotation (points=[-80,
            0; -80,15; -60,15], style(color=3, rgbcolor={0,0,255}));
      connect(idealAverage2Switch.p2, inductor.p) annotation (points=[-40,15; -20,
            15; -20,10; 0,10], style(color=3, rgbcolor={0,0,255}));
      connect(idealAverage2Switch.n2, ground.p) annotation (points=[-40,5; -40,
            -30; 40,-30], style(color=3, rgbcolor={0,0,255}));
      connect(idealAverage2Switch.n1, inductor.p) annotation (points=[-60,5; -60,
            -12; 0,-12; 0,10], style(color=3, rgbcolor={0,0,255}));
      connect(signalPWM.fire,idealClosingSwitch. control) annotation (points=[-60,105;
            -30,105; -30,87],          style(color=5, rgbcolor={255,0,255}));
      connect(idealClosingSwitch.p, constantVoltage.p) annotation (points=[-40,80;
            -80,80; -80,0], style(color=3, rgbcolor={0,0,255}));
      connect(idealClosingSwitch.n, idealDiode.n) annotation (points=[-20,80; 
            -8,80; -8,68],
                        style(color=3, rgbcolor={0,0,255}));
      connect(idealDiode.p, ground.p) annotation (points=[-8,48; -8,-30; 40,-30],
          style(color=3, rgbcolor={0,0,255}));
      connect(capacitor1.n, ground.p) 
        annotation (points=[50,50; 50,-30; 40,-30],
                                             style(color=3, rgbcolor={0,0,255}));
      connect(resistor1.n, ground.p) 
                                    annotation (points=[90,50; 90,-30; 40,-30],
          style(color=3, rgbcolor={0,0,255}));
      connect(inductor1.n, resistor1.p) 
                                      annotation (points=[30,80; 90,80; 90,70],
          style(color=3, rgbcolor={0,0,255}));
      connect(capacitor1.p, inductor1.n) 
                                       annotation (points=[50,70; 50,80; 30,80],
          style(color=3, rgbcolor={0,0,255}));
      connect(inductor1.p, idealDiode.n) annotation (points=[10,80; -8,80; -8,
            68],
          style(color=3, rgbcolor={0,0,255}));
      connect(step1.y, add.u1) annotation (points=[-149,-44; -142,-44; -142,-54;
            -136,-54], style(color=74, rgbcolor={0,0,127}));
      connect(step.y, add.u2) annotation (points=[-149,-80; -142,-80; -142,-66;
            -136,-66], style(color=74, rgbcolor={0,0,127}));
      connect(add.y, idealAverage2Switch.d) annotation (points=[-113,-60; -50,-60;
            -50,-2], style(color=74, rgbcolor={0,0,127}));
      connect(signalPWM.duty, add.y) annotation (points=[-80,100; -108,100; -108,
            -60; -113,-60], style(color=74, rgbcolor={0,0,127}));
    end BuckOpenComparison;

    model Inverter1phOpenSwitched 
      "Basic 1 phase open-loop inverter with constant DC voltage source and no synchronization" 
      extends Modelica.Icons.Example;
      Electrical.IdealHBridge idealHBridge annotation(extent=[-20,20;0,40]);
      Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=500) annotation(extent=[-60,20;-40,40],rotation=270);
      Modelica.Electrical.Analog.Basic.Ground ground annotation (extent=[-60,-20;-40,0]);
      Modelica.Electrical.Analog.Basic.Resistor resistor annotation(extent=[40,0;60,20],rotation=270);
      Modelica.Electrical.Analog.Basic.Inductor inductor(L=500e-6) annotation(extent=[40,40;60,60],rotation=270);
      Modelica.Blocks.Sources.Sine sine(amplitude=0.4,offset=0.5,freqHz=50) annotation(extent=[-80,-60;-60,-40]);
      Control.SignalPWM signalPWM(period=320e-6) annotation(extent=[-40,-60;-20,-40]);
      annotation (
        Diagram,
        experiment(StartTime=0, StopTime=0.05, Tolerance=1e-4),
        Documentation(info="<html>
      <p>
        IdealInverter1phOpen presents an open loop 1-phase inverter. The
        function of the inverter is to convert DC voltage and current into
        AC voltage and current. To keep things simple, a constant DC source
        is included on the DC side and an LC load is included on the AC
        side. Typically, inverters are placed inside a more complicated
        setup, which might require MPPT (Maximum Power Point Tracking) on
        the DC side when connected to a PV array and AC synchronization when
        connected to a grid on the AC side instead of just a simple passive
        load.
      </p>

      <p>
        Nevertheless, the example still showcases an interesting
        application. Upon running the simulation with the provided values,
        plotting the resistor voltage and the DC source voltage yields the
        following figure:
      </p>


      <div class=\"figure\">
        <p><img src=\"../Resources/Images/IdealInverter1phOpenResults.png\"
      	  alt=\"IdealInverter1phOpenResults.png\" />
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
        out of the inverte is actually a square wave and the inductor is
        providing some crude (but enough for some applications)
        filtering. Play around with the value of the inductor to see how it
        provides a better or worse filtering performance (decreasing or
        increasing the voltage and current ripple in the resistor, which in
        this example is assumed to be the load being fed). Since this is an
        open loop configuration, it will also change the peak value of the
        voltage drop in the resistor, as well as its phase.
      </p>
      </html>"));
    equation 
      connect(sine.y, signalPWM.duty) annotation (points=[-59,-50; -40,-50],
          style(color=74, rgbcolor={0,0,127}));
      connect(constantVoltage.n, ground.p) annotation (points=[-50,20; -50,0; -50,
            0], style(color=3, rgbcolor={0,0,255}));
      connect(idealHBridge.dcn, constantVoltage.n) annotation (points=[-20,25;
            -36,25; -36,20; -50,20], style(color=3, rgbcolor={0,0,255}));
      connect(idealHBridge.dcp, constantVoltage.p) annotation (points=[-20,35;
            -36,35; -36,40; -50,40], style(color=3, rgbcolor={0,0,255}));
      connect(idealHBridge.acp, inductor.p) annotation (points=[0,35; 26,35; 26,
            60; 50,60], style(color=3, rgbcolor={0,0,255}));
      connect(idealHBridge.acn, resistor.n) annotation (points=[0,25; 26,25; 26,0;
            50,0], style(color=3, rgbcolor={0,0,255}));
      connect(resistor.p, inductor.n) 
        annotation (points=[50,20; 50,40], style(color=3, rgbcolor={0,0,255}));
      connect(signalPWM.fire, idealHBridge.fireA) annotation (points=[-20,-45;
            -12,-45; -12,20; -13,20], style(color=5, rgbcolor={255,0,255}));
      connect(signalPWM.notFire, idealHBridge.fireB) annotation (points=[-20,-55;
            -6,-55; -6,20; -7,20], style(color=5, rgbcolor={255,0,255}));
    end Inverter1phOpenSwitched;

    model Inverter1phOpenSwitchedSynch 
      "Grid synchronized 1-phase open-loop inverter fed by constant DC source" 
      extends Modelica.Icons.Example;
      Electrical.IdealHBridge idealHBridge annotation (extent=[-74,20; -54,40]);
      Modelica.Electrical.Analog.Sources.ConstantVoltage DCBus(V=580) 
        annotation (extent=[-100,20; -80,40], rotation=270);
      annotation (Diagram);
      Modelica.Electrical.Analog.Sources.SineVoltage Grid(freqHz=50, V=480) 
        annotation (extent=[50,20; 70,40], rotation=270);
      Modelica.Electrical.Analog.Basic.Inductor inductor(L=500e-6) 
        annotation (extent=[-20,50; 0,70]);
      Control.PLL pLL annotation (extent=[62,-60; 82,-40], rotation=180);
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor 
        annotation (extent=[80,30; 100,50], rotation=0);
      Control.SignalPWM signalPWM(period=320e-6) 
        annotation (extent=[-54,-20; -34,0], rotation=180);
      Modelica.Blocks.Math.Sin sin 
        annotation (extent=[34,-60; 54,-40], rotation=180);
      Modelica.Blocks.Math.Gain gain(k=350/580/2) 
        annotation (extent=[6,-60; 26,-40], rotation=180);
      Modelica.Blocks.Math.Add add annotation (extent=[-24,-20; -4,0], rotation=180);
      Modelica.Blocks.Sources.Constant const(k=0.5) 
        annotation (extent=[20,-20; 40,0], rotation=180);
      Modelica.Electrical.Analog.Basic.Ground ground 
        annotation (extent=[-100,-20; -80,0]);
      Modelica.Electrical.Analog.Basic.Resistor resistor(R=10e-3) 
        annotation (extent=[20,50; 40,70]);
    equation 
      connect(DCBus.p, idealHBridge.dcp) annotation (points=[-90,40; -80,40; -80,35;
            -74,35], style(color=3, rgbcolor={0,0,255}));
      connect(DCBus.n, idealHBridge.dcn) annotation (points=[-90,20; -80,20; -80,25;
            -74,25], style(color=3, rgbcolor={0,0,255}));
      connect(voltageSensor.p, Grid.p) 
        annotation (points=[80,40; 60,40], style(color=3, rgbcolor={0,0,255}));
      connect(Grid.n, voltageSensor.n) annotation (points=[60,20; 100,20; 100,40],
          style(color=3, rgbcolor={0,0,255}));
      connect(pLL.v, voltageSensor.v) annotation (points=[84,-50; 84,-50.5; 90,
            -50.5; 90,30], style(color=74, rgbcolor={0,0,127}));
      connect(sin.u, pLL.theta) 
        annotation (points=[56,-50; 61,-50], style(color=74, rgbcolor={0,0,127}));
      connect(gain.u, sin.y) 
        annotation (points=[28,-50; 33,-50], style(color=74, rgbcolor={0,0,127}));
      connect(add.y, signalPWM.duty) annotation (points=[-25,-10; -27.25,-10; 
            -27.25,-10; -29.5,-10; -29.5,-10; -34,-10], style(color=74, rgbcolor={0,
              0,127}));
      connect(gain.y, add.u1) annotation (points=[5,-50; 2,-50; 2,-16; -2,-16],
          style(color=74, rgbcolor={0,0,127}));
      connect(const.y, add.u2) annotation (points=[19,-10; 10,-10; 10,-4; -2,-4],
          style(color=74, rgbcolor={0,0,127}));
      connect(signalPWM.notFire, idealHBridge.fireB) annotation (points=[-54,-5; 
            -62,-5; -62,20; -61,20], style(color=5, rgbcolor={255,0,255}));
      connect(signalPWM.fire, idealHBridge.fireA) annotation (points=[-54,-15; -68,
            -15; -68,20; -67,20], style(color=5, rgbcolor={255,0,255}));
      connect(ground.p, DCBus.n) 
        annotation (points=[-90,0; -90,20], style(color=3, rgbcolor={0,0,255}));
      connect(idealHBridge.acn, Grid.n) annotation (points=[-54,25; -30,25; -30,
            20; 60,20],
                 style(color=3, rgbcolor={0,0,255}));
      connect(resistor.n, Grid.p) annotation (points=[40,60; 60,60; 60,40], style(
            color=3, rgbcolor={0,0,255}));
      connect(inductor.n, resistor.p) 
        annotation (points=[0,60; 20,60], style(color=3, rgbcolor={0,0,255}));
      connect(idealHBridge.acp, inductor.p) annotation (points=[-54,35; -31,35;
            -31,60; -20,60],
                         style(color=3, rgbcolor={0,0,255}));
    end Inverter1phOpenSwitchedSynch;

    model Inverter1phOpenAveraged 
      "Basic 1 phase open-loop inverter with constant DC voltage source and no synchronization" 
      extends Modelica.Icons.Example;
      Modelica.Electrical.Analog.Sources.ConstantVoltage DCSource(V=500)        annotation(extent=[-60,20;-40,40],rotation=270);
      Modelica.Electrical.Analog.Basic.Ground ground annotation (extent=[-60,-20;-40,0]);
      Modelica.Electrical.Analog.Basic.Resistor resistor annotation(extent=[40,0;60,20],rotation=270);
      Modelica.Electrical.Analog.Basic.Inductor inductor(L=500e-6) annotation(extent=[40,40;60,60],rotation=270);
      Modelica.Blocks.Sources.Sine sine(amplitude=0.4,offset=0.5,freqHz=50) annotation(extent=[-80,-60;-60,-40]);
      annotation (
        Diagram,
        experiment(StartTime=0, StopTime=0.05, Tolerance=1e-4),
        Documentation(info="<html>
      <p>
        IdealInverter1phOpen presents an open loop 1-phase inverter. The
        function of the inverter is to convert DC voltage and current into
        AC voltage and current. To keep things simple, a constant DC source
        is included on the DC side and an LC load is included on the AC
        side. Typically, inverters are placed inside a more complicated
        setup, which might require MPPT (Maximum Power Point Tracking) on
        the DC side when connected to a PV array and AC synchronization when
        connected to a grid on the AC side instead of just a simple passive
        load.
      </p>

      <p>
        Nevertheless, the example still showcases an interesting
        application. Upon running the simulation with the provided values,
        plotting the resistor voltage and the DC source voltage yields the
        following figure:
      </p>


      <div class=\"figure\">
        <p><img src=\"../Resources/Images/IdealInverter1phOpenResults.png\"
      	  alt=\"IdealInverter1phOpenResults.png\" />
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
        out of the inverte is actually a square wave and the inductor is
        providing some crude (but enough for some applications)
        filtering. Play around with the value of the inductor to see how it
        provides a better or worse filtering performance (decreasing or
        increasing the voltage and current ripple in the resistor, which in
        this example is assumed to be the load being fed). Since this is an
        open loop configuration, it will also change the peak value of the
        voltage drop in the resistor, as well as its phase.
      </p>
      </html>"));
      Electrical.IdealAverageHBridge idealAverageHBridge 
        annotation (extent=[-20,20; 0,40]);
    equation 
      connect(DCSource.n, ground.p)        annotation (points=[-50,20; -50,0],
                style(color=3, rgbcolor={0,0,255}));
      connect(resistor.p, inductor.n) 
        annotation (points=[50,20; 50,40], style(color=3, rgbcolor={0,0,255}));
      connect(sine.y, idealAverageHBridge.u) annotation (points=[-59,-50; -10,-50;
            -10,18], style(color=74, rgbcolor={0,0,127}));
      connect(idealAverageHBridge.acp, inductor.p) annotation (points=[0,35; 26,
            35; 26,60; 50,60], style(color=3, rgbcolor={0,0,255}));
      connect(resistor.n, idealAverageHBridge.acn) annotation (points=[50,0; 26,0;
            26,25; 0,25], style(color=3, rgbcolor={0,0,255}));
      connect(DCSource.p, idealAverageHBridge.dcp) annotation (points=[-50,40;
            -36,40; -36,35; -20,35], style(color=3, rgbcolor={0,0,255}));
      connect(DCSource.n, idealAverageHBridge.dcn) annotation (points=[-50,20;
            -36,20; -36,25; -20,25], style(color=3, rgbcolor={0,0,255}));
    end Inverter1phOpenAveraged;

    model SimplePVSystem 
      "Simple PV system including PV array, inverter and grid" 
      extends Modelica.Icons.Example;
      Electrical.PVArray PV(Ns=54*15)
        annotation (extent=[-120,60; -100,80], rotation=270);
      Modelica.Blocks.Sources.Constant Gn(k=1000) annotation(extent=[-148,80; 
            -128,100]);
      Modelica.Blocks.Sources.Constant Tn(k=298.15) annotation(extent=[-148,40; 
            -128,60]);
      annotation (Diagram);
      Electrical.IdealAverageHBridge Inverter
        annotation (extent=[-10,60; 10,80]);
      Modelica.Electrical.Analog.Sources.SineVoltage Grid(freqHz=50, V=480) 
        annotation (extent=[80,-20; 100,0],rotation=270);
      Modelica.Electrical.Analog.Basic.Inductor L(L=500e-6) 
        annotation (extent=[80,56; 100,76], rotation=270);
      Modelica.Electrical.Analog.Basic.Resistor R(R=10e-3) 
        annotation (extent=[80,20; 100,40], rotation=270);
      Modelica.Electrical.Analog.Sensors.VoltageSensor VSac
        annotation (extent=[50,-20; 70,0], rotation=270);
      Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=500e-3)
        annotation (extent=[-36,60; -16,80], rotation=270);
      Control.OnePhaseInverterController Controller
        annotation (extent=[12,18; -8,38], rotation=90);
      Modelica.Electrical.Analog.Sensors.VoltageSensor VSdc
        annotation (extent=[-42,-20; -62,0], rotation=270);
      Modelica.Electrical.Analog.Sensors.CurrentSensor CSdc
        annotation (extent=[-52,70; -32,90]);
      Modelica.Electrical.Analog.Sensors.CurrentSensor CSac
        annotation (extent=[30,80; 50,100]);
      Modelica.Electrical.Analog.Sensors.PowerSensor PSac
        annotation (extent=[60,80; 80,100]);
      Modelica.Electrical.Analog.Sensors.PowerSensor PSdc
        annotation (extent=[-72,70; -92,90]);
    equation 
      connect(Gn.y, PV.G) annotation (points=[-127,90; -122,90; -122,73; -115.5,
            73], style(color=74, rgbcolor={0,0,127}));
      connect(Tn.y, PV.T) annotation (points=[-127,50; -122,50; -122,67; -115.5,
            67], style(color=74, rgbcolor={0,0,127}));
      connect(capacitor.p, Inverter.dcp) annotation (points=[-26,80; -16,80; 
            -16,75; -10,75], style(color=3, rgbcolor={0,0,255}));
      connect(capacitor.n, Inverter.dcn) annotation (points=[-26,60; -10,60; 
            -10,65], style(color=3, rgbcolor={0,0,255}));
      connect(Controller.d, Inverter.u) annotation (points=[2,39; 2,58; 0,58], 
          style(color=74, rgbcolor={0,0,127}));
      connect(PV.n, VSdc.n) annotation (points=[-110,60; -110,-20; -52,-20], 
          style(color=3, rgbcolor={0,0,255}));
      connect(VSdc.n, capacitor.n) annotation (points=[-52,-20; -26,-20; -26,60], 
          style(color=3, rgbcolor={0,0,255}));
      connect(VSdc.v, Controller.vdc) annotation (points=[-42,-10; -6,-10; -6,
            16], style(color=74, rgbcolor={0,0,127}));
      connect(CSdc.n, capacitor.p) annotation (points=[-32,80; -26,80], style(
            color=3, rgbcolor={0,0,255}));
      connect(CSdc.i, Controller.idc) annotation (points=[-42,70; -42,6; -1,6; 
            -1,16], style(color=74, rgbcolor={0,0,127}));
      connect(VSdc.p, CSdc.p) annotation (points=[-52,0; -52,80], style(color=3, 
            rgbcolor={0,0,255}));
      connect(VSac.n, Grid.n) annotation (points=[60,-20; 90,-20], style(color=
              3, rgbcolor={0,0,255}));
      connect(Inverter.acn, VSac.n) annotation (points=[10,65; 20,65; 20,-20; 
            60,-20], style(color=3, rgbcolor={0,0,255}));
      connect(VSac.p, Grid.p)
        annotation (points=[60,0; 90,0], style(color=3, rgbcolor={0,0,255}));
      connect(Controller.vac, VSac.v) annotation (points=[5,16; 4,16; 4,-10; 50,
            -10], style(color=74, rgbcolor={0,0,127}));
      connect(R.n, Grid.p)
        annotation (points=[90,20; 90,0], style(color=3, rgbcolor={0,0,255}));
      connect(L.n, R.p)
        annotation (points=[90,56; 90,40], style(color=3, rgbcolor={0,0,255}));
      connect(Inverter.acp, CSac.p) annotation (points=[10,75; 26,75; 26,90; 30,
            90], style(color=3, rgbcolor={0,0,255}));
      connect(CSac.i, Controller.iac) annotation (points=[40,80; 40,6; 10,6; 10,
            16], style(color=74, rgbcolor={0,0,127}));
      connect(PSdc.nc, PV.p) annotation (points=[-92,80; -110,80], style(color=
              3, rgbcolor={0,0,255}));
      connect(PSdc.pc, CSdc.p) annotation (points=[-72,80; -52,80], style(color
            =3, rgbcolor={0,0,255}));
      connect(PSdc.pv, PV.p) annotation (points=[-82,90; -110,90; -110,80], 
          style(color=3, rgbcolor={0,0,255}));
      connect(PSdc.nv, VSdc.n) annotation (points=[-82,70; -82,-20; -52,-20], 
          style(color=3, rgbcolor={0,0,255}));
      connect(PSac.pc, CSac.n)
        annotation (points=[60,90; 50,90], style(color=3, rgbcolor={0,0,255}));
      connect(PSac.nc, L.p) annotation (points=[80,90; 90,90; 90,76], style(
            color=3, rgbcolor={0,0,255}));
      connect(PSac.pv, PSac.pc) annotation (points=[70,100; 60,100; 60,90], 
          style(color=3, rgbcolor={0,0,255}));
      connect(PSac.nv, VSac.n) annotation (points=[70,80; 70,-20; 60,-20], 
          style(color=3, rgbcolor={0,0,255}));
    end SimplePVSystem;
  end Application;
end Examples;
