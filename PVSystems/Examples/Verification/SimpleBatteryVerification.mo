within PVSystems.Examples.Verification;
model SimpleBatteryVerification "SimpleBattery verification"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Sources.SignalCurrent CC annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,10})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Electrical.SimpleBattery B(Q=1, DoDini=0.5)   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,10})));
  Modelica.Blocks.Nonlinear.SlewRateLimiter slewRateLimiter(Rising=4)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uHigh=4.19, uLow=0.1)
    annotation (Placement(transformation(extent={{-54,0},{-34,20}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-14,0},{6,20}})));
  Modelica.Blocks.Sources.RealExpression idis(y=-2)
    annotation (Placement(transformation(extent={{-54,30},{-34,50}})));
  Modelica.Blocks.Sources.RealExpression ich(y=2)
    annotation (Placement(transformation(extent={{-54,-30},{-34,-10}})));
  Modelica.Blocks.Sources.RealExpression vsense(y=B.v)
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
equation
  connect(ground.p, CC.p)
    annotation (Line(points={{60,-20},{60,-20},{60,0}}, color={0,0,255}));
  connect(CC.p, B.n) annotation (Line(points={{60,0},{90,0}}, color={0,0,255}));
  connect(CC.n, B.p)
    annotation (Line(points={{60,20},{90,20}}, color={0,0,255}));
  connect(slewRateLimiter.y, CC.i)
    annotation (Line(points={{41,10},{53,10}}, color={0,0,127}));
  connect(switch1.y, slewRateLimiter.u)
    annotation (Line(points={{7,10},{18,10}}, color={0,0,127}));
  connect(hysteresis.y, switch1.u2)
    annotation (Line(points={{-33,10},{-24,10},{-16,10}}, color={255,0,255}));
  connect(idis.y, switch1.u1) annotation (Line(points={{-33,40},{-24,40},{-24,18},
          {-16,18}}, color={0,0,127}));
  connect(ich.y, switch1.u3) annotation (Line(points={{-33,-20},{-24,-20},{-24,2},
          {-16,2}}, color={0,0,127}));
  connect(vsense.y, hysteresis.u)
    annotation (Line(points={{-69,10},{-56,10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5400, __Dymola_NumberOfIntervals=10000),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
          <p>
            This example provides a charge/discharge control logic
            to a current source in parallel with the battery
            model. The control is configured to put the battery
            through charge/discharge cycles for as long as the
            simulation runs:
          </p>
        
        
          <div class=\"figure\">
            <p><img src=\"modelica://PVSystems/Resources/Images/SimpleBatteryVerificationResults.png\"
                    alt=\"SimpleBatteryVerificationResults.png\" />
            </p>
          </div>
        
          <p>
            Notice how the charge and discharge cycles take about 30
            minutes, which is what was to be expected by
            charging/discharging a 1A.h battery with a 2A
            current.</p>
        </html>"));
end SimpleBatteryVerification;
