package Control "Control elements for power converters" 
  extends Modelica.Icons.Library;
  block SignalPWM "Generates a pulse width modulated (PWM) boolean fire signal" 
    extends Modelica.Blocks.Interfaces.BlockIcon;
    // Parameters
    parameter Modelica.SIunits.Time period(final min=Modelica.Constants.small) = 1 
      "Time for one period";
    // Interface
    Modelica.Blocks.Interfaces.RealInput duty annotation(extent=[-110,-10; -90,10]);
    Modelica.Blocks.Interfaces.BooleanOutput fire annotation(extent=[90,40; 110,60]);
    Modelica.Blocks.Interfaces.BooleanOutput notFire annotation(extent=[90,-60; 110,-40]);
    // Elements
    Modelica.Blocks.Sources.SawTooth sawTooth(period=period) annotation(extent=[-80,40;
          -60,60]);
    Modelica.Blocks.Logical.Less lessBlock annotation(extent=[-20,40; 0,60]);
    Modelica.Blocks.Logical.Not notBlock annotation(extent=[40,-60; 60,-40]);
    annotation (Diagram,
                  Icon(Text(extent=[-50,52; 56,-50],
                            style(color=3, rgbcolor={0,0,255}),
                            string="PWM")),
                  Documentation(info="<html><p>This block provides the switching
                              signal needed to drive the ideal switch models. It's
                              input <i>duty</i> receives the desired duty cycle and
                              the outputs <i>fire</i> and <i>notFire</i> provide the
                              PWM and negated PWM signals.</p></html>"));
  equation 
    connect(sawTooth.y, lessBlock.u1) 
      annotation (points=[-59,50; -22,50], style(color=74, rgbcolor={0,0,127}));
    connect(duty, lessBlock.u2) annotation (points=[-100,0; -40,0; -40,42; -22,42],
        style(color=74, rgbcolor={0,0,127}));
    connect(lessBlock.y, fire) annotation (points=[1,50; 48,50; 48,50; 100,50],
        style(color=5, rgbcolor={255,0,255}));
    connect(notBlock.u, lessBlock.y) annotation (points=[38,-50; 20,-50; 20,50; 1,
          50], style(color=5, rgbcolor={255,0,255}));
    connect(notBlock.y, notFire) annotation (points=[61,-50; 100,-50], style(
          color=5, rgbcolor={255,0,255}));
  end SignalPWM;
  
  model PLL "Phase-locked loop" 
    annotation (uses(Modelica(version="2.2.1")), Diagram);
    parameter Modelica.SIunits.Frequency frequency=50;
    Modelica.Blocks.Continuous.Integrator integrator 
      annotation (extent=[60,-10; 80,10]);
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=1e-3, k=100) 
      annotation (extent=[-4,-10; 16,10]);
    Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime=1/frequency/4) 
      annotation (extent=[-80,-30; -60,-10]);
    Modelica.Blocks.Interfaces.RealInput v annotation (extent=[-140,-20; -100,
          20]);
    Modelica.Blocks.Interfaces.RealOutput theta 
      annotation (extent=[100,-10; 120,10]);
    Park park annotation (extent=[-40,-14; -20,6]);
    Modelica.Blocks.Math.Add add annotation (extent=[30,48; 50,68]);
    Modelica.Blocks.Sources.Constant const(k=2*Modelica.Constants.pi*frequency) 
      annotation (extent=[-30,58; -10,78]);
  equation 
    connect(v, park.alpha) 
      annotation (points=[-120,0; -42,0],   style(color=74, rgbcolor={0,0,127}));
    connect(fixedDelay.y, park.beta) annotation (points=[-59,-20; -50,-20; -50,
          -8; -42,-8],
                  style(color=74, rgbcolor={0,0,127}));
    connect(fixedDelay.u, v) annotation (points=[-82,-20; -96,-20; -96,0; -120,
          0],  style(color=74, rgbcolor={0,0,127}));
    connect(integrator.y, theta) 
      annotation (points=[81,0; 110,0],   style(color=74, rgbcolor={0,0,127}));
    connect(park.theta, integrator.y) annotation (points=[-30,-16; -30,-30; 90,
          -30; 90,0; 81,0],
                         style(color=74, rgbcolor={0,0,127}));
    connect(add.y, integrator.u) annotation (points=[51,58; 54,58; 54,0; 58,0],
        style(color=74, rgbcolor={0,0,127}));
    connect(firstOrder.y, add.u2) annotation (points=[17,0; 22,0; 22,52; 28,52],
               style(color=74, rgbcolor={0,0,127}));
    connect(const.y, add.u1) annotation (points=[-9,68; 8,68; 8,64; 28,64],
        style(color=74, rgbcolor={0,0,127}));
    connect(park.d, firstOrder.u) annotation (points=[-19,0; -6,0],
                  style(color=74, rgbcolor={0,0,127}));
  end PLL;
  
  model Park "Park transformation" 
    
    annotation (uses(Modelica(version="2.2.1")), Diagram);
    Modelica.Blocks.Interfaces.RealInput alpha 
      annotation (extent=[-140,20; -100,60]);
    Modelica.Blocks.Interfaces.RealInput beta 
      annotation (extent=[-140,-60; -100,-20]);
    Modelica.Blocks.Interfaces.RealOutput d annotation (extent=[100,30; 120,50]);
    Modelica.Blocks.Interfaces.RealOutput q annotation (extent=[100,-50; 120,-30]);
    Modelica.Blocks.Interfaces.RealInput theta 
      annotation (extent=[-20,-140; 20,-100], rotation=90);
  equation 
    d = alpha*cos(theta) + beta*sin(theta);
    q = -alpha*sin(theta) + beta*cos(theta);
  end Park;
end Control;
