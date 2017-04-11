within PVSystems.Examples.Application;
model Inverter1phClosed
  "Basic 1-phase closed-loop inverter with constant DC voltage source and no synchronization"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Sources.ConstantVoltage dcsrc(V=500) annotation (
      Placement(transformation(
        origin={-20,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-30,34},{-10,54}}, rotation=0)));
  PVSystems.Electrical.Assemblies.HBridgeAveraged HBav annotation (Placement(
        transformation(extent={{20,60},{40,80}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor resav(R=0.1) annotation (Placement(
        transformation(
        origin={90,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor indav(L=500e-6) annotation (
      Placement(transformation(
        origin={90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Step iqSetpoint(height=14.14, startTime=0.2)
    annotation (Placement(transformation(extent={{0,-30},{20,-10}}, rotation=0)));
  Modelica.Blocks.Sources.Step idSetpoint(
    offset=20,
    startTime=0.2,
    height=14.14 - 20) annotation (Placement(transformation(extent={{0,-64},{20,
            -44}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor CSac annotation (Placement(
        transformation(
        origin={60,40},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.Blocks.Sources.SawTooth sawTooth(amplitude=2*Modelica.Constants.pi,
      period=0.02) annotation (Placement(transformation(extent={{-92,-4},{-72,
            16}}, rotation=0)));
  Modelica.Blocks.Math.Cos cos annotation (Placement(transformation(extent={{-50,
            -100},{-30,-80}}, rotation=0)));
  Modelica.Blocks.Math.Gain gain(k=50) annotation (Placement(transformation(
          extent={{-20,-100},{0,-80}}, rotation=0)));
  Control.Assemblies.ControllerInverter1phCurrent control annotation (Placement(
        transformation(
        origin={30,10},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor VSdc annotation (Placement(
        transformation(
        origin={-50,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(dcsrc.n, ground.p) annotation (Line(points={{-20,60},{-20,57},{-20,57},
          {-20,54}}, color={0,0,255}));
  connect(resav.p, indav.n)
    annotation (Line(points={{90,60},{90,80}}, color={0,0,255}));
  connect(HBav.dcp, dcsrc.p) annotation (Line(points={{20,75},{0,75},{0,80},{-20,
          80}}, color={0,0,255}));
  connect(HBav.dcn, dcsrc.n) annotation (Line(points={{20,65},{0,65},{0,60},{-20,
          60}}, color={0,0,255}));
  connect(CSac.p, resav.n)
    annotation (Line(points={{70,40},{90,40}}, color={0,0,255}));
  connect(HBav.acn, CSac.n) annotation (Line(points={{40,65},{46,65},{46,40},{
          50,40}}, color={0,0,255}));
  connect(HBav.acp, indav.p) annotation (Line(points={{40,75},{46,75},{46,100},
          {90,100}}, color={0,0,255}));
  connect(cos.u, sawTooth.y) annotation (Line(points={{-52,-90},{-60,-90},{-60,
          6},{-71,6}}, color={0,0,127}));
  connect(cos.y, gain.u)
    annotation (Line(points={{-29,-90},{-22,-90}}, color={0,0,127}));
  connect(control.d, HBav.d)
    annotation (Line(points={{30,21},{30,58}}, color={0,0,127}));
  connect(CSac.i, control.i) annotation (Line(points={{60,30},{60,-20},{30,-20},
          {30,-2}}, color={0,0,127}));
  connect(iqSetpoint.y, control.iqSetpoint)
    annotation (Line(points={{21,-20},{24,-20},{24,-2}}, color={0,0,127}));
  connect(idSetpoint.y, control.idSetpoint)
    annotation (Line(points={{21,-54},{36,-54},{36,-2}}, color={0,0,127}));
  connect(control.theta, sawTooth.y)
    annotation (Line(points={{18,6},{-26.5,6},{-71,6}}, color={0,0,127}));
  connect(VSdc.p, dcsrc.p)
    annotation (Line(points={{-50,80},{-20,80}}, color={0,0,255}));
  connect(VSdc.n, dcsrc.n)
    annotation (Line(points={{-50,60},{-20,60}}, color={0,0,255}));
  connect(VSdc.v, control.udc) annotation (Line(points={{-60,70},{-66,70},{-66,
          14},{18,14}}, color={0,0,127}));
  annotation (
    Diagram(graphics),
    experiment(
      StartTime=0,
      StopTime=0.4,
      Tolerance=1e-4),
    Documentation(info="<html>
      <p>
        This example explores a closed-loop inverter. No grid is present,
        which simplifies things. But, since the controller is implemented in
        the synchronous (dq) refrecen frame, a synchronization source needs
        to exist. This is implemented with the saw tooth generator, which
        emulates the output of the PLL.
      </p>

      <p>
        As can be seen in the following figure, one can now comfortably
        specify the setpoint for the output current of the inverter:
      </p>

      <div class=\"figure\">
        <p><img src=\"modelica://PVSystems/Resources/Images/Inverter1phClosedResults.png\"
                alt=\"Inverter1phClosedResults.png\" />
        </p>
      </div>

      <p>
        Having the posibility to separately control the current in each dq
        axis enables one to control the power factor (i.e. the phase lag
        between the voltage and the current) as well as the amplitude of the
        current.
      </p>

      <p>
        In this example, the equivalent synchronization signal is plotted to
        see this phase shift as the setpoints change. Notice how, when the q
        component of the current is 0, the d component is equal to the peak
        current.
      </p>
      </html>"));
end Inverter1phClosed;
