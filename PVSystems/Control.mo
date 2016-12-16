within PVSystems;
package Control "Control elements for power converters"
  extends Modelica.Icons.Library;
  block SignalPWM "Generates a pulse width modulated (PWM) boolean fire signal"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    // Parameters
    parameter Modelica.SIunits.Time period(final min=Modelica.Constants.small) = 1
      "Time for one period";
    // Interface
    Modelica.Blocks.Interfaces.RealInput duty annotation (Placement(
          transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
    Modelica.Blocks.Interfaces.BooleanOutput fire annotation (Placement(
          transformation(extent={{90,40},{110,60}}, rotation=0)));
    Modelica.Blocks.Interfaces.BooleanOutput notFire annotation (Placement(
          transformation(extent={{90,-60},{110,-40}}, rotation=0)));
    // Elements
    Modelica.Blocks.Sources.SawTooth sawTooth(period=period) annotation (Placement(
          transformation(extent={{-80,40},{-60,60}}, rotation=0)));
    Modelica.Blocks.Logical.Less lessBlock annotation (Placement(transformation(
            extent={{-20,40},{0,60}}, rotation=0)));
    Modelica.Blocks.Logical.Not notBlock annotation (Placement(transformation(
            extent={{40,-60},{60,-40}}, rotation=0)));
  equation
    connect(sawTooth.y, lessBlock.u1)
      annotation (Line(points={{-59,50},{-22,50}}, color={0,0,127}));
    connect(duty, lessBlock.u2) annotation (Line(points={{-100,0},{-40,0},{-40,
            42},{-22,42}}, color={0,0,127}));
    connect(lessBlock.y, fire) annotation (Line(points={{1,50},{48,50},{48,50},
            {100,50}}, color={255,0,255}));
    connect(notBlock.u, lessBlock.y) annotation (Line(points={{38,-50},{20,-50},
            {20,50},{1,50}}, color={255,0,255}));
    connect(notBlock.y, notFire) annotation (Line(points={{61,-50},{100,-50}},
          color={255,0,255}));
    annotation (
      Diagram(graphics),
      Icon(graphics={Text(
            extent={{-50,52},{56,-50}},
            lineColor={0,0,255},
            textString=
                 "PWM")}),
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
      annotation (Placement(transformation(extent={{-140,20},{-100,60}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput beta
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput d
      annotation (Placement(transformation(extent={{100,30},{120,50}}, rotation=
             0)));
    Modelica.Blocks.Interfaces.RealOutput q
      annotation (Placement(transformation(extent={{100,-50},{120,-30}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput theta
      annotation (Placement(transformation(
          origin={0,-120},
          extent={{-20,-20},{20,20}},
          rotation=90)));
  equation
    d = alpha*cos(theta) + beta*sin(theta);
    q = -alpha*sin(theta) + beta*cos(theta);
    annotation (
      Diagram(graphics),
      Icon(graphics={Text(
            extent={{-60,30},{60,-30}},
            lineColor={0,0,255},
            textString=
                 "AB2dq")}),
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
      annotation (Placement(transformation(extent={{-140,20},{-100,60}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput q
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput alpha
      annotation (Placement(transformation(extent={{100,30},{120,50}}, rotation=
             0)));
    Modelica.Blocks.Interfaces.RealOutput beta
      annotation (Placement(transformation(extent={{100,-50},{120,-30}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput theta
      annotation (Placement(transformation(
          origin={0,-120},
          extent={{-20,-20},{20,20}},
          rotation=90)));
  equation
    d = alpha*cos(theta) + beta*sin(theta);
    q = -alpha*sin(theta) + beta*cos(theta);
    annotation (
      Diagram(graphics),
      Icon(graphics={Text(
            extent={{-60,30},{60,-30}},
            lineColor={0,0,255},
            textString=
                 "dq2AB")}),
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
      annotation (Placement(transformation(extent={{60,-10},{80,10}}, rotation=
              0)));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=1e-3, k=100)
      annotation (Placement(transformation(extent={{-4,-10},{16,10}}, rotation=
              0)));
    Modelica.Blocks.Nonlinear.FixedDelay QuarterTDelay(delayTime=1/frequency/4)
      annotation (Placement(transformation(extent={{-80,-30},{-60,-10}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput v annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput theta
      annotation (Placement(transformation(extent={{100,-10},{120,10}},
            rotation=0)));
    Park park annotation (Placement(transformation(extent={{-40,-14},{-20,6}},
            rotation=0)));
    Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{
              30,48},{50,68}}, rotation=0)));
    Modelica.Blocks.Sources.Constant lineFreq(k=2*Modelica.Constants.pi*frequency)
      annotation (Placement(transformation(extent={{-30,54},{-10,74}}, rotation=
             0)));
  equation
    connect(v, park.alpha)
      annotation (Line(points={{-120,0},{-42,0}}, color={0,0,127}));
    connect(QuarterTDelay.y, park.beta)
      annotation (Line(points={{-59,-20},{-50,-20},{-50,-8},{-42,-8}}, color={0,
            0,127}));
    connect(QuarterTDelay.u, v)
      annotation (Line(points={{-82,-20},{-96,-20},{-96,0},{-120,0}}, color={0,
            0,127}));
    connect(integrator.y, theta)
      annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
    connect(park.theta, integrator.y)
      annotation (Line(points={{-30,-16},{-30,-30},{90,-30},{90,0},{81,0}},
          color={0,0,127}));
    connect(add.y, integrator.u)
      annotation (Line(points={{51,58},{54,58},{54,0},{58,0}}, color={0,0,127}));
    connect(firstOrder.y, add.u2)
      annotation (Line(points={{17,0},{22,0},{22,52},{28,52}}, color={0,0,127}));
    connect(lineFreq.y, add.u1)
      annotation (Line(points={{-9,64},{28,64}}, color={0,0,127}));
    connect(park.q, firstOrder.u) annotation (Line(points={{-19,-8},{-12,-8},{
            -12,0},{-6,0}}, color={0,0,127}));
    annotation (
      Diagram(graphics),
      Icon(graphics={Text(
            extent={{-60,30},{60,-30}},
            lineColor={0,0,255},
            textString=
                 "PLL")}),
      Documentation(info="<html>
        <p>
          Phase-locked loop. Given a sinusoidal input, extract the phase.
        </p>
      </html>"));
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
      Diagram(graphics),
      Icon(graphics={Text(
            extent={{-70,70},{70,20}},
            lineColor={0,0,255},
            textString=
                 "MPPT"), Text(
            extent={{-70,-20},{70,-70}},
            lineColor={0,0,255},
            textString=
                 "Controller")}),
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
    extends Modelica.Icons.UnderConstruction;
    Park park annotation (Placement(transformation(extent={{-50,-14},{-30,6}},
            rotation=0)));
    Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime=1/50/4)
      annotation (Placement(transformation(extent={{-88,-30},{-68,-10}},
            rotation=0)));
    Modelica.Blocks.Continuous.PI idPI(k=0.1, T=0.01)
      annotation (Placement(transformation(extent={{-8,50},{12,70}}, rotation=0)));
    Modelica.Blocks.Math.Feedback idFB annotation (Placement(transformation(
            extent={{-34,50},{-14,70}}, rotation=0)));
    Modelica.Blocks.Continuous.PI iqPI(k=0.1, T=0.01)
      annotation (Placement(transformation(extent={{-8,-70},{12,-50}}, rotation=
             0)));
    Modelica.Blocks.Math.Feedback iqFB annotation (Placement(transformation(
            extent={{-34,-50},{-14,-70}}, rotation=0)));
    InversePark inversePark annotation (Placement(transformation(extent={{24,
              -14},{44,6}}, rotation=0)));
    Modelica.Blocks.Sources.Constant dOffset(k=0.5)
      annotation (Placement(transformation(extent={{38,26},{58,46}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealInput i "Sensed current"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput idSetpoint
      "Current d component setpoint"
      annotation (Placement(transformation(extent={{-140,40},{-100,80}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput iqSetpoint
      "Current q component setpoint"
      annotation (Placement(transformation(extent={{-140,-80},{-100,-40}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput theta "Sensed AC voltage phase"
      annotation (Placement(transformation(
          origin={-40,-120},
          extent={{-20,-20},{20,20}},
          rotation=90)));
    Modelica.Blocks.Interfaces.RealInput udc "Sensed DC voltage"
      annotation (Placement(transformation(
          origin={40,-120},
          extent={{-20,-20},{20,20}},
          rotation=90)));
    Modelica.Blocks.Interfaces.RealOutput d "Duty cycle output"
      annotation (Placement(transformation(extent={{100,-10},{120,10}},
            rotation=0)));
    Modelica.Blocks.Math.Division division annotation (Placement(transformation(
            extent={{56,-16},{76,4}}, rotation=0)));
    Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{
              72,20},{92,40}}, rotation=0)));
  equation
    // Connections
    connect(park.beta,fixedDelay. y)
      annotation (Line(points={{-52,-8},{-60,-8},{-60,-20},{-67,-20}}, color={0,
            0,127}));
    connect(idFB.y,idPI. u)
      annotation (Line(points={{-15,60},{-10,60}}, color={0,0,127}));
    connect(park.d,idFB. u2)
      annotation (Line(points={{-29,0},{-24,0},{-24,52}}, color={0,0,127}));
    connect(iqFB.y,iqPI. u)
      annotation (Line(points={{-15,-60},{-10,-60}}, color={0,0,127}));
    connect(park.q,iqFB. u2)
      annotation (Line(points={{-29,-8},{-24,-8},{-24,-52}}, color={0,0,127}));
    connect(iqPI.y,inversePark. q)
      annotation (Line(points={{13,-60},{16,-60},{16,-8},{22,-8}}, color={0,0,
            127}));
    connect(idPI.y,inversePark. d)
      annotation (Line(points={{13,60},{16,60},{16,0},{22,0}}, color={0,0,127}));
    connect(i, park.alpha)
      annotation (Line(points={{-120,0},{-52,0}}, color={0,0,127}));
    connect(i, fixedDelay.u) annotation (Line(points={{-120,0},{-96,0},{-96,-20},
            {-90,-20}}, color={0,0,127}));
    connect(idSetpoint, idFB.u1) annotation (Line(points={{-120,60},{-32,60}},
          color={0,0,127}));
    connect(iqSetpoint, iqFB.u1) annotation (Line(points={{-120,-60},{-32,-60}},
          color={0,0,127}));
    connect(inversePark.theta, theta) annotation (Line(points={{34,-16},{34,-80},
            {-40,-80},{-40,-120}}, color={0,0,127}));
    connect(park.theta, theta) annotation (Line(points={{-40,-16},{-40,-120},{
            -40,-120}}, color={0,0,127}));
    connect(inversePark.alpha, division.u1)
      annotation (Line(points={{45,0},{54,0}}, color={0,0,127}));
    connect(udc, division.u2) annotation (Line(points={{40,-120},{40,-80},{48,
            -80},{48,-12},{54,-12}}, color={0,0,127}));
    connect(dOffset.y, add.u1)
      annotation (Line(points={{59,36},{70,36}}, color={0,0,127}));
    connect(division.y, add.u2) annotation (Line(points={{77,-6},{70,-6},{70,24}},
          color={0,0,127}));
    connect(add.y, d) annotation (Line(points={{93,30},{96,30},{96,0},{110,0}},
          color={0,0,127}));
    annotation (
      Diagram(graphics),
      Icon(graphics={Text(
            extent={{-70,25},{70,-25}},
            lineColor={0,0,255},
            textString=
                 "Control")}),
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
    extends Modelica.Icons.UnderConstruction;
    // Parameters
    parameter Real ik=0.2 "Current PI gain";
    parameter Modelica.SIunits.Time iT=0.02 "Current PI time constant";
    parameter Real vk=0.2 "Voltage PI gain";
    parameter Modelica.SIunits.Time vT=0.02 "Voltage PI time constant";
    parameter Modelica.SIunits.Frequency fline=50 "Line frequency";
    // Interface
    Modelica.Blocks.Interfaces.RealInput iac "AC current sense"
      annotation (Placement(transformation(extent={{-140,60},{-100,100}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput vac "AC voltage sense"
      annotation (Placement(transformation(extent={{-140,10},{-100,50}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput idc "DC current sense"
      annotation (Placement(transformation(extent={{-140,-50},{-100,-10}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput vdc "DC voltage sense"
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput d "Duty cycle"
      annotation (Placement(transformation(extent={{100,-10},{120,10}},
            rotation=0)));
    // Components
    Park park
      annotation (Placement(transformation(extent={{-54,66},{-34,86}}, rotation=
             0)));
    PLL pLL(frequency=fline)
      annotation (Placement(transformation(extent={{-80,20},{-60,40}}, rotation=
             0)));
    Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime=1/fline/4)
      annotation (Placement(transformation(extent={{-88,50},{-68,70}}, rotation=
             0)));
    Modelica.Blocks.Continuous.PI idPI(k=ik, T=iT)
      annotation (Placement(transformation(extent={{50,40},{70,60}}, rotation=0)));
    Modelica.Blocks.Math.Feedback idFB
      annotation (Placement(transformation(extent={{20,60},{40,40}}, rotation=0)));
    Modelica.Blocks.Continuous.PI iqPI(k=ik, T=iT)
      annotation (Placement(transformation(extent={{-8,-10},{12,10}}, rotation=
              0)));
    Modelica.Blocks.Math.Feedback iqFB
      annotation (Placement(transformation(extent={{-38,10},{-18,-10}},
            rotation=0)));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{-68,-10},{-48,10}},
            rotation=0)));
    PVSystems.Control.ControllerMPPT mPPTController
      annotation (Placement(transformation(extent={{-88,-26},{-68,-46}},
            rotation=0)));
    Modelica.Blocks.Continuous.PI vdcPI(k=vk, T=vT)
      annotation (Placement(transformation(extent={{-30,-46},{-10,-26}},
            rotation=0)));
    Modelica.Blocks.Math.Feedback iqFB1
      annotation (Placement(transformation(extent={{-60,-46},{-40,-26}},
            rotation=0)));
    InversePark inversePark
      annotation (Placement(transformation(extent={{72,-14},{92,6}}, rotation=0)));
  equation
    connect(pLL.v, vac)
      annotation (Line(points={{-82,30},{-120,30}}, color={0,0,127}));
    connect(pLL.theta, park.theta)
      annotation (Line(points={{-59,30},{-44,30},{-44,64}}, color={0,0,127}));
    connect(iac, fixedDelay.u)
      annotation (Line(points={{-120,80},{-96,80},{-96,60},{-90,60}}, color={0,
            0,127}));
    connect(park.alpha, iac)
      annotation (Line(points={{-56,80},{-120,80}}, color={0,0,127}));
    connect(park.beta, fixedDelay.y)
      annotation (Line(points={{-56,72},{-62,72},{-62,60},{-67,60}}, color={0,0,
            127}));
    connect(idFB.y, idPI.u)
      annotation (Line(points={{39,50},{48,50}}, color={0,0,127}));
    connect(park.d, idFB.u2)
      annotation (Line(points={{-33,80},{30,80},{30,58}}, color={0,0,127}));
    connect(iqFB.y, iqPI.u)
      annotation (Line(points={{-19,0},{-10,0}}, color={0,0,127}));
    connect(park.q, iqFB.u2)
      annotation (Line(points={{-33,72},{-28,72},{-28,8}}, color={0,0,127}));
    connect(const.y, iqFB.u1)
      annotation (Line(points={{-47,0},{-36,0}}, color={0,0,127}));
    connect(idc, mPPTController.u2)
      annotation (Line(points={{-120,-30},{-90,-30}}, color={0,0,127}));
    connect(vdc, mPPTController.u1)
      annotation (Line(points={{-120,-80},{-96,-80},{-96,-42},{-90,-42}}, color=
           {0,0,127}));
    connect(mPPTController.y, iqFB1.u1)
      annotation (Line(points={{-67,-36},{-58,-36}}, color={0,0,127}));
    connect(iqFB1.u2, vdc)
      annotation (Line(points={{-50,-44},{-50,-80},{-120,-80}}, color={0,0,127}));
    connect(iqFB1.y, vdcPI.u)
      annotation (Line(points={{-41,-36},{-32,-36}}, color={0,0,127}));
    connect(vdcPI.y, idFB.u1)
      annotation (Line(points={{-9,-36},{18,-36},{18,50},{22,50}}, color={0,0,
            127}));
    connect(inversePark.alpha, d)
      annotation (Line(points={{93,0},{110,0}}, color={0,0,127}));
    connect(iqPI.y, inversePark.q)
      annotation (Line(points={{13,0},{42,0},{42,-8},{70,-8}}, color={0,0,127}));
    connect(idPI.y, inversePark.d)
      annotation (Line(points={{71,50},{70,50},{70,0}}, color={0,0,127}));
    connect(pLL.theta, inversePark.theta)
      annotation (Line(points={{-59,30},{0,30},{0,-52},{82,-52},{82,-16}},
          color={0,0,127}));
    annotation (
      Diagram(graphics),
      Icon(graphics={Text(
            extent={{-70,70},{70,20}},
            lineColor={0,0,255},
            textString=
                 "Inverter"), Text(
            extent={{-70,-20},{70,-70}},
            lineColor={0,0,255},
            textString=
                 "Ctl")}),
      Documentation(info="<html>
      <p>
        Complete controller for monophasic inverter. Currently under
        construction.
      </p>
      </html>"));
  end ControllerInverter1ph;
end Control;
