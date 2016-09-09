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
  
end Examples;
