within PVSystems.Examples.Application;
model Inverter1phOpen
  "Basic 1-phase open-loop inverter with constant DC voltage source and no synchronization"
  extends Modelica.Icons.Example;
  PVSystems.Electrical.Assemblies.HBridgeSwitched HBsw annotation (Placement(
        transformation(extent={{20,40},{40,60}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage dcsrc(V=500) annotation (
      Placement(transformation(
        origin={-80,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-90,14},{-70,34}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor ressw(R=2) annotation (Placement(
        transformation(
        origin={90,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor indsw(L=500e-6) annotation (
      Placement(transformation(
        origin={90,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Sine duty(
    amplitude=0.4,
    offset=0.5,
    freqHz=50) annotation (Placement(transformation(extent={{-100,-60},{-80,-40}},
          rotation=0)));
  Control.SignalPWM signalPWM(fs=3125) annotation (Placement(transformation(
          extent={{-40,0},{-20,20}}, rotation=0)));
  PVSystems.Electrical.Assemblies.HBridgeAveraged HBav annotation (Placement(
        transformation(extent={{20,-40},{40,-20}},rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor resav(R=2) annotation (Placement(
        transformation(
        origin={90,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor indav(L=500e-6) annotation (
      Placement(transformation(
        origin={90,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Control.DeadTime deadTime
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
equation
  connect(dcsrc.n, ground.p)
    annotation (Line(points={{-80,40},{-80,34}}, color={0,0,255}));
  connect(HBsw.dcn, dcsrc.n) annotation (Line(points={{20,45},{-46,45},{-46,40},
          {-80,40}},color={0,0,255}));
  connect(HBsw.dcp, dcsrc.p) annotation (Line(points={{20,55},{-46,55},{-46,60},
          {-80,60}},color={0,0,255}));
  connect(HBsw.acp, indsw.p) annotation (Line(points={{40,55},{56,55},{56,80},{
          90,80}}, color={0,0,255}));
  connect(HBsw.acn, ressw.n) annotation (Line(points={{40,45},{56,45},{56,20},{
          90,20}}, color={0,0,255}));
  connect(ressw.p, indsw.n) annotation (Line(points={{90,40},{90,46},{90,50},{
          90,60}}, color={0,0,255}));
  connect(resav.p, indav.n) annotation (Line(points={{90,-40},{90,-36},{90,-30},
          {90,-20}}, color={0,0,255}));
  connect(HBav.acp, indav.p) annotation (Line(points={{40,-25},{56,-25},{56,0},
          {90,0}},color={0,0,255}));
  connect(resav.n, HBav.acn) annotation (Line(points={{90,-60},{56,-60},{56,-35},
          {40,-35}}, color={0,0,255}));
  connect(HBav.d, duty.y)
    annotation (Line(points={{30,-42},{30,-50},{-79,-50}}, color={0,0,127}));
  connect(HBav.dcp, dcsrc.p) annotation (Line(points={{20,-25},{-52,-25},{-52,
          60},{-80,60}}, color={0,0,255}));
  connect(HBav.dcn, dcsrc.n) annotation (Line(points={{20,-35},{-60,-35},{-60,
          40},{-80,40}}, color={0,0,255}));
  connect(duty.y, signalPWM.vc) annotation (Line(points={{-79,-50},{-74,-50},{-70,
          -50},{-70,10},{-42,10}}, color={0,0,127}));
  connect(signalPWM.c1, deadTime.c)
    annotation (Line(points={{-19,10},{-10.5,10},{-2,10}}, color={255,0,255}));
  connect(deadTime.c1, HBsw.c1)
    annotation (Line(points={{21,14},{27,14},{27,40}}, color={255,0,255}));
  connect(deadTime.c2, HBsw.c2)
    annotation (Line(points={{21,6},{33,6},{33,40}}, color={255,0,255}));
  annotation (
    Diagram(graphics={Text(
          extent={{10,74},{48,62}},
          lineColor={0,0,255},
          textString="Switched model"),Text(
          extent={{12,-6},{50,-18}},
          lineColor={0,0,255},
          textString="Averaged model")}),
    experiment(
      StartTime=0,
      StopTime=0.05,
      Tolerance=1e-4),
    Documentation(info="<html>
      <p>
        IdealInverter1phOpen presents two implementations of an open loop
        1-phase inverter. The function of the inverter is to convert DC
        voltage and current into AC voltage and current. To keep things
        simple, a constant DC source is included on the DC side and an LC
        load is included on the AC side. Typically, inverters are placed
        inside a more complicated setup, which might require MPPT (Maximum
        Power Point Tracking) on the DC side when connected to a PV array
        and AC synchronization when connected to a grid on the AC side
        instead of just a simple passive load.
      </p>

      <p>
        Nevertheless, the example still showcases an interesting
        application. Upon running the simulation with the provided values,
        plotting the resistor voltage and current and the DC source voltage
        yields the following figure:
      </p>


      <div class=\"figure\">
        <p><img src=\"modelica://PVSystems/Resources/Images/Inverter1phOpenResults.png\"
                alt=\"Inverter1phOpenResults.png\" />
        </p>
      </div>

      <p>
        The AC is achieved with the inverter topology (called an H-bridge)
        as well as with the duty cycle sinusoidal modulation. Have a look at
        the duty cycle driving the SignalPWM block and compare it with the
        voltage drop in the resistor.
      </p>

      <p>
        Compare it with the voltage drop in the inductor. The voltage coming
        out of the inverter is actually a square wave and the inductor is
        providing some crude (but enough for some applications)
        filtering. Play around with the value of the inductor to see how it
        provides a better or worse filtering performance (decreasing or
        increasing the voltage and current ripple in the resistor, which in
        this example is assumed to be the load being fed). Since this is an
        open loop configuration, it will also change the peak value of the
        voltage drop in the resistor, as well as its phase.
      </p>

      <p>
        Importantly, see how the the average model provides a very good
        approximation for low frequencies. This kind of model won't be
        useful to study ripples and to evaluate the performance of different
        PWM modulations (sinusoidal modulation is being used in this
        example) or of different filter configurations, since those are
        concerned with the high frequencies in the system. On the other
        hand, the average models will be very useful to study controllers
        and to perform longer simulations since the simulation step doesn't
        need to be so small as to accurately represent the switching
        dynamics.
      </p>
      </html>"));
end Inverter1phOpen;
