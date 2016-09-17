package Examples "Application and validation examples" 
  extends Modelica.Icons.Library;
  
    model PVArrayValidation "Model to validate PVArray" 
      extends Modelica.Icons.Example;
      Modelica.Electrical.Analog.Sources.RampVoltage rampVoltage(duration=1,V=45,offset=-10) annotation(extent=[30,0; 50,20],rotation=270);
      Modelica.Electrical.Analog.Basic.Ground ground annotation(extent=[30,-40;50,-20]);
      Electrical.PVArray pVArray annotation(extent=[-10,0;10,20],rotation=270);
      Modelica.Blocks.Sources.Constant Gn(k=1000) annotation(extent=[-50,10;-30,30]);
      Modelica.Blocks.Sources.Constant Tn(k=298.15) annotation(extent=[-50,-24;-30,-4]);
      annotation (Diagram);
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
    annotation (Diagram);
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
    annotation(Diagram,experiment(StopTime=0.02));
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
    connect(signalPWM.fire, idealClosingSwitch.control) annotation (points=[40,
          55; 60,55; 60,10; -33,10], style(color=5, rgbcolor={255,0,255}));
  end IdealBuckOpen;

  model SignalPWMValidation "Simple model to validate SignalPWM behaviour" 
    extends Modelica.Icons.Example;
    Control.SignalPWM signalPWM(period=0.01) annotation(extent=[20,0; 40,20]);
    Modelica.Blocks.Sources.Step step(height=0.3,offset=0.2,startTime=0.3) annotation(extent=[-80,20; -60,40]);
    Modelica.Blocks.Sources.Step step1(height=0.3,startTime=0.6) annotation(extent=[-80,-20;-60,0]);
    Modelica.Blocks.Math.Add add annotation(extent=[-20,0;0,20]);
    annotation(Diagram);
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
    Modelica.Blocks.Sources.Sine sine(amplitude=0.4,freqHz=50,offset=0.5) annotation(extent=[-80,-60;-60,-40]);
    Control.SignalPWM signalPWM(period=320e-6) annotation(extent=[-40,-60;-20,-40]);
    annotation(Diagram, experiment(StopTime=0.5));
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
