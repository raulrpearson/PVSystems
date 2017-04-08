within PVSystems.Examples.Application;
model Inverter1phOpen
  "Basic 1-phase open-loop inverter with constant DC voltage source and no synchronization"
  extends Modelica.Icons.Example;
  PVSystems.Electrical.Assemblies.HBridgeSwitched HBsw
    annotation (Placement(transformation(extent={{0,40},{20,60}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage dcsrc(V=500) annotation (
      Placement(transformation(
        origin={-60,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-70,14},{-50,34}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor ressw(R=2) annotation (Placement(
        transformation(
        origin={70,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor indsw(L=500e-6) annotation (
      Placement(transformation(
        origin={70,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Sine duty(
    amplitude=0.4,
    offset=0.5,
    freqHz=50) annotation (Placement(transformation(extent={{-80,-60},{-60,-40}},
          rotation=0)));
  Control.SignalPWM signalPWM(fs=3125, provideComplement=true)
    annotation (Placement(transformation(extent={{-20,0},{0,20}}, rotation=0)));
  PVSystems.Electrical.Assemblies.HBridgeAveraged HBav annotation (Placement(
        transformation(extent={{0,-40},{20,-20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor resav(R=2) annotation (Placement(
        transformation(
        origin={70,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor indav(L=500e-6) annotation (
      Placement(transformation(
        origin={70,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(dcsrc.n, ground.p)
    annotation (Line(points={{-60,40},{-60,34}}, color={0,0,255}));
  connect(HBsw.dcn, dcsrc.n) annotation (Line(points={{0,45},{-26,45},{-26,40},
          {-60,40}},color={0,0,255}));
  connect(HBsw.dcp, dcsrc.p) annotation (Line(points={{0,55},{-26,55},{-26,60},
          {-60,60}},color={0,0,255}));
  connect(HBsw.acp, indsw.p) annotation (Line(points={{20,55},{40,55},{40,80},{
          70,80}}, color={0,0,255}));
  connect(HBsw.acn, ressw.n) annotation (Line(points={{20,45},{40,45},{40,20},{
          70,20}}, color={0,0,255}));
  connect(ressw.p, indsw.n)
    annotation (Line(points={{70,40},{70,60}}, color={0,0,255}));
  connect(resav.p, indav.n)
    annotation (Line(points={{70,-40},{70,-20}}, color={0,0,255}));
  connect(HBav.acp, indav.p) annotation (Line(points={{20,-25},{40,-25},{40,0},
          {70,0}},color={0,0,255}));
  connect(resav.n, HBav.acn) annotation (Line(points={{70,-60},{40,-60},{40,-35},
          {20,-35}}, color={0,0,255}));
  connect(HBav.d, duty.y)
    annotation (Line(points={{10,-42},{10,-50},{-59,-50}}, color={0,0,127}));
  connect(HBav.dcp, dcsrc.p) annotation (Line(points={{0,-25},{-32,-25},{-32,60},
          {-60,60}}, color={0,0,255}));
  connect(HBav.dcn, dcsrc.n) annotation (Line(points={{0,-35},{-40,-35},{-40,40},
          {-60,40}}, color={0,0,255}));
  connect(signalPWM.c2, HBsw.fireB)
    annotation (Line(points={{1,2},{13,2},{13,40}}, color={255,0,255}));
  connect(signalPWM.c1, HBsw.fireA)
    annotation (Line(points={{1,10},{7,10},{7,40}}, color={255,0,255}));
  connect(duty.y, signalPWM.vc) annotation (Line(points={{-59,-50},{-54,-50},{
          -50,-50},{-50,10},{-22,10}}, color={0,0,127}));
  annotation (
    Diagram(graphics={Text(
          extent={{-10,74},{28,62}},
          lineColor={0,0,255},
          textString="Switched model"),Text(
          extent={{-8,-6},{30,-18}},
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
