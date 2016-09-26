package Electrical "Library for electrical models" 
  model PVArray "Flexible PV array model" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    // Interface
    Modelica.Blocks.Interfaces.RealInput G "Solar irradiation" 
      annotation(extent=[-45,-70;-15,-40],rotation=90);
    Modelica.Blocks.Interfaces.RealInput T "Panel temperature" 
      annotation(extent=[15,-70; 45,-40],rotation=90);
    // Constants
    constant Modelica.SIunits.Charge q=1.60217646e-19 "Electron charge";
    constant Real Gn=1000 "STC irradiation";
    constant Modelica.SIunits.Temperature Tn=298.15 "STC temperature";
    // Basic datasheet parameters
    parameter Modelica.SIunits.Current Imp=7.61 "Maximum power current";
    parameter Modelica.SIunits.Voltage Vmp=26.3 "Maximum power voltage";
    parameter Modelica.SIunits.Current Iscn=8.21 "Short circuit current";
    parameter Modelica.SIunits.Voltage Vocn=32.9 "Open circuit voltage";
    parameter Real Kv=-0.123 "Voc temperature coefficient";
    parameter Real Ki=3.18e-3 "Isc temperature coefficient";
    // Basic model parameters
    parameter Real Ns=54 "Number of cells in series";
    parameter Real Np=1 "Number of cells in parallel";
    parameter Modelica.SIunits.Resistance Rs=0.221 
      "Equivalent series resistance of array";
    parameter Modelica.SIunits.Resistance Rp=415.405 
      "Equivalent parallel resistance of array";
    parameter Real a=1.3 "Diode ideality constant";
    // Derived model parameters
    parameter Modelica.SIunits.Current Ipvn=Iscn "Photovoltaic current at STC";
    // Variables
    Modelica.SIunits.Voltage Vt "Thermal voltage of the array";
    Modelica.SIunits.Current Ipv "Photovoltaic current of the cell";
    Modelica.SIunits.Current I0 "Saturation current of the cell";
    Modelica.SIunits.Current Id "Diode current";
    Modelica.SIunits.Current Ir "Rp current";
  equation 
    // Auxiliary variables
    Vt = Ns*Modelica.Constants.k*T/q;
    Ipv = (Ipvn + Ki*(T-Tn)) * G/Gn;
    I0 = (Iscn + Ki*(T-Tn)) / (exp((Vocn+Kv*(T-Tn))/a/Vt) - 1);
    Id = I0 * (exp((v-Rs*i)/a/Vt) - 1);
    Ir = (v-Rs*i)/Rp;
    if v < 0 then
      i = v / ((Rs+Rp)/Np);
    elseif v > Vocn then
      i = 0;
    else
      i = -Np * (Ipv - Id - Ir);
    end if;
    annotation (
        Coordsys(
          extent=[-100,-100;100,100],
          grid=[2,2],
          component=[20,20]),
        Documentation(
          info="<html><p>Flexible PV array model. The model can be
  parametrized with the use of PV module datasheets. As a default, the
  data from the Kyocera KC200GT is provided. The model is presented in
  \"Comprehensive Approach to Modeling and Simulation of Photovoltaic
  Arrays\" by M.G. Villalva et al.</p></html>"),
        Icon(
          Line(points=[-90,0;-60,0], style(color=0)),
          Rectangle(extent=[-60,-40;60,40], style(color=0,fillColor=7)),
          Line(points=[-60,-40;-20,0], style(color=0)),
          Line(points=[-20,0;-60,40], style(color=0)),
          Line(points=[60,0;90,0], style(color=0))),
        Diagram);
  end PVArray;
  extends Modelica.Icons.Library;
  model IdealCBSwitch "Basic two-cuadrant current bidirectional switch" 
    extends Modelica.Electrical.Analog.Interfaces.TwoPin;
    // Components
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch 
      annotation(extent=[-10,-10; 10,10],rotation=0);
    Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode 
      annotation(extent=[-10,30; 10,50],rotation=180);
    Modelica.Blocks.Interfaces.BooleanInput fire 
      annotation(extent=[-10,-80; 10,-60],rotation=90);
  equation 
    connect(p, idealClosingSwitch.p) 
      annotation(points=[-100,0; -10,0],
        style(color=3, rgbcolor={0,0,255}));
    connect(idealClosingSwitch.n, n) 
      annotation(points=[10,0; 100,0],
        style(color=3, rgbcolor={0,0,255}));
    connect(idealDiode.p, n) 
      annotation(points=[10,40; 56,40; 56,0; 100,0],
        style(color=3,rgbcolor={0,0,255}));
    connect(idealDiode.n, p) 
      annotation(points=[-10,40; -54,40; -54,0; -100,0],
        style(color=3, rgbcolor={0,0,255}));
    connect(fire, idealClosingSwitch.control) 
      annotation(points=[0,-70; 0,7],
        style(color=5, rgbcolor={255,0,255}));
    annotation (
      Diagram,
      Icon(
        Line(points=[-98,0; -20,0], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-20,-20; 20,0; 100,0], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-40,0; -40,40; -20,40], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-20,40; 10,60; 10,20; -20,40], style(color=3, rgbcolor={0,0,255})),
        Line(points=[10,40; 40,40; 40,0], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-20,60; -20,20], style(color=3, rgbcolor={0,0,255})),
        Line(points=[0,-78; 0,-10], style(color=83, rgbcolor={255,85,255}))),
      Documentation(info="<html>
      <p>This model represents and idealized current bi-directional
      switch. This is the typical IGBT in anti-parallel with a diode from
      which many converters are built.</p>
      </html>"));
  end IdealCBSwitch;
  
  model Ideal2LevelLeg "Basic ideal two level switching leg" 
    extends Modelica.Electrical.Analog.Interfaces.TwoPin;
    // Interface
    Modelica.Blocks.Interfaces.BooleanInput fire annotation(extent=[-10,-80;10,-60],rotation=90);
    Modelica.Electrical.Analog.Interfaces.Pin midPoint annotation(extent=[-10,90;10,110],rotation=90);
    // Components
    Modelica.Blocks.Logical.Not notBlock annotation(extent=[20,-40;40,-20],rotation=90);
    IdealCBSwitch topSwitch annotation(extent=[-40,-10; -20,10]);
    IdealCBSwitch bottomSwitch annotation(extent=[20,-10; 40,10]);
    annotation(Diagram,
      Icon(
        Line(points=[-100,0; -60,0; -40,-10], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-40,0; 40,0; 60,-10], style(color=3, rgbcolor={0,0,255})),
        Line(points=[60,0; 100,0], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-70,0; -70,20; -56,20], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-56,28; -56,12], style(color=3, rgbcolor={0,0,255})),
        Line(points=[-40,20; -28,20; -28,0], style(color=3, rgbcolor={0,0,255})),
        Line(points=[28,0; 28,20; 42,20], style(color=3, rgbcolor={0,0,255})),
        Line(points=[42,28; 42,12], style(color=3, rgbcolor={0,0,255})),
        Line(points=[58,20; 70,20; 70,0], style(color=3, rgbcolor={0,0,255})),
        Line(points=[0,-80; 0,-40; -50,-40; -50,-6], style(color=83, rgbcolor={255,85,255})),
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
              rgbfillColor={255,255,255},                    fillPattern=1)),
        Line(points=[0,100; 0,0], style(color=3, rgbcolor={0,0,255}))),
                  Documentation(info="<html><p>This model composes
    IdealCBSwitch model into a two level leg, also very common in the
    constructoin of power converters. It provides input only for the
    firing signal of the top switch, generating the firing signal for
                              the bottom switch by logical negation.</p></html>"));
  equation 
    connect(p, topSwitch.p) 
      annotation (points=[-100,0; -40,0], style(color=3, rgbcolor={0,0,255}));
    connect(topSwitch.n, bottomSwitch.p) 
      annotation (points=[-20,0; 20,0], style(color=3, rgbcolor={0,0,255}));
    connect(bottomSwitch.n, n) 
      annotation (points=[40,0; 100,0], style(color=3, rgbcolor={0,0,255}));
    connect(fire, notBlock.u) annotation (points=[0,-70; 0,-52; 30,-52; 30,-42],
        style(color=5, rgbcolor={255,0,255}));
    connect(fire, topSwitch.fire) annotation (points=[0,-70; 0,-52; -30,-52;
          -30,-7], style(color=5, rgbcolor={255,0,255}));
    connect(notBlock.y, bottomSwitch.fire) annotation (points=[30,-19; 30,-7],
        style(color=5, rgbcolor={255,0,255}));
    connect(midPoint, topSwitch.n) annotation (points=[0,100; 0,0; -20,0],
        style(color=3, rgbcolor={0,0,255}));
  end Ideal2LevelLeg;
  
  model IdealAverageCCMSwitch 
    "Average switch model for any ideal 2-switch PWM converter in CCM" 
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    Modelica.Blocks.Interfaces.RealInput d "Duty cycle" 
      annotation(extent=[-20,-140; 20,-100], rotation=90);
  equation 
    v1 = (1-d)/d * v2;
    -i2 = (1-d)/d * i1;
    annotation (
      Diagram,
      Icon(
        Polygon(points=[60,20; 40,-20; 80,-20; 60,20],
          style(color=3,gradient=0,fillColor=7)),
        Line(points=[60,50; 60,-50]),
        Line(points=[60,50; 90,50]),
        Line(points=[80,20; 40,20],    style(color=3)),
        Text(extent=[-100, 100; 100, 70], string="%name"),
        Line(points=[60,-50; 90,-50]),
        Line(points=[-60,-50; -60,50]),
        Line(points=[-60,30; -80,30]),
        Line(points=[-48,30; -48,-30]),
        Line(points=[-80,0; -80,-50]),
        Line(points=[-90,-50; -80,-50]),
        Line(points=[-80,30; -80,50]),
        Line(points=[-90,50; -80,50]),
        Polygon(points=[-60,0; -70,5; -70,-5; -60,0], style(fillColor=3,
              fillPattern=1)),
        Line(points=[-60,-30; -80,-30]),
        Line(points=[-60,0; -80,0]),
        Polygon(points=[0,-40; -10,-60; 10,-60; 0,-40],
          style(color=3,gradient=0,fillColor=7)),
        Line(points=[0,-60; 0,-100]),
        Line(points=[0,0; 0,-40]),
        Line(points=[-46,0; 0,0])));
  end IdealAverageCCMSwitch;
  
  model IdealAverageDCMSwitch 
    "Average switch model for any ideal 2-switch PWM converter in DCM" 
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    parameter Modelica.SIunits.Inductance Le "Equivalent DCM inductance";
    parameter Modelica.SIunits.Frequency fs "Switching frequency";
    Modelica.Blocks.Interfaces.RealInput d "Duty cycle" 
      annotation(extent=[-20,-140; 20,-100], rotation=90);
    Real mu "Effective switch conversion ratio";
    Real Re "Equivalent DCM port 1 resistance";
  equation 
    Re = 2*Le*fs/d^2;
    mu = max(d,1/(1+Re*i1/v2));
    v1 = (1-mu)/mu * v2;
    -i2 = (1-mu)/mu * i1;
    annotation (
      Diagram,
      Icon(
        Polygon(points=[60,20; 40,-20; 80,-20; 60,20],
          style(color=3,gradient=0,fillColor=7)),
        Line(points=[60,50; 60,-50]),
        Line(points=[60,50; 90,50]),
        Line(points=[80,20; 40,20],    style(color=3)),
        Text(extent=[-100, 100; 100, 70], string="%name"),
        Line(points=[60,-50; 90,-50]),
        Line(points=[-60,-50; -60,50]),
        Line(points=[-60,30; -80,30]),
        Line(points=[-48,30; -48,-30]),
        Line(points=[-80,0; -80,-50]),
        Line(points=[-90,-50; -80,-50]),
        Line(points=[-80,30; -80,50]),
        Line(points=[-90,50; -80,50]),
        Polygon(points=[-60,0; -70,5; -70,-5; -60,0], style(fillColor=3,
              fillPattern=1)),
        Line(points=[-60,-30; -80,-30]),
        Line(points=[-60,0; -80,0]),
        Polygon(points=[0,-40; -10,-60; 10,-60; 0,-40],
          style(color=3,gradient=0,fillColor=7)),
        Line(points=[0,-60; 0,-100]),
        Line(points=[0,0; 0,-40]),
        Line(points=[-46,0; 0,0])));
  end IdealAverageDCMSwitch;
  
  model IdealHBridge "Basic ideal H-bridge topology (switched)" 
    // Interface
    Modelica.Electrical.Analog.Interfaces.Pin dcp "Positive pin of the DC port"
      annotation(extent=[-110,40;-90,60]);
    Modelica.Electrical.Analog.Interfaces.Pin dcn "Negative pin of the DC port"
      annotation(extent=[-110,-60;-90,-40]);
    Modelica.Electrical.Analog.Interfaces.Pin acp "Positive pin of the AC port"
      annotation(extent=[90,40;110,60]);
    Modelica.Electrical.Analog.Interfaces.Pin acn "Negative pin of the AC port"
      annotation(extent=[90,-60;110,-40]);
    Modelica.Blocks.Interfaces.BooleanInput fireA 
      annotation(extent=[-40,-110;-20,-90],rotation=90);
    Modelica.Blocks.Interfaces.BooleanInput fireB 
      annotation(extent=[20,-110;40,-90],rotation=90);
    Modelica.SIunits.Voltage vdc "DC voltage";
    Modelica.SIunits.Voltage vac "AC voltage";
    // Components
    Ideal2LevelLeg legA 
      annotation(extent=[0,20;20,40],rotation=270);
    Ideal2LevelLeg legB 
      annotation(extent=[40,-40;60,-20],rotation=270);
  equation 
    vdc = dcp.v - dcn.v;
    vac = acp.v - acn.v;
    connect(dcp, legA.p) 
      annotation(points=[-100,50; 10,50; 10,40], style(color=3, rgbcolor={0,0,255}));
    connect(legA.n, dcn) 
      annotation (points=[10,20; 10,-50; -100,-50], style(color=3, rgbcolor={0,0,255}));
    connect(legA.midPoint, acp) 
      annotation (points=[20,30; 60,30; 60,50; 100,50], style(color=3, rgbcolor={0,0,255}));
    connect(legB.midPoint, acn) 
      annotation (points=[60,-30; 80,-30; 80,-50; 100,-50], style(color=3, rgbcolor={0,0,255}));
    connect(fireA, legA.fire) 
      annotation (points=[-30,-100; -30,30; 3,30],style(color=5, rgbcolor={255,0,255}));
    connect(fireB, legB.fire) 
      annotation (points=[30,-100; 30,-30; 43,-30],style(color=5, rgbcolor={255,0,255}));
    connect(legB.p, dcp) 
      annotation (points=[50,-20; 50,50; -100,50], style(color=3, rgbcolor={0,0,255}));
    connect(legB.n, dcn) 
      annotation(points=[50,-40; 50,-50; -100,-50], style(color=3, rgbcolor={0,0,255}));
    annotation(Diagram, Icon(
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
              rgbfillColor={255,255,255},        fillPattern=1))),
                  Documentation(info="<html><p>This model further
    composes IdealTwoLevelBranch to form a typical H-bridge
    configuration from which a 1-phase inverter can be constructed.
    This model is based on discrete switch models.</p></html>"));
  end IdealHBridge;
  
  model IdealAverageHBridge "Basic ideal H-bridge topology (averaged)" 
    // Interface
    Modelica.Electrical.Analog.Interfaces.Pin dcp "Positive pin of the DC port"
      annotation(extent=[-110,40;-90,60]);
    Modelica.Electrical.Analog.Interfaces.Pin dcn "Negative pin of the DC port"
      annotation(extent=[-110,-60;-90,-40]);
    Modelica.Electrical.Analog.Interfaces.Pin acp "Positive pin of the AC port"
      annotation(extent=[90,40;110,60]);
    Modelica.Electrical.Analog.Interfaces.Pin acn "Negative pin of the AC port"
      annotation(extent=[90,-60;110,-40]);
    Modelica.Blocks.Interfaces.RealInput d 
      annotation (extent=[-20,-140; 20,-100], rotation=90);
    Modelica.SIunits.Voltage vdc "DC voltage";
    Modelica.SIunits.Voltage vac "AC voltage";
    // Components
    IdealAverageCCMSwitch s1 annotation (extent=[20,60; 40,80]);
    IdealAverageCCMSwitch s2 annotation (extent=[-40,-80; -20,-60]);
  equation 
    vdc = dcp.v - dcn.v;
    vac = acp.v - acn.v;
    connect(s1.p1, dcp) annotation (points=[20,75; -68,75; -68,50; -100,50],
        style(color=3, rgbcolor={0,0,255}));
    connect(s1.n1, acp) annotation (points=[20,65; 20,50; 100,50], style(color=
            3, rgbcolor={0,0,255}));
    connect(s2.n1, dcn) annotation (points=[-40,-75; -70,-75; -70,-50; -100,-50],
        style(color=3, rgbcolor={0,0,255}));
    connect(s2.p1, acn) annotation (points=[-40,-65; -48,-65; -48,-50; 100,-50],
        style(color=3, rgbcolor={0,0,255}));
    connect(s1.n2, dcn) annotation (points=[40,65; 40,-20; -100,-20; -100,-50],
        style(color=3, rgbcolor={0,0,255}));
    connect(u, s2.d) annotation (points=[0,-120; 0,-92; -30,-92; -30,-82],
        style(color=74, rgbcolor={0,0,127}));
    connect(u, s1.d) annotation (points=[0,-120; 0,30; 30,30; 30,58], style(
          color=74, rgbcolor={0,0,127}));
    connect(s2.p2, dcp) annotation (points=[-20,-65; -20,50; -100,50], style(
          color=3, rgbcolor={0,0,255}));
    connect(s1.p2, acp) annotation (points=[40,75; 70,75; 70,50; 100,50], style(
          color=3, rgbcolor={0,0,255}));
    connect(s2.n2, acn) annotation (points=[-20,-75; 42,-75; 42,-50; 100,-50],
        style(color=3, rgbcolor={0,0,255}));
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
              rgbfillColor={255,255,255},        fillPattern=1))),
                  Documentation(info="<html><p>This model further
    composes IdealAverageCCMSwitch to form a typical H-bridge
    configuration from which a 1-phase inverter can be constructed.
    This model is based in averaged switch models.</p></html>"));
  end IdealAverageHBridge;
end Electrical;
