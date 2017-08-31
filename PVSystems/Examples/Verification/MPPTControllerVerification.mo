within PVSystems.Examples.Verification;
model MPPTControllerVerification "MPPT controller verification"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-30,-40},{-10,-20}}, rotation=0)));
  Electrical.PVArray pVArray annotation (Placement(transformation(
        origin={-40,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.SignalVoltage sink annotation (Placement(
        transformation(
        origin={0,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Control.MPPTController mpptController(
    sampleTime=1,
    pkThreshold=0.01,
    vrefStep=1,
    vrefStart=5) annotation (Placement(transformation(
        origin={-30,74},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp G(
    offset=1000,
    height=-500,
    startTime=30,
    duration=10) annotation (Placement(transformation(extent={{-90,0},{-70,20}},
          rotation=0)));
  Modelica.Blocks.Sources.Ramp T(
    height=-25,
    offset=273.15 + 25,
    startTime=50,
    duration=50) annotation (Placement(transformation(extent={{-80,-80},{-60,-60}},
          rotation=0)));
  Modelica.Blocks.Math.Add vdcSetpoint annotation (Placement(transformation(
        origin={30,54},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Ramp perturbation(
    height=10,
    offset=0,
    duration=20,
    startTime=130) annotation (Placement(transformation(
        origin={-30,34},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.RealExpression vsense(y=sink.v)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Sources.RealExpression isense(y=sink.i)
    annotation (Placement(transformation(extent={{-80,44},{-60,64}})));
  Modelica.Blocks.Sources.RealExpression vdcSetpoint1(y=26)
    annotation (Placement(transformation(extent={{60,-60},{40,-40}})));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (Placement(
        transformation(extent={{-30,-80},{-10,-60}}, rotation=0)));
  Electrical.PVArray pVArray1 annotation (Placement(transformation(
        origin={-40,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.SignalVoltage sink1 annotation (Placement(
        transformation(
        origin={0,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(G.y, pVArray.G) annotation (Line(points={{-69,10},{-60,10},{-60,-7},{
          -45.5,-7}}, color={0,0,127}));
  connect(vdcSetpoint.y, sink.v) annotation (Line(points={{41,54},{60,54},{60,-10},
          {7,-10}}, color={0,0,127}));
  connect(perturbation.y, vdcSetpoint.u2) annotation (Line(points={{-19,34},{0,34},
          {0,48},{18,48}}, color={0,0,127}));
  connect(pVArray.p, sink.p)
    annotation (Line(points={{-40,0},{0,0}}, color={0,0,255}));
  connect(vsense.y, mpptController.u1)
    annotation (Line(points={{-59,80},{-59,80},{-42,80}}, color={0,0,127}));
  connect(mpptController.y, vdcSetpoint.u1) annotation (Line(points={{-19,74},{0,
          74},{0,60},{18,60}}, color={0,0,127}));
  connect(isense.y, mpptController.u2) annotation (Line(points={{-59,54},{-50,54},
          {-50,68},{-42,68}}, color={0,0,127}));
  connect(pVArray1.p, sink1.p) annotation (Line(points={{-40,-40},{-28,-40},{-14,
          -40},{0,-40}}, color={0,0,255}));
  connect(sink1.v, vdcSetpoint1.y)
    annotation (Line(points={{7,-50},{39,-50}}, color={0,0,127}));
  connect(T.y, pVArray1.T) annotation (Line(points={{-59,-70},{-52,-70},{-52,-53},
          {-45.5,-53}}, color={0,0,127}));
  connect(T.y, pVArray.T) annotation (Line(points={{-59,-70},{-52,-70},{-52,-13},
          {-45.5,-13}}, color={0,0,127}));
  connect(G.y, pVArray1.G) annotation (Line(points={{-69,10},{-60,10},{-60,-47},
          {-45.5,-47}}, color={0,0,127}));
  connect(pVArray.n, ground.p)
    annotation (Line(points={{-40,-20},{-30,-20},{-20,-20}}, color={0,0,255}));
  connect(sink.n, ground.p)
    annotation (Line(points={{0,-20},{-10,-20},{-20,-20}}, color={0,0,255}));
  connect(pVArray1.n, ground1.p)
    annotation (Line(points={{-40,-60},{-20,-60}}, color={0,0,255}));
  connect(ground1.p, sink1.n)
    annotation (Line(points={{-20,-60},{-1.77636e-015,-60}}, color={0,0,255}));
  annotation (experiment(StopTime=180), Documentation(info="<html>
        <p>
          This examples places an MPPT controller closing the loop
          for a voltage source connected to a PV array. The MPPT
          controller senses the power coming out of the PV array
          and provides a setpoint for the voltage source. This
          changes the operation point of the PV array with the
          goal of maximizing its output power for any given solar
          irradiation and junction temperature conditions.
        </p>
      
        <p>
          The model is designed to challenge the control by
          ramping solar irradiation, temperature at different
          times and by injecting a perturbation into the control
          loop:
        </p>
      
      
        <div class=\"figure\">
          <p><img src=\"modelica://PVSystems/Resources/Images/MPPTControllerVerificationResultsA.png\"
                  alt=\"MPPTControllerVerificationResultsA.png\"
                  />
          </p>
        </div>
      
        <p>
          The MPPT controller successfully deals with these
          changing conditions as shown in the following plots,
          which compares the static PV array control with the MPPT
          control:
        </p>
      
      
        <div class=\"figure\">
          <p><img src=\"modelica://PVSystems/Resources/Images/MPPTControllerVerificationResultsB.png\"
                  alt=\"MPPTControllerVerificationResultsB.png\"
                  /></p>
        </div>
      </html>"),
    Diagram(graphics={Rectangle(extent={{-100,92},{70,-90}}, lineColor={255,255,
              255})}));
end MPPTControllerVerification;
