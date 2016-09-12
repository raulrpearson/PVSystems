package Examples "Application and validation examples" 
  extends Modelica.Icons.Library;
  
    model PVArrayValidation "Model to validate PVArray" 
    Electrical.Sources.RampVoltage rampVoltage(
      duration=1,
      V=45,
      offset=-10) 
      annotation (extent=[30,0; 50,20],  rotation=270);
    annotation (Diagram);
    Electrical.Basic.Ground ground annotation (extent=[30,-40; 50,-20]);
    Electrical.Solar.PVArray pVArray 
      annotation (extent=[-10,0; 10,20], rotation=270);
    Control.Sources.Constant Gn(k={1000}) annotation (extent=[-50,10; -30,30]);
    Control.Sources.Constant Tn(k={298.16}) 
      annotation (extent=[-50,-24; -30,-4]);
    equation 
    connect(ground.p, rampVoltage.n) 
      annotation (points=[40,-20; 40,0], style(color=3, rgbcolor={0,0,255}));
    connect(Gn.outPort, pVArray.G) annotation (points=[-29,20; -18,20; -18,13;
          -5.5,13], style(color=3, rgbcolor={0,0,255}));
    connect(Tn.outPort, pVArray.T) annotation (points=[-29,-14; -18,-14; -18,7;
          -5.5,7], style(color=3, rgbcolor={0,0,255}));
    connect(pVArray.p, rampVoltage.p) annotation (points=[1.83691e-015,20; 40,
          20], style(color=3, rgbcolor={0,0,255}));
    connect(pVArray.n, rampVoltage.n) annotation (points=[-1.83691e-015,0; 40,0],
        style(color=3, rgbcolor={0,0,255}));
    end PVArrayValidation;
  
  model IdealCBSwitchValidation 
    Electrical.PowerConverters.IdealCBSwitch idealCBSwitch 
      annotation (extent=[-40,0; -20,20], rotation=270);
    Electrical.Sources.SineVoltage sineVoltage(freqHz=5) 
      annotation (extent=[20,0; 40,20], rotation=270);
    annotation (Diagram);
    Control.Sources.BooleanStep booleanStep(startTime={0.45}) 
      annotation (extent=[-80,0; -60,20]);
    Electrical.Basic.Ground ground annotation (extent=[20,-60; 40,-40]);
    Electrical.Basic.Resistor resistor(R=2) 
      annotation (extent=[-10,30; 10,50], rotation=180);
  equation 
    connect(idealCBSwitch.n, sineVoltage.n) annotation (points=[-30,0; -30,-20;
          30,-20; 30,0], style(color=3, rgbcolor={0,0,255}));
    connect(booleanStep.outPort, idealCBSwitch.firePort) annotation (points=[-59,10;
          -49.5,10; -49.5,10; -40,10],         style(color=5, rgbcolor={255,0,
            255}));
    connect(ground.p, sineVoltage.n) annotation (points=[30,-40; 30,-20; 30,0;
          30,0], style(color=3, rgbcolor={0,0,255}));
    connect(resistor.p, sineVoltage.p) annotation (points=[10,40; 30,40; 30,20],
        style(color=3, rgbcolor={0,0,255}));
    connect(resistor.n, idealCBSwitch.p) annotation (points=[-10,40; -30,40;
          -30,20], style(color=3, rgbcolor={0,0,255}));
  end IdealCBSwitchValidation;
  
  model IdealBuckOpen "Ideal synchronous open-loop buck converter" 
    Electrical.Sources.ConstantVoltage constantVoltage(V=5)
      annotation (extent=[-90,20; -70,40], rotation=270);
    annotation (Diagram, experiment(StopTime=0.01));
    Electrical.Basic.Ground ground annotation (extent=[30,-30; 50,-10]);
    Electrical.Basic.Resistor resistor(R=0.4)
      annotation (extent=[70,0; 90,20], rotation=270);
    Electrical.Basic.Inductor inductor(L=1e-6) annotation (extent=[0,20; 20,40]);
    Electrical.Basic.Capacitor capacitor(C=200e-6)
      annotation (extent=[30,0; 50,20], rotation=270);
    Control.Sources.BooleanPulse booleanPulse(period={1e-6}, width={80})
      annotation (extent=[0,50; 20,70], rotation=180);
    Electrical.Ideal.IdealSwitch idealSwitch
      annotation (extent=[-50,50; -30,70], rotation=270);
    Electrical.Ideal.IdealDiode idealDiode
      annotation (extent=[-50,0; -30,20], rotation=90);
  equation 
    connect(inductor.n, capacitor.p) annotation (points=[20,30; 40,30; 40,20], 
        style(color=3, rgbcolor={0,0,255}));
    connect(inductor.n, resistor.p) annotation (points=[20,30; 80,30; 80,20], 
        style(color=3, rgbcolor={0,0,255}));
    connect(resistor.n, ground.p) annotation (points=[80,0; 80,-10; 40,-10], 
        style(color=3, rgbcolor={0,0,255}));
    connect(capacitor.n, ground.p)
      annotation (points=[40,0; 40,-10], style(color=3, rgbcolor={0,0,255}));
    connect(idealSwitch.n, idealDiode.n)
      annotation (points=[-40,50; -40,20], style(color=3, rgbcolor={0,0,255}));
    connect(inductor.p, idealSwitch.n) annotation (points=[0,30; -40,30; -40,50], 
        style(color=3, rgbcolor={0,0,255}));
    connect(constantVoltage.p, idealSwitch.p) annotation (points=[-80,40; -80,
          80; -40,80; -40,70], style(color=3, rgbcolor={0,0,255}));
    connect(constantVoltage.n, ground.p) annotation (points=[-80,20; -80,-10; 
          40,-10], style(color=3, rgbcolor={0,0,255}));
    connect(idealDiode.p, ground.p) annotation (points=[-40,0; -40,-10; 40,-10], 
        style(color=3, rgbcolor={0,0,255}));
    connect(booleanPulse.outPort, idealSwitch.control) annotation (points=[-1,
          60; -34,60], style(color=5, rgbcolor={255,0,255}));
  end IdealBuckOpen;

  model SignalPWMValidation "Simple model to validate SignalPWM behaviour" 
    Control.PowerConverters.SignalPWM signalPWM(Ts={0.01})
      annotation (extent=[20,0; 40,20]);
    annotation (Diagram);
    Control.Sources.Step step(
      height={0.3}, 
      offset={0.2}, 
      startTime={0.3}) annotation (extent=[-80,20; -60,40]);
    Control.Sources.Step step1(height={0.3}, startTime={0.6})
      annotation (extent=[-80,-20; -60,0]);
    Control.Math.Add add annotation (extent=[-20,0; 0,20]);
  equation 
    connect(step.outPort, add.inPort1) annotation (points=[-59,30; -40,30; -40,
          16; -22,16], style(color=3, rgbcolor={0,0,255}));
    connect(step1.outPort, add.inPort2) annotation (points=[-59,-10; -40,-10; 
          -40,4; -22,4], style(color=3, rgbcolor={0,0,255}));
    connect(add.outPort, signalPWM.duty)
      annotation (points=[1,10; 20,10], style(color=3, rgbcolor={0,0,255}));
  end SignalPWMValidation;
end Examples;
