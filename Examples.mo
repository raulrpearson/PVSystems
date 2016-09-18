package Examples "Application and validation examples" 
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
    connect(Tn.y, pVArray.T) annotation (points=[-29,-14; -16,-14; -16,7; -5.5,
          7], style(color=74, rgbcolor={0,0,127}));
    connect(pVArray.p, rampVoltage.p) annotation (points=[1.83691e-015,20; 40,
          20], style(color=3, rgbcolor={0,0,255}));
    connect(pVArray.n, rampVoltage.n) annotation (points=[-1.83691e-015,0; 40,0],
        style(color=3, rgbcolor={0,0,255}));
    connect(ground.p, rampVoltage.n) 
      annotation (points=[40,-20; 40,0], style(color=3, rgbcolor={0,0,255}));
    end PVArrayValidation;
  
  model IdealCBSwitchValidation "Ideal current bidirectional switch validation" 
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
    connect(booleanStep.y, idealCBSwitch.fire) annotation (points=[-59,10; -48,
          10; -48,10; -37,10], style(color=5, rgbcolor={255,0,255}));
    connect(idealCBSwitch.p, resistor.n) annotation (points=[-30,20; -30,40; 
          -10,40], style(color=3, rgbcolor={0,0,255}));
    connect(idealCBSwitch.n, sineVoltage.n) annotation (points=[-30,0; -30,-20; 
          30,-20; 30,0], style(color=3, rgbcolor={0,0,255}));
    connect(resistor.p, sineVoltage.p) annotation (points=[10,40; 30,40; 30,20],
        style(color=3, rgbcolor={0,0,255}));
    connect(ground.p, sineVoltage.n) annotation (points=[30,-40; 30,-20; 30,0; 
          30,0], style(color=3, rgbcolor={0,0,255}));
  end IdealCBSwitchValidation;
  
  model IdealBuckOpen "Ideal synchronous open-loop buck converter" 
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
  end IdealBuckOpen;
  
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
  
  model IdealInverter1phOpen 
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
  end IdealInverter1phOpen;
end Examples;
