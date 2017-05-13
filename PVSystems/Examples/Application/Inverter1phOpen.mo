within PVSystems.Examples.Application;
model Inverter1phOpen
  "Basic 1-phase open-loop inverter with constant DC voltage source and no synchronization"
  extends Modelica.Icons.Example;
  Electrical.Assemblies.HBridgeSwitched
                                HBsw              annotation (Placement(
        transformation(extent={{20,40},{40,60}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage DCsw(V=580) annotation (
      Placement(transformation(
        origin={-10,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground gsw annotation (Placement(
        transformation(extent={{-20,14},{0,34}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor Rsw(R=1e-2)
                                                     annotation (Placement(
        transformation(
        origin={90,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor Lsw(L=1e-3)   annotation (Placement(
        transformation(
        origin={90,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Sine duty(
    offset=0.5,
    freqHz=50,
    amplitude=0.05)
               annotation (Placement(transformation(extent={{-100,-90},{-80,-70}},
          rotation=0)));
  PVSystems.Electrical.Assemblies.HBridge HBav annotation (Placement(
        transformation(extent={{20,-40},{40,-20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor Rav(R=1e-2)
                                                     annotation (Placement(
        transformation(
        origin={90,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor Lav(L=1e-3)   annotation (Placement(
        transformation(
        origin={90,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage DCav(V=580) annotation (
      Placement(transformation(
        origin={-10,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground gav annotation (Placement(
        transformation(extent={{-20,-66},{0,-46}}, rotation=0)));
  Control.SwitchingPWM switchingPWM(fs=3125)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Control.DeadTime deadTime annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,20})));
equation
  connect(DCsw.n, gsw.p)
    annotation (Line(points={{-10,40},{-10,34}}, color={0,0,255}));
  connect(HBsw.n1, DCsw.n) annotation (Line(points={{20,45},{10,45},{10,40},{-10,
          40}}, color={0,0,255}));
  connect(HBsw.p1, DCsw.p) annotation (Line(points={{20,55},{10,55},{10,60},{-10,
          60}}, color={0,0,255}));
  connect(HBsw.p2, Lsw.p) annotation (Line(points={{40,55},{60,55},{60,80},{90,
          80}}, color={0,0,255}));
  connect(HBsw.n2, Rsw.n) annotation (Line(points={{40,45},{60,45},{60,20},{90,
          20}}, color={0,0,255}));
  connect(Rsw.p, Lsw.n) annotation (Line(points={{90,40},{90,46},{90,50},{90,60}},
        color={0,0,255}));
  connect(Rav.p, Lav.n) annotation (Line(points={{90,-40},{90,-36},{90,-30},{90,
          -20}}, color={0,0,255}));
  connect(HBav.p2, Lav.p) annotation (Line(points={{40,-25},{60,-25},{60,0},{90,
          0}}, color={0,0,255}));
  connect(Rav.n, HBav.n2) annotation (Line(points={{90,-60},{60,-60},{60,-35},{
          40,-35}}, color={0,0,255}));
  connect(HBav.d, duty.y)
    annotation (Line(points={{30,-42},{30,-80},{-79,-80}}, color={0,0,127}));
  connect(DCav.n, gav.p)
    annotation (Line(points={{-10,-40},{-10,-43},{-10,-46}}, color={0,0,255}));
  connect(DCav.p, HBav.p1) annotation (Line(points={{-10,-20},{10,-20},{10,-25},
          {20,-25}}, color={0,0,255}));
  connect(DCav.n, HBav.n1) annotation (Line(points={{-10,-40},{10,-40},{10,-35},
          {20,-35}}, color={0,0,255}));
  connect(deadTime.c1, HBsw.c1)
    annotation (Line(points={{26,31},{26,35.5},{26,40}}, color={255,0,255}));
  connect(deadTime.c2, HBsw.c2)
    annotation (Line(points={{34,31},{34,40}}, color={255,0,255}));
  connect(switchingPWM.c1, deadTime.c)
    annotation (Line(points={{-19,0},{30,0},{30,8}}, color={255,0,255}));
  connect(switchingPWM.vc, duty.y) annotation (Line(points={{-42,0},{-60,0},{
          -60,-80},{-79,-80}}, color={0,0,127}));
  annotation (
    Diagram(graphics={Text(
          extent={{10,74},{48,62}},
          lineColor={0,0,255},
          textString="Switched model"),Text(
          extent={{12,-6},{50,-18}},
          lineColor={0,0,255},
          textString="Modifiable model")}),
    experiment(StopTime=0.5, __Dymola_NumberOfIntervals=5000),
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
