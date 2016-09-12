package PowerConverters "Control elements for power converters" 
  
  block SignalPWM "Generates a pulse width modulated (PWM) boolean fire signal" 
    extends Interfaces.BlockIcon;
    parameter SI.Time Ts[:](final min=Modelica.Constants.small) = {1} 
      "Times for one period";
    Interfaces.InPort duty annotation (extent=[-110,-10; -90,10]);
    Sources.SawTooth sawTooth(period=Ts) annotation (extent=[-60,40; -40,60]);
    Logical.Less less annotation (extent=[-20,-4; 0,16]);
    Interfaces.BooleanOutPort fire annotation (extent=[90,40; 110,60]);
    Interfaces.BooleanOutPort notFire annotation (extent=[90,-60; 110,-40]);
    Logical.Not not1 annotation (extent=[40,-60; 60,-40]);
  equation 
    
    annotation (Diagram);
    connect(fire, fire) 
      annotation (points=[100,50; 100,50], style(color=5, rgbcolor={255,0,255}));
    connect(less.outPort, fire) annotation (points=[1,6; 20,6; 20,50; 100,50],
        style(color=5, rgbcolor={255,0,255}));
    connect(not1.inPort, less.outPort) annotation (points=[38,-50; 20,-50; 20,6; 
          1,6],  style(color=5, rgbcolor={255,0,255}));
    connect(not1.outPort, notFire) annotation (points=[61,-50; 100,-50], style(
          color=5, rgbcolor={255,0,255}));
    connect(duty, less.inPort2)
      annotation (points=[-100,0; -22,0], style(color=3, rgbcolor={0,0,255}));
    connect(less.inPort1, sawTooth.outPort) annotation (points=[-22,12; -30,12; 
          -30,50; -39,50], style(color=3, rgbcolor={0,0,255}));
  end SignalPWM;
end PowerConverters;
