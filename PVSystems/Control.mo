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
    annotation (
      Diagram,
      Icon(
        Text(
          extent=[-50,52; 56,-50],
          style(color=3, rgbcolor={0,0,255}),
          string="PWM")),
      Documentation(info="<html>
          <p>This block provides the switching
            signal needed to drive the ideal switch models. It's
             input <i>duty</i> receives the desired duty cycle and
             the outputs <i>fire</i> and <i>notFire</i> provide the
             PWM and negated PWM signals.
          </p>
        </html>"));
  end SignalPWM;
  
  block Park "Park transformation" 
    extends Modelica.Blocks.Interfaces.BlockIcon;
    Modelica.Blocks.Interfaces.RealInput alpha 
      annotation (extent=[-140,20; -100,60]);
    Modelica.Blocks.Interfaces.RealInput beta 
      annotation (extent=[-140,-60; -100,-20]);
    Modelica.Blocks.Interfaces.RealOutput d 
      annotation (extent=[100,30; 120,50]);
    Modelica.Blocks.Interfaces.RealOutput q 
      annotation (extent=[100,-50; 120,-30]);
    Modelica.Blocks.Interfaces.RealInput theta 
      annotation (extent=[-20,-140; 20,-100], rotation=90);
  equation 
    d = alpha*cos(theta) + beta*sin(theta);
    q = -alpha*sin(theta) + beta*cos(theta);
    annotation (
      Diagram,
      Icon(
        Text(
          extent=[-60,30;60,-30],
          style(color=3, rgbcolor={0,0,255}),
          string="AB2dq")),
      Documentation(info="<html>
        <p>
          Perform Park transformation. This transformation translates from the
          static reference frame (alfa-beta) to the synchronous reference
          frame (d-q).
        </p>
      </html>"));
  end Park;
  
  block InversePark "Inverse Park transformation" 
    extends Modelica.Blocks.Interfaces.BlockIcon;
    Modelica.Blocks.Interfaces.RealInput d 
      annotation (extent=[-140,20; -100,60]);
    Modelica.Blocks.Interfaces.RealInput q 
      annotation (extent=[-140,-60; -100,-20]);
    Modelica.Blocks.Interfaces.RealOutput alpha 
      annotation (extent=[100,30; 120,50]);
    Modelica.Blocks.Interfaces.RealOutput beta 
      annotation (extent=[100,-50; 120,-30]);
    Modelica.Blocks.Interfaces.RealInput theta 
      annotation (extent=[-20,-140; 20,-100], rotation=90);
  equation 
    d = alpha*cos(theta) + beta*sin(theta);
    q = -alpha*sin(theta) + beta*cos(theta);
    annotation (
      Diagram,
      Icon(
        Text(
          extent=[-60,30;60,-30],
          style(color=3, rgbcolor={0,0,255}),
          string="dq2AB")),
      Documentation(info="<html>
        <p>
          Perform inverse Park transformation. This transformation translates
          from the synchronous reference frame (d-q) to the static reference
          frame (alfa-beta).
        </p>
      </html>"));
  end InversePark;
  
  block PLL "Phase-locked loop" 
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Modelica.SIunits.Frequency frequency=50;
    Modelica.Blocks.Continuous.Integrator integrator 
      annotation (extent=[60,-10; 80,10]);
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=1e-3, k=100) 
      annotation (extent=[-4,-10; 16,10]);
    Modelica.Blocks.Nonlinear.FixedDelay QuarterTDelay(delayTime=1/frequency/4) 
      annotation (extent=[-80,-30; -60,-10]);
    Modelica.Blocks.Interfaces.RealInput v annotation (extent=[-140,-20; -100,
          20]);
    Modelica.Blocks.Interfaces.RealOutput theta 
      annotation (extent=[100,-10; 120,10]);
    Park park annotation (extent=[-40,-14; -20,6]);
    Modelica.Blocks.Math.Add add annotation (extent=[30,48; 50,68]);
    Modelica.Blocks.Sources.Constant lineFreq(k=2*Modelica.Constants.pi*frequency) 
      annotation (extent=[-30,54; -10,74]);
  equation 
    connect(v, park.alpha) 
      annotation(points=[-120,0; -42,0],
        style(color=74, rgbcolor={0,0,127}));
    connect(QuarterTDelay.y, park.beta) 
      annotation(points=[-59,-20; -50,-20; -50,-8; -42,-8],
        style(color=74, rgbcolor={0,0,127}));
    connect(QuarterTDelay.u, v) 
      annotation(points=[-82,-20; -96,-20; -96,0; -120,0],
        style(color=74, rgbcolor={0,0,127}));
    connect(integrator.y, theta) 
      annotation(points=[81,0; 110,0],
        style(color=74, rgbcolor={0,0,127}));
    connect(park.theta, integrator.y) 
      annotation(points=[-30,-16; -30,-30; 90,-30; 90,0; 81,0],
        style(color=74, rgbcolor={0,0,127}));
    connect(add.y, integrator.u) 
      annotation(points=[51,58; 54,58; 54,0; 58,0],
        style(color=74, rgbcolor={0,0,127}));
    connect(firstOrder.y, add.u2) 
      annotation(points=[17,0; 22,0; 22,52; 28,52],
        style(color=74, rgbcolor={0,0,127}));
    connect(lineFreq.y, add.u1) 
      annotation(points=[-9,64; 28,64],
        style(color=74, rgbcolor={0,0,127}));
    annotation (
      Diagram,
      Icon(
        Text(
          extent=[-60,30;60,-30],
          style(color=3, rgbcolor={0,0,255}),
          string="PLL")),
      Documentation(info="<html>
        <p>
          Phase-locked loop. Given a sinusoidal input, extract the phase.
        </p>
      </html>"));
    connect(park.q, firstOrder.u) annotation (points=[-19,-8; -12,-8; -12,0; -6,
          0], style(color=74, rgbcolor={0,0,127}));
  end PLL;
  
  block ControllerMPPT "Maximum Power Point Tracking Controller" 
    extends Modelica.Blocks.Interfaces.SI2SO;
    parameter Modelica.SIunits.Time sampleTime=1 "Sample time of control block";
    parameter Modelica.SIunits.Voltage vrefStep=5 "Step of change for vref";
    parameter Modelica.SIunits.Power pkThreshold=1 
      "Power threshold below which no change is considered";
  protected 
    Modelica.SIunits.Voltage vk;
    Modelica.SIunits.Current ik;
    Modelica.SIunits.Power pk;
    Modelica.SIunits.Voltage vref;
  equation 
    when sample(0,sampleTime) then
      if initial() then
        vk =  pre(u1);
        ik =  pre(u2);
        pk = vk*ik;
        vref = 10;
      else
        vk =  pre(u1);
        ik =  pre(u2);
        pk = vk*ik;
        if abs(pk-pre(pk)) < pkThreshold then
          // power unchanged => don't change vref
          vref = pre(vref);
        elseif pk-pre(pk) > 0 then
          // power increased => repeat last action
          vref = pre(vref) + vrefStep*sign(vk-pre(vk));
        else
          // power decreased => change last action
          vref = pre(vref) - vrefStep*sign(vk-pre(vk));
        end if;
      end if;
    end when;
    y = vref;
    annotation (
      Diagram,
      Icon(
        Text(
          extent=[-70,70; 70,20],
          style(color=3, rgbcolor={0,0,255}),
          string="MPPT"),
        Text(
          extent=[-70,-20; 70,-70],
          style(color=3, rgbcolor={0,0,255}),
          string="Controller")),
      Documentation(info="<html>
        <p>
          Maximum power-point tracking controller. Given the DC voltage and
          current, this controller will output a moving reference for a DC
          voltage control loop in order to maximize the power extracted from a
          PV array for a given (unknown) solar irradiation and junction
          temperature.
        </p>

        <p>
          The operation of the block can be customized by setting the
          following parameters:
        </p>

        <ul class=\"org-ul\">
          <li><i>sampleTime</i>: sample time of the control block. The control
            output will be updated with this period.
          </li>
          <li><i>vrefStep</i>: amount of change to vref when updated.
          </li>
          <li><i>pkThreshold</i>: amount of power below which it is considered
            that no change in power has occurred.
          </li>
        </ul>
      </html>"));
  end ControllerMPPT;
  
  block ControllerInverter1phCurrent 
    "Simple synchronous reference frame PI current controller" 
    extends Modelica.Blocks.Interfaces.BlockIcon;
    extends Icons.UnderConstruction;
    Park park annotation (extent=[-50,-14; -30,6]);
    Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime=1/50/4) 
      annotation (extent=[-88,-30; -68,-10]);
    Modelica.Blocks.Continuous.PI idPI(k=0.1, T=0.01) 
      annotation (extent=[-8,50; 12,70]);
    Modelica.Blocks.Math.Feedback idFB annotation (extent=[-34,50; -14,70]);
    Modelica.Blocks.Continuous.PI iqPI(k=0.1, T=0.01) 
      annotation (extent=[-8,-70; 12,-50]);
    Modelica.Blocks.Math.Feedback iqFB annotation (extent=[-34,-50; -14,-70]);
    InversePark inversePark annotation (extent=[24,-14; 44,6]);
    Modelica.Blocks.Sources.Constant dOffset(k=0.5) 
      annotation (extent=[38,26; 58,46]);
    Modelica.Blocks.Interfaces.RealInput i "Sensed current" 
      annotation (extent=[-140,-20; -100,20]);
    Modelica.Blocks.Interfaces.RealInput idSetpoint 
      "Current d component setpoint" 
      annotation (extent=[-140,40; -100,80]);
    Modelica.Blocks.Interfaces.RealInput iqSetpoint 
      "Current q component setpoint" 
      annotation (extent=[-140,-80; -100,-40]);
    Modelica.Blocks.Interfaces.RealInput theta "Sensed AC voltage phase" 
      annotation (extent=[-60,-140; -20,-100], rotation=90);
    Modelica.Blocks.Interfaces.RealInput udc "Sensed DC voltage" 
      annotation (extent=[20,-140; 60,-100], rotation=90);
    Modelica.Blocks.Interfaces.RealOutput d "Duty cycle output" 
      annotation (extent=[100,-10; 120,10]);
    Modelica.Blocks.Math.Division division annotation (extent=[56,-16; 76,4]);
    Modelica.Blocks.Math.Add add annotation (extent=[72,20; 92,40]);
  equation 
    // Connections
    connect(park.beta,fixedDelay. y) 
      annotation (points=[-52,-8; -60,-8; -60,-20; -67,-20],
        style(color=74, rgbcolor={0,0,127}));
    connect(idFB.y,idPI. u) 
      annotation (points=[-15,60; -10,60],
        style(color=74, rgbcolor={0,0,127}));
    connect(park.d,idFB. u2) 
      annotation (points=[-29,0; -24,0; -24,52],
        style(color=74, rgbcolor={0,0,127}));
    connect(iqFB.y,iqPI. u) 
      annotation(points=[-15,-60; -10,-60],
        style(color=74, rgbcolor={0,0,127}));
    connect(park.q,iqFB. u2) 
      annotation (points=[-29,-8; -24,-8; -24,-52],
        style(color=74, rgbcolor={0,0,127}));
    connect(iqPI.y,inversePark. q) 
      annotation(points=[13,-60; 16,-60; 16,-8; 22,-8],
        style(color=74, rgbcolor={0,0,127}));
    connect(idPI.y,inversePark. d) 
      annotation(points=[13,60; 16,60; 16,0; 22,0],
        style(color=74, rgbcolor={0,0,127}));
    connect(i, park.alpha) 
      annotation (points=[-120,0; -52,0], style(color=74, rgbcolor={0,0,127}));
    connect(i, fixedDelay.u) annotation (points=[-120,0; -96,0; -96,-20; -90,
          -20], style(color=74, rgbcolor={0,0,127}));
    connect(idSetpoint, idFB.u1) annotation (points=[-120,60; -32,60], style(
          color=74, rgbcolor={0,0,127}));
    connect(iqSetpoint, iqFB.u1) annotation (points=[-120,-60; -32,-60], style(
          color=74, rgbcolor={0,0,127}));
    connect(inversePark.theta, theta) annotation (points=[34,-16; 34,-80; -40,
          -80; -40,-120], style(color=74, rgbcolor={0,0,127}));
    connect(park.theta, theta) annotation (points=[-40,-16; -40,-120; -40,-120],
        style(color=74, rgbcolor={0,0,127}));
    connect(inversePark.alpha, division.u1) 
      annotation (points=[45,0; 54,0], style(color=74, rgbcolor={0,0,127}));
    connect(udc, division.u2) annotation (points=[40,-120; 40,-80; 48,-80; 48,
          -12; 54,-12], style(color=74, rgbcolor={0,0,127}));
    connect(dOffset.y, add.u1) 
      annotation (points=[59,36; 70,36], style(color=74, rgbcolor={0,0,127}));
    connect(division.y, add.u2) annotation (points=[77,-6; 70,-6; 70,24], style(
          color=74, rgbcolor={0,0,127}));
    connect(add.y, d) annotation (points=[93,30; 96,30; 96,0; 110,0], style(
          color=74, rgbcolor={0,0,127}));
    annotation (
      Diagram,
      Icon(
        Text(
          extent=[-70,25; 70,-25],
          style(color=3, rgbcolor={0,0,255}),
          string="Control")),
      Documentation(info="<html>
      <p>
        Partial current controller for monophasic inverter. Currently
        under construction.
      </p>
      </html>"));
  end ControllerInverter1phCurrent;
  
  block ControllerInverter1ph 
    "Complete synchronous reference frame inverter controller" 
    extends Modelica.Blocks.Interfaces.BlockIcon;
    extends Icons.UnderConstruction;
    // Parameters
    parameter Real ik=0.2 "Current PI gain";
    parameter Modelica.SIunits.Time iT=0.02 "Current PI time constant";
    parameter Real vk=0.2 "Voltage PI gain";
    parameter Modelica.SIunits.Time vT=0.02 "Voltage PI time constant";
    parameter Modelica.SIunits.Frequency fline=50 "Line frequency";
    // Interface
    Modelica.Blocks.Interfaces.RealInput iac "AC current sense" 
      annotation(extent=[-140,60; -100,100]);
    Modelica.Blocks.Interfaces.RealInput vac "AC voltage sense" 
      annotation(extent=[-140,10; -100,50]);
    Modelica.Blocks.Interfaces.RealInput idc "DC current sense" 
      annotation(extent=[-140,-50; -100,-10]);
    Modelica.Blocks.Interfaces.RealInput vdc "DC voltage sense" 
      annotation(extent=[-140,-100; -100,-60]);
    Modelica.Blocks.Interfaces.RealOutput d "Duty cycle" 
      annotation(extent=[100,-10; 120,10]);
    // Components
    Park park 
      annotation(extent=[-54,66; -34,86]);
    PLL pLL(frequency=fline) 
      annotation(extent=[-80,20; -60,40]);
    Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime=1/fline/4) 
      annotation(extent=[-88,50; -68,70]);
    Modelica.Blocks.Continuous.PI idPI(k=ik, T=iT) 
      annotation(extent=[50,40; 70,60]);
    Modelica.Blocks.Math.Feedback idFB 
      annotation(extent=[20,60; 40,40]);
    Modelica.Blocks.Continuous.PI iqPI(k=ik, T=iT) 
      annotation(extent=[-8,-10; 12,10]);
    Modelica.Blocks.Math.Feedback iqFB 
      annotation(extent=[-38,10; -18,-10]);
    Modelica.Blocks.Sources.Constant const(k=0) 
      annotation(extent=[-68,-10; -48,10]);
    PVSystems.Control.ControllerMPPT mPPTController 
      annotation(extent=[-88,-26; -68,-46]);
    Modelica.Blocks.Continuous.PI vdcPI(k=vk, T=vT) 
      annotation(extent=[-30,-46; -10,-26]);
    Modelica.Blocks.Math.Feedback iqFB1 
      annotation(extent=[-60,-46; -40,-26]);
    InversePark inversePark 
      annotation(extent=[72,-14; 92,6]);
  equation 
    connect(pLL.v, vac) 
      annotation(points=[-82,30; -120,30],
        style(color=74, rgbcolor={0,0,127}));
    connect(pLL.theta, park.theta) 
      annotation(points=[-59,30; -44,30; -44,64],
        style(color=74, rgbcolor={0,0,127}));
    connect(iac, fixedDelay.u) 
      annotation(points=[-120,80; -96,80; -96,60; -90,60],
        style(color=74, rgbcolor={0,0,127}));
    connect(park.alpha, iac) 
      annotation(points=[-56,80; -120,80],
        style(color=74,rgbcolor={0,0,127}));
    connect(park.beta, fixedDelay.y) 
      annotation (points=[-56,72; -62,72; -62,60;-67,60],
        style(color=74, rgbcolor={0,0,127}));
    connect(idFB.y, idPI.u) 
      annotation (points=[39,50; 48,50],
        style(color=74, rgbcolor={0,0,127}));
    connect(park.d, idFB.u2) 
      annotation (points=[-33,80; 30,80; 30,58],
        style(color=74, rgbcolor={0,0,127}));
    connect(iqFB.y, iqPI.u) 
      annotation(points=[-19,0; -10,0],
        style(color=74, rgbcolor={0,0,127}));
    connect(park.q, iqFB.u2) 
      annotation (points=[-33,72; -28,72; -28,8],
        style(color=74, rgbcolor={0,0,127}));
    connect(const.y, iqFB.u1) 
      annotation(points=[-47,0; -36,0],
        style(color=74, rgbcolor={0,0,127}));
    connect(idc, mPPTController.u2) 
      annotation(points=[-120,-30; -90,-30],
        style(color=74, rgbcolor={0,0,127}));
    connect(vdc, mPPTController.u1) 
      annotation (points=[-120,-80; -96,-80; -96,-42; -90,-42],
        style(color=74, rgbcolor={0,0,127}));
    connect(mPPTController.y, iqFB1.u1) 
      annotation(points=[-67,-36; -58,-36],
        style(color=74, rgbcolor={0,0,127}));
    connect(iqFB1.u2, vdc) 
      annotation (points=[-50,-44; -50,-80; -120,-80],
        style(color=74, rgbcolor={0,0,127}));
    connect(iqFB1.y, vdcPI.u) 
      annotation(points=[-41,-36; -32,-36],
        style(color=74, rgbcolor={0,0,127}));
    connect(vdcPI.y, idFB.u1) 
      annotation(points=[-9,-36; 18,-36; 18,50; 22,50],
        style(color=74, rgbcolor={0,0,127}));
    connect(inversePark.alpha, d) 
      annotation(points=[93,0; 110,0],
        style(color=74, rgbcolor={0,0,127}));
    connect(iqPI.y, inversePark.q) 
      annotation(points=[13,0; 42,0; 42,-8; 70,-8],
        style(color=74, rgbcolor={0,0,127}));
    connect(idPI.y, inversePark.d) 
      annotation(points=[71,50; 70,50; 70,0],
        style(color=74, rgbcolor={0,0,127}));
    connect(pLL.theta, inversePark.theta) 
      annotation(points=[-59,30; 0,30; 0,-52;82,-52; 82,-16],
        style(color=74, rgbcolor={0,0,127}));
    annotation (
      Diagram,
      Icon(
        Text(
          extent=[-70,70; 70,20],
          style(color=3, rgbcolor={0,0,255}),
          string="Inverter"),
        Text(
          extent=[-70,-20; 70,-70],
          style(color=3, rgbcolor={0,0,255}),
          string="Ctl")),
      Documentation(info="<html>
      <p>
        Complete controller for monophasic inverter. Currently under
        construction.
      </p>
      </html>"));
  end ControllerInverter1ph;
end Control;
