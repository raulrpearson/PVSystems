within PVSystems.Examples.Verification;
model SimpleBatteryVerification "Verification of SimpleBattery"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Sources.SignalCurrent CC annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,10})));
  Modelica.Blocks.Sources.RealExpression CCControl(y=4.19 - B.v)
    annotation (Placement(transformation(extent={{-80,0},{-50,20}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Electrical.SimpleBattery B(Q=1, DoDini=0.999) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,10})));
  Modelica.Blocks.Continuous.LimIntegrator limIntegrator(outMax=2)
    annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
equation
  connect(ground.p, CC.p)
    annotation (Line(points={{10,-20},{10,-20},{10,0}}, color={0,0,255}));
  connect(CC.p, B.n) annotation (Line(points={{10,0},{50,0}}, color={0,0,255}));
  connect(CC.n, B.p)
    annotation (Line(points={{10,20},{50,20}}, color={0,0,255}));
  connect(limIntegrator.y, CC.i)
    annotation (Line(points={{-9,10},{3,10}}, color={0,0,127}));
  connect(CCControl.y, limIntegrator.u) annotation (Line(points={{-48.5,10},{-48.5,
          10},{-32,10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=15, Interval=0.001),
    __Dymola_experimentSetupOutput);
end SimpleBatteryVerification;
