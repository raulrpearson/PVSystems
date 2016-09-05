package Validation "Unit testing of the library's elements" 
  model PVArrayValidation "Model to validate PVArray" 
    Electrical.Sources.RampVoltage rampVoltage(V=32.9, offset=0) 
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
end Validation;
