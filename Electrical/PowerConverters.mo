package PowerConverters "Power Electronics Converters" 
  model IdealCBSwitch "Basic two-cuadran current-bidirectional switch" 
    annotation (uses(Modelica(version="1.6")), Diagram,
      Icon(
        Line(points=[-98,0; -20,0], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-20,-20; 20,0; 100,0], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-40,0; -40,40; -20,40], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-20,40; 10,60; 10,20; -20,40], style(color=3, rgbcolor={0,
                0,255})),
        Line(points=[10,40; 40,40; 40,0], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-20,60; -20,20], style(color=3, rgbcolor={0,0,255})),
        Line(points=[0,-78; 0,-10], style(color=83, rgbcolor={255,85,255}))));
    
    Interfaces.PositivePin p annotation (extent=[-110, -10; -90, 10]);
    Interfaces.NegativePin n annotation (extent=[110, -10; 90, 10]);
    Modelica.Electrical.Analog.Ideal.IdealSwitch idealSwitch 
      annotation (extent=[-10,-10; 10,10],rotation=0);
    Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode 
      annotation (extent=[-10,30; 10,50],   rotation=180);
    Modelica.Blocks.Interfaces.BooleanInPort firePort(final n=1) 
      annotation (extent=[-10,-80; 10,-60],   rotation=90);
    Control.Logical.Not not1 annotation (extent=[-10,-40; 10,-20], rotation=90);
  equation 
    connect(idealSwitch.p, p) 
      annotation (points=[-10,0; -100,0], style(color=3, rgbcolor={0,0,255}));
    connect(idealSwitch.n, n) 
      annotation (points=[10,0; 100,0], style(color=3, rgbcolor={0,0,255}));
    connect(idealDiode.p, idealSwitch.n) 
      annotation (points=[10,40; 10,0], style(color=3, rgbcolor={0,0,255}));
    connect(idealDiode.n, idealSwitch.p) 
      annotation (points=[-10,40; -10,0], style(color=3, rgbcolor={0,0,255}));
    connect(not1.inPort, firePort) annotation (points=[-7.34764e-016,-42; 0,-42;
          0,-70],style(color=5, rgbcolor={255,0,255}));
    connect(not1.outPort, idealSwitch.control) annotation (points=[6.73533e-016,
          -19; 6.73533e-016,-16.5; 0,-16.5; 0,6], style(color=5, rgbcolor={255,
            0,255}));
  end IdealCBSwitch;
  
  model IdealTwoLevelBranch "Basic ideal two level switching branch" 
    Interfaces.PositivePin p annotation (extent=[-110, -10; -90, 10]);
    Interfaces.NegativePin n annotation (extent=[110, -10; 90, 10]);
    IdealCBSwitch idealCBSwitch annotation (extent=[-40,-10; -20,10]);
    IdealCBSwitch idealCBSwitch1 annotation (extent=[20,-10; 40,10]);
    annotation (Diagram, Icon(
        Line(points=[-100,0; -60,0; -40,-10], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-40,0; 40,0; 60,-10], style(color=3, rgbcolor={0,0,255})),
        Line(points=[60,0; 100,0], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-70,0; -70,20; -56,20], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-56,28; -56,12], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-40,20; -28,20; -28,0], style(color=3, rgbcolor={0,0,255})),
        Line(points=[28,0; 28,20; 42,20], style(color=3, rgbcolor={0,0,255})),
        Line(points=[42,28; 42,12], style(color=3, rgbcolor={0,0,255})),
        Line(points=[58,20; 70,20; 70,0], style(color=3, rgbcolor={0,0,255})),
        Line(points=[0,-80; 0,-40; -50,-40; -50,-6], style(color=83, rgbcolor={
                255,85,255})),
        Line(points=[0,-40; 50,-40; 50,-6], style(color=83, rgbcolor={255,85,
                255})),
        Polygon(points=[54,-24; 46,-24; 50,-16; 54,-24], style(
            color=83,
            rgbcolor={255,85,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Ellipse(extent=[49,-16; 51,-18], style(
            color=83,
            rgbcolor={255,85,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Polygon(points=[-56,20; -40,10; -40,28; -56,20], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Polygon(points=[42,20; 58,10; 58,28; 42,20], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1))));
    
    Modelica.Blocks.Interfaces.BooleanInPort firePort(final n=1) 
      annotation (extent=[-10,-80; 10,-60],   rotation=90);
    Interfaces.Pin control 
      "Control pin: control.v > level open, otherwise closed" annotation (
        extent=[-10, 90; 10, 110], rotation=90);
    Control.Logical.Not notBlock 
                             annotation (extent=[20,-40; 40,-20], rotation=90);
  equation 
    connect(idealCBSwitch.n, idealCBSwitch1.p) 
      annotation (points=[-20,0; 20,0],   style(color=3, rgbcolor={0,0,255}));
    connect(idealCBSwitch.p, p) 
      annotation (points=[-40,0; -100,0], style(color=3, rgbcolor={0,0,255}));
    connect(idealCBSwitch1.n, n) 
      annotation (points=[40,0; 100,0], style(color=3, rgbcolor={0,0,255}));
    connect(firePort, idealCBSwitch.firePort) annotation (points=[0,-70; 0,-50;
          -30,-50; -30,-7],  style(color=5, rgbcolor={255,0,255}));
    connect(notBlock.outPort, idealCBSwitch1.firePort) 
                                                   annotation (points=[30,-19;
          30,-7],  style(color=5, rgbcolor={255,0,255}));
    connect(firePort, notBlock.inPort) 
                                   annotation (points=[0,-70; 0,-50; 30,-50; 30,
          -42],    style(color=5, rgbcolor={255,0,255}));
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
    Modelica.Blocks.Interfaces.BooleanInPort fireA(final n=1) 
      annotation (extent=[-40,-108; -20,-88], rotation=90);
    Modelica.Blocks.Interfaces.BooleanInPort fireB(final n=1) 
      annotation (extent=[20,-108; 40,-88],   rotation=90);
  equation 
    
    annotation (Diagram, Icon(
        Rectangle(extent=[-100,100; 100,-100], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-100,-100; 100,100], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=7,
            rgbfillColor={255,255,255})),
        Text(
          extent=[-76,38; 76,-22],
          style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1),
          string="1-ph"),
        Ellipse(extent=[2,-32; 38,-60], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-68,56; -10,56], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-68,76; -10,76], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[0,-82; 76,-82], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Ellipse(extent=[2,-36; 38,-64], style(
            pattern=0,
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Ellipse(extent=[38,-36; 74,-64], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Ellipse(extent=[38,-28; 74,-56], style(
            pattern=0,
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1))));
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
    connect(fireA, idealTwoLevelBranch.firePort)    annotation (points=[-30,-98;
          -30,30; 3,30],    style(color=5, rgbcolor={255,0,255}));
    connect(fireB, idealTwoLevelBranch1.firePort)     annotation (points=[30,-98;
          30,-30; 43,-30],        style(color=5, rgbcolor={255,0,255}));
  end IdealHBridge;
end PowerConverters;
