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
          -49.5,10; -49.5,10; -37,10],         style(color=5, rgbcolor={255,0,
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
      annotation (extent=[-90,-30; -70,-10], rotation=270);
    annotation (Diagram, experiment(StopTime=0.02));
    Electrical.Basic.Ground ground annotation (extent=[30,-80; 50,-60]);
    Electrical.Basic.Resistor resistor(R=0.4) 
      annotation (extent=[70,-50; 90,-30], rotation=270);
    Electrical.Basic.Inductor inductor(L=1e-6) 
      annotation (extent=[0,-30; 20,-10]);
    Electrical.Basic.Capacitor capacitor(C=200e-6) 
      annotation (extent=[30,-50; 50,-30], rotation=270);
    Electrical.Ideal.IdealSwitch idealSwitch 
      annotation (extent=[-50,0; -30,20], rotation=270);
    Electrical.Ideal.IdealDiode idealDiode 
      annotation (extent=[-50,-50; -30,-30], rotation=90);
    Control.PowerConverters.SignalPWM signalPWM(Ts={1e-5}) 
      annotation (extent=[20,40; 40,60], rotation=0);
    Control.Sources.Step step(
      height={0.4},
      offset={0.3},
      startTime={0.01}) annotation (extent=[-20,40; 0,60]);
  equation 
    connect(inductor.n, capacitor.p) annotation (points=[20,-20; 40,-20; 40,-30],
        style(color=3, rgbcolor={0,0,255}));
    connect(inductor.n, resistor.p) annotation (points=[20,-20; 80,-20; 80,-30],
        style(color=3, rgbcolor={0,0,255}));
    connect(resistor.n, ground.p) annotation (points=[80,-50; 80,-60; 40,-60],
        style(color=3, rgbcolor={0,0,255}));
    connect(capacitor.n, ground.p) 
      annotation (points=[40,-50; 40,-60], style(color=3, rgbcolor={0,0,255}));
    connect(idealSwitch.n, idealDiode.n) 
      annotation (points=[-40,0; -40,-30], style(color=3, rgbcolor={0,0,255}));
    connect(inductor.p, idealSwitch.n) annotation (points=[0,-20; -40,-20; -40,
          0], style(color=3, rgbcolor={0,0,255}));
    connect(constantVoltage.p, idealSwitch.p) annotation (points=[-80,-10; -80,
          30; -40,30; -40,20], style(color=3, rgbcolor={0,0,255}));
    connect(constantVoltage.n, ground.p) annotation (points=[-80,-30; -80,-60;
          40,-60], style(color=3, rgbcolor={0,0,255}));
    connect(idealDiode.p, ground.p) annotation (points=[-40,-50; -40,-60; 40,
          -60], style(color=3, rgbcolor={0,0,255}));
    connect(signalPWM.fire, idealSwitch.control) annotation (points=[40,55; 60,
          55; 60,10; -34,10], style(color=5, rgbcolor={255,0,255}));
    connect(step.outPort, signalPWM.duty) 
      annotation (points=[1,50; 20,50], style(color=3, rgbcolor={0,0,255}));
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
  
  model IdealInverter1phOpen 
    "Basic 1 phase open-loop inverter with constant DC voltage source and no synchronization" 
    Electrical.PowerConverters.IdealHBridge idealHBridge 
      annotation (extent=[-20,20; 0,40]);
    Electrical.Sources.ConstantVoltage constantVoltage(V=500) 
      annotation (extent=[-60,20; -40,40], rotation=270);
    annotation (Diagram, experiment(StopTime=0.5));
    Electrical.Basic.Ground ground annotation (extent=[-60,-20; -40,0]);
    Electrical.Basic.Resistor resistor 
      annotation (extent=[40,0; 60,20], rotation=270);
    Electrical.Basic.Inductor inductor(L=500e-6) 
      annotation (extent=[40,40; 60,60], rotation=270);
    Control.Sources.Sine sine(
      amplitude={0.4},
      freqHz={50},
      offset={0.5}) annotation (extent=[-80,-60; -60,-40]);
    Control.PowerConverters.SignalPWM signalPWM(Ts={320e-6}) 
      annotation (extent=[-40,-60; -20,-40]);
  equation 
    connect(constantVoltage.p, idealHBridge.dcp) annotation (points=[-50,40;
          -36,40; -36,35; -20,35], style(color=3, rgbcolor={0,0,255}));
    connect(constantVoltage.n, idealHBridge.dcn) annotation (points=[-50,20;
          -34,20; -34,25; -20,25], style(color=3, rgbcolor={0,0,255}));
    connect(ground.p, constantVoltage.n) 
      annotation (points=[-50,0; -50,20], style(color=3, rgbcolor={0,0,255}));
    connect(inductor.n, resistor.p) 
      annotation (points=[50,40; 50,20], style(color=3, rgbcolor={0,0,255}));
    connect(idealHBridge.acp, inductor.p) annotation (points=[0,35; 26,35; 26,
          60; 50,60], style(color=3, rgbcolor={0,0,255}));
    connect(idealHBridge.acn, resistor.n) annotation (points=[0,25; 26,25; 26,0;
          50,0], style(color=3, rgbcolor={0,0,255}));
    connect(sine.outPort, signalPWM.duty) annotation (points=[-59,-50; -40,-50],
        style(color=3, rgbcolor={0,0,255}));
    connect(signalPWM.fire, idealHBridge.fireA) annotation (points=[-20,-45;
          -14,-45; -14,20.2; -13,20.2], style(color=5, rgbcolor={255,0,255}));
    connect(signalPWM.notFire, idealHBridge.fireB) annotation (points=[-20,-55;
          -20,-55.5; -7,-55.5; -7,20.2], style(color=5, rgbcolor={255,0,255}));
  end IdealInverter1phOpen;
end Examples;
