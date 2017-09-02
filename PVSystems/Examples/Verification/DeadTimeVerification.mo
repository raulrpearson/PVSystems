within PVSystems.Examples.Verification;
model DeadTimeVerification "DeadTime verification"
  extends Modelica.Icons.Example;
  Control.DeadTime deadTime(deadTime=0.03)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=0.2)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation
  connect(booleanPulse.y, deadTime.c)
    annotation (Line(points={{-19,0},{-2,0}}, color={255,0,255}));
  annotation (
    experiment(StartTime=0, StopTime=1, Tolerance=1e-3), Diagram(graphics={
          Rectangle(extent={{-50,20},{30,-20}}, lineColor={255,255,255})}));
end DeadTimeVerification;
