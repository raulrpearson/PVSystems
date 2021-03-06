within PVSystems.Examples.Application;
model USBBatteryConverter "Bidirectional converter for USB battery interface"
  extends Modelica.Icons.Example;
  Electrical.Assemblies.CPMBidirectionalBuckBoost conv(
    Cin=10e-6,
    Cout=88e-6,
    L=10e-6,
    Rf=1,
    fs=200e3,
    RL=8e-3,
    Va_buck=0.5,
    Va_boost=1,
    vCin_ini=12.6,
    vCout_ini=5,
    iL_ini=2) annotation (Placement(transformation(extent={{4,60},{24,80}})));
  Modelica.Blocks.Sources.RealExpression boostVs(y=20)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Blocks.Sources.RealExpression buckVs(y=5)
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Electrical.Analog.Basic.Resistor Rbatt(R=50e-3)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Blocks.Continuous.LimPID buckPI(
    k=10,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1,
    yMin=0,
    yMax=8) annotation (Placement(transformation(extent={{-30,-30},{-10,-50}})));
  Modelica.Blocks.Sources.RealExpression voutSense(y=conv.v2)
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Modelica.Blocks.Continuous.LimPID boostPI(
    k=10,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1,
    yMin=0,
    yMax=8) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Logical.Switch modeSelector annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,30})));
  Modelica.Electrical.Analog.Basic.VariableResistor Rload annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,70})));
  Modelica.Electrical.Analog.Sources.SignalVoltage Vbatt annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-50,70})));
  Modelica.Blocks.Sources.Ramp VbattSignal(
    duration=0.1,
    startTime=10,
    offset=12.6,
    height=9.6 - 12.6)
    annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
  Modelica.Blocks.Sources.Ramp RloadSignal(
    duration=0.1,
    startTime=10,
    offset=2.5,
    height=6.67 - 2.5)
    annotation (Placement(transformation(extent={{90,60},{70,80}})));
  Modelica.Blocks.Sources.BooleanExpression modeCommand(y=time > 10)
    annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
equation
  connect(Rbatt.n, conv.p1) annotation (Line(points={{-20,80},{-6,80},{-6,75},{
          4,75}}, color={0,0,255}));
  connect(buckVs.y, buckPI.u_s)
    annotation (Line(points={{-49,-40},{-32,-40}}, color={0,0,127}));
  connect(voutSense.y, buckPI.u_m)
    annotation (Line(points={{-49,-20},{-20,-20},{-20,-28}}, color={0,0,127}));
  connect(boostVs.y, boostPI.u_s)
    annotation (Line(points={{-49,0},{-32,0}}, color={0,0,127}));
  connect(conv.n2, ground.p) annotation (Line(points={{24,65},{34,65},{34,60},{
          50,60}}, color={0,0,255}));
  connect(voutSense.y, boostPI.u_m) annotation (Line(points={{-49,-20},{-34,-20},
          {-20,-20},{-20,-12}},color={0,0,127}));
  connect(modeSelector.y, conv.vc)
    annotation (Line(points={{10,41},{10,41},{10,58}}, color={0,0,127}));
  connect(boostPI.y, modeSelector.u1)
    annotation (Line(points={{-9,0},{2,0},{2,18}}, color={0,0,127}));
  connect(buckPI.y, modeSelector.u3)
    annotation (Line(points={{-9,-40},{18,-40},{18,18}}, color={0,0,127}));
  connect(Vbatt.p, Rbatt.p)
    annotation (Line(points={{-50,80},{-46,80},{-40,80}}, color={0,0,255}));
  connect(Vbatt.n, conv.n1) annotation (Line(points={{-50,60},{-50,60},{-6,60},
          {-6,65},{4,65}}, color={0,0,255}));
  connect(ground.p, Rload.n)
    annotation (Line(points={{50,60},{50,60}}, color={0,0,255}));
  connect(Rload.p, conv.p2) annotation (Line(points={{50,80},{34,80},{34,75},{
          24,75}}, color={0,0,255}));
  connect(VbattSignal.y, Vbatt.v)
    annotation (Line(points={{-69,70},{-57,70}}, color={0,0,127}));
  connect(RloadSignal.y, Rload.R)
    annotation (Line(points={{69,70},{61,70}}, color={0,0,127}));
  connect(modeCommand.y, modeSelector.u2) annotation (Line(points={{-49,-70},{10,
          -70},{10,18}},     color={255,0,255}));
  connect(modeCommand.y, conv.mode) annotation (Line(points={{-49,-70},{30,-70},
          {30,50},{18,50},{18,58}},      color={255,0,255}));
  annotation (experiment(StopTime=20, Interval=0.001),
      __Dymola_experimentSetupOutput,
      Documentation(info="<html>
          <p>
            A battery, simulated with a controlled voltage source in
            series with a small resistance, is interfaced with a USB
            device, simulated with a resistive load. The converter
            is a component included in
            the <a href=\"Modelica://PVSystems.Electrical.Assemblies\">Electrical.Assemblies</a>
            package.
          </p>
        
          <p>
            This example is borrowed
            from <a href=\"modelica://PVSystems.UsersGuide.References.EMA16\">EMA16</a>. The
            application is not that related with photovoltaics, but
            provides a good showcase of the power electronics models
            in this library. The converter is specified to have
            three operating modes:
          </p>
        
          <ul class=\"org-ul\">
            <li>Battery voltage 12.6V, USB voltage 5+/-0.1V at 2A,
              converter supplies bus.
            </li>
            <li>Battery voltage 9.6V, USB voltage 20+/-0.1V at 3A,
              converter supplies bus.
            </li>
            <li>Battery voltage 11.1V, USB voltage 20V, bus supplies
              60W to charge battery.
            </li>
          </ul>
        
          <p>
            An efficient solution to these step-down and
            bidirectional step-up requirements is a non-inverting
            buck-boost converter with bi-directional switches
            operated in a buck/boost modal fashion (i.e. the boost
            switches are disabled while in buck mode and vice
            versa). A possible solution to these requirements using
            this topology is expressed through the parametrization
            of <a href=\"modelica://PVSystems.Electrical.Assemblies.CPMBidirectionalBuckBoost\">CPMBidirectionalBuckBoost</a>:
          </p>
        
        
          <div class=\"figure\">
            <p><img src=\"modelica://PVSystems/Resources/Images/USBBatteryConverterParameters.png\"
                    alt=\"USBBatteryConverterParameters.png\" />
            </p>
          </div>
        
          <p>
            This converter model includes both the electrical and
            control components of a Current-Peak Mode controlled
            modal non-inverting buck-boost. The default stop time is
            set at 20 seconds. Running the simulation and plotting
            the output voltage and current produces the following
            result:
          </p>
        
        
          <div class=\"figure\">
            <p><img src=\"modelica://PVSystems/Resources/Images/USBBatteryConverterResults.png\"
                    alt=\"USBBatteryConverterResults.png\" /></p>
          </div>
        </html>"));
end USBBatteryConverter;
