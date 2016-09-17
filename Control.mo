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
end Control;
