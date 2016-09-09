package PowerConverters "Power Electronics Converters" 
  model IdealCBSwitch "Basic two-cuadran current-bidirectional switch" 
    annotation (uses(Modelica(version="1.6")), Diagram);
    Interfaces.PositivePin p annotation (extent=[-110, -10; -90, 10]);
    Interfaces.NegativePin n annotation (extent=[110, -10; 90, 10]);
    Modelica.Electrical.Analog.Ideal.IdealSwitch idealSwitch 
      annotation (extent=[-10,-10; 10,10],rotation=0);
    Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode 
      annotation (extent=[-10,30; 10,50],   rotation=180);
    Modelica.Blocks.Interfaces.BooleanInPort firePort(final n=1) 
      annotation (extent=[-10,-110; 10,-90],  rotation=90);
    Control.Logical.Not not1 annotation (extent=[-10,-60; 10,-40], rotation=90);
  equation 
    connect(idealSwitch.p, p) 
      annotation (points=[-10,0; -100,0], style(color=3, rgbcolor={0,0,255}));
    connect(idealSwitch.n, n) 
      annotation (points=[10,0; 100,0], style(color=3, rgbcolor={0,0,255}));
    connect(idealDiode.p, idealSwitch.n) 
      annotation (points=[10,40; 10,0], style(color=3, rgbcolor={0,0,255}));
    connect(idealDiode.n, idealSwitch.p) 
      annotation (points=[-10,40; -10,0], style(color=3, rgbcolor={0,0,255}));
    connect(not1.inPort, firePort) annotation (points=[-7.34764e-016,-62; 0,-62; 0,
          -100], style(color=5, rgbcolor={255,0,255}));
    connect(not1.outPort, idealSwitch.control) annotation (points=[6.73533e-016,
          -39; 6.73533e-016,-16.5; 0,-16.5; 0,6], style(color=5, rgbcolor={255,
            0,255}));
  end IdealCBSwitch;
  
  model IdealTwoLevelBranch "Basic ideal two level switching branch" 
    Interfaces.PositivePin p annotation (extent=[-110, -10; -90, 10]);
    Interfaces.NegativePin n annotation (extent=[110, -10; 90, 10]);
    IdealCBSwitch idealCBSwitch annotation (extent=[-40,-10; -20,10]);
    IdealCBSwitch idealCBSwitch1 annotation (extent=[20,-10; 40,10]);
    annotation (Diagram);
    Modelica.Blocks.Interfaces.BooleanInPort firePort(final n=1) 
      annotation (extent=[-10,-114; 10,-94],  rotation=90);
    Interfaces.Pin control 
      "Control pin: control.v > level open, otherwise closed" annotation (
        extent=[-10, 90; 10, 110], rotation=90);
    Control.Logical.Not not1 annotation (extent=[20,-40; 40,-20], rotation=90);
  equation 
    connect(idealCBSwitch.n, idealCBSwitch1.p) 
      annotation (points=[-20,0; 20,0],   style(color=3, rgbcolor={0,0,255}));
    connect(idealCBSwitch.p, p) 
      annotation (points=[-40,0; -100,0], style(color=3, rgbcolor={0,0,255}));
    connect(idealCBSwitch1.n, n) 
      annotation (points=[40,0; 100,0], style(color=3, rgbcolor={0,0,255}));
    connect(firePort, idealCBSwitch.firePort) annotation (points=[0,-104; 0,-60;
          -30,-60; -30,-10], style(color=5, rgbcolor={255,0,255}));
    connect(not1.outPort, idealCBSwitch1.firePort) annotation (points=[30,-19;
          30,-10], style(color=5, rgbcolor={255,0,255}));
    connect(firePort, not1.inPort) annotation (points=[0,-104; 0,-60; 30,-60;
          30,-42], style(color=5, rgbcolor={255,0,255}));
    connect(control, idealCBSwitch.n) annotation (points=[0,100; 0,0; -20,0],
        style(color=3, rgbcolor={0,0,255}));
  end IdealTwoLevelBranch;
  
  model IdealHBridge "Basic ideal H-bridge topology" 
    Interfaces.Pin dcp "Positive pin of the DC port" 
      annotation (extent=[-110, 40;-90, 60]);
    Interfaces.Pin dcn "Negative pin of the DC port" 
      annotation (extent=[-110, -60; -90, -40]);
    Interfaces.Pin acp "Positive pin of the AC port" 
      annotation (extent=[90, 40;110, 60]);
    Interfaces.Pin acn "Negative pin of the AC port" 
      annotation (extent=[90, -60;110, -40]);
    IdealTwoLevelBranch idealTwoLevelBranch 
      annotation (extent=[0,20; 20,40], rotation=270);
    IdealTwoLevelBranch idealTwoLevelBranch1 
      annotation (extent=[40,-40; 60,-20], rotation=270);
    Modelica.Blocks.Interfaces.BooleanInPort firePort(final n=1) 
      annotation (extent=[-40,-108; -20,-88], rotation=90);
    Modelica.Blocks.Interfaces.BooleanInPort firePort1(
                                                      final n=1) 
      annotation (extent=[20,-108; 40,-88],   rotation=90);
  equation 
    
    annotation (Diagram);
    connect(dcp, idealTwoLevelBranch.p) annotation (points=[-100,50; 10,50; 10,
          40], style(color=3, rgbcolor={0,0,255}));
    connect(dcn, idealTwoLevelBranch.n) annotation (points=[-100,-50; 10,-50;
          10,20], style(color=3, rgbcolor={0,0,255}));
    connect(idealTwoLevelBranch.control, acp) annotation (points=[20,30; 80,30;
          80,50; 100,50], style(color=3, rgbcolor={0,0,255}));
    connect(idealTwoLevelBranch1.n, dcn) annotation (points=[50,-40; 50,-50;
          -100,-50], style(color=3, rgbcolor={0,0,255}));
    connect(idealTwoLevelBranch1.p, dcp) annotation (points=[50,-20; 50,50;
          -100,50], style(color=3, rgbcolor={0,0,255}));
    connect(idealTwoLevelBranch1.control, acn) annotation (points=[60,-30; 80,
          -30; 80,-50; 100,-50], style(color=3, rgbcolor={0,0,255}));
    connect(firePort, idealTwoLevelBranch.firePort) annotation (points=[-30,-98;
          -30,30; -0.4,30], style(color=5, rgbcolor={255,0,255}));
    connect(firePort1, idealTwoLevelBranch1.firePort) annotation (points=[30,-98;
          30,-30; 39.6,-30],      style(color=5, rgbcolor={255,0,255}));
  end IdealHBridge;
end PowerConverters;
