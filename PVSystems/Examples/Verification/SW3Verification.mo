within PVSystems.Examples.Verification;
model SW3Verification "SW3 verification"
  extends Modelica.Icons.Example;
  Electrical.SW3 sw3(fs=2, deadTime=0.1)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz=5, V=1)
    annotation (Placement(transformation(
        origin={30,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-10,-30},{10,-10}},rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=2) annotation (Placement(
        transformation(
        origin={0,30},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Blocks.Sources.RealExpression duty(y=0.5)
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
equation
  connect(resistor.p,sineVoltage. p)
    annotation (Line(points={{10,30},{30,30},{30,20}}, color={0,0,255}));
  connect(ground.p,sineVoltage. n)
    annotation (Line(points={{0,-10},{30,-10},{30,0}},  color={0,0,255}));
  connect(sw3.n1, ground.p)
    annotation (Line(points={{-40,5},{-40,-10},{0,-10}},  color={0,0,255}));
  connect(sw3.p1, resistor.n)
    annotation (Line(points={{-40,15},{-40,30},{-10,30}}, color={0,0,255}));
  connect(duty.y, sw3.d)
    annotation (Line(points={{-49,-20},{-30,-20},{-30,-2}}, color={0,0,127}));
  connect(sw3.p2, resistor.n)
    annotation (Line(points={{-20,15},{-20,30},{-10,30}}, color={0,0,255}));
  connect(sw3.n2, ground.p)
    annotation (Line(points={{-20,5},{-20,-10},{0,-10}},  color={0,0,255}));
  annotation (experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-3));
end SW3Verification;
