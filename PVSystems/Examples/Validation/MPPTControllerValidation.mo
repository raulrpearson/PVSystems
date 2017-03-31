within PVSystems.Examples.Validation;
model MPPTControllerValidation "Model to validate MPPT controller"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-2,-80},{18,-60}}, rotation=0)));
  Electrical.PVArray pVArray annotation (Placement(transformation(
        origin={-60,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.SignalVoltage sink annotation (Placement(
        transformation(
        origin={8,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  PVSystems.Control.ControllerMPPT controller(
    vrefStep=1,
    sampleTime=1,
    pkThreshold=0.01) annotation (Placement(transformation(
        origin={80,4},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor CS annotation (Placement(
        transformation(extent={{-50,30},{-30,10}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor VS annotation (Placement(
        transformation(
        origin={30,-30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sensors.PowerSensor PS annotation (Placement(
        transformation(extent={{-24,10},{-4,30}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp G(
    offset=1000,
    height=-500,
    startTime=30,
    duration=10) annotation (Placement(transformation(extent={{-100,20},{-80,40}},
          rotation=0)));
  Modelica.Blocks.Sources.Ramp T(
    height=-25,
    offset=273.15 + 25,
    duration=50,
    startTime=50) annotation (Placement(transformation(extent={{-100,-18},{-80,
            2}}, rotation=0)));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        origin={46,10},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Blocks.Sources.Ramp Perturbation(
    height=10,
    offset=0,
    duration=20,
    startTime=130) annotation (Placement(transformation(
        origin={80,36},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  connect(ground.p, sink.n)
    annotation (Line(points={{8,-60},{8,-30},{8,0},{8,0}}, color={0,0,255}));
  connect(pVArray.n, sink.n)
    annotation (Line(points={{-60,0},{8,0}}, color={0,0,255}));
  connect(pVArray.p, CS.p)
    annotation (Line(points={{-60,20},{-50,20}}, color={0,0,255}));
  connect(CS.i, controller.u2) annotation (Line(points={{-40,30},{-40,60},{100,
          60},{100,10},{92,10}}, color={0,0,127}));
  connect(VS.p, sink.p)
    annotation (Line(points={{30,-20},{30,20},{8,20}}, color={0,0,255}));
  connect(VS.n, ground.p)
    annotation (Line(points={{30,-40},{30,-60},{8,-60}}, color={0,0,255}));
  connect(VS.v, controller.u1) annotation (Line(points={{40,-30},{100,-30},{100,
          -2},{92,-2}}, color={0,0,127}));
  connect(CS.n, PS.pc)
    annotation (Line(points={{-30,20},{-24,20}}, color={0,0,255}));
  connect(PS.nc, sink.p)
    annotation (Line(points={{-4,20},{8,20}}, color={0,0,255}));
  connect(PS.pv, sink.p)
    annotation (Line(points={{-14,30},{8,30},{8,20}}, color={0,0,255}));
  connect(PS.nv, sink.n)
    annotation (Line(points={{-14,10},{-14,0},{8,0}}, color={0,0,255}));
  connect(G.y, pVArray.G) annotation (Line(points={{-79,30},{-74,30},{-74,13},{
          -65.5,13}}, color={0,0,127}));
  connect(T.y, pVArray.T) annotation (Line(points={{-79,-8},{-74,-8},{-74,7},{-65.5,
          7}}, color={0,0,127}));
  connect(add.u1, controller.y) annotation (Line(points={{58,4},{60.75,4},{
          60.75,4},{63.5,4},{63.5,4},{69,4}}, color={0,0,127}));
  connect(add.y, sink.v) annotation (Line(points={{35,10},{30,10},{30,10},{25,
          10},{25,10},{15,10}}, color={0,0,127}));
  connect(Perturbation.y, add.u2) annotation (Line(points={{69,36},{64,36},{64,
          16},{58,16}}, color={0,0,127}));
  annotation (
    Diagram(graphics),
    experiment(StopTime=180),
    Documentation(info="<html>
      <p>
        This examples places the MPPT controller closing the loop for a
        voltage source connected to a PV array. The MPPT controller senses
        the power coming out of the PV array and provides a setpoint for the
        voltage source. This changes the operation point of the PV array
        with the goal of maximizing its output power for any given solar
        irradiation and junction temperature conditions.
      </p>

      <p>
        The model is designed to challenge the control by ramping solar
        irradiation, temperature at different times and by injecting a
        perturbation into the control loop. The MPPT controller successfully
        deals with these changing conditions as shown in the following plot:
      </p>


      <div class=\"figure\">
        <p><img src=\"modelica://PVSystems/Resources/Images/MPPTControllerValidationResults.png\"
                alt=\"MPPTControllerValidationResults.png\" />
        </p>
      </div>
      </html>"));
end MPPTControllerValidation;
