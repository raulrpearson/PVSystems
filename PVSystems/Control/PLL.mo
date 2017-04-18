within PVSystems.Control;
block PLL "Phase-locked loop"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Frequency frequency=50;
  Modelica.Blocks.Continuous.Integrator integrator annotation (Placement(
        transformation(extent={{60,-10},{80,10}}, rotation=0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=1e-3, k=100) annotation (
      Placement(transformation(extent={{-4,-10},{16,10}},rotation=0)));
  Modelica.Blocks.Nonlinear.FixedDelay QuarterTDelay(delayTime=1/frequency/4)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}}, rotation=
           0)));
  Modelica.Blocks.Interfaces.RealInput v annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput theta annotation (Placement(
        transformation(extent={{100,-10},{120,10}}, rotation=0)));
  Park park annotation (Placement(transformation(extent={{-40,-14},{-20,6}},
          rotation=0)));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{30,
            48},{50,68}}, rotation=0)));
  Modelica.Blocks.Sources.Constant lineFreq(k=2*Modelica.Constants.pi*frequency)
    annotation (Placement(transformation(extent={{-30,54},{-10,74}}, rotation=0)));
equation
  connect(v, park.alpha)
    annotation (Line(points={{-120,0},{-42,0}}, color={0,0,127}));
  connect(QuarterTDelay.y, park.beta) annotation (Line(points={{-59,-20},{-50,-20},
          {-50,-8},{-42,-8}}, color={0,0,127}));
  connect(QuarterTDelay.u, v) annotation (Line(points={{-82,-20},{-96,-20},{-96,
          0},{-120,0}}, color={0,0,127}));
  connect(integrator.y, theta)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(park.theta, integrator.y) annotation (Line(points={{-30,-16},{-30,-30},
          {90,-30},{90,0},{81,0}}, color={0,0,127}));
  connect(add.y, integrator.u)
    annotation (Line(points={{51,58},{54,58},{54,0},{58,0}}, color={0,0,127}));
  connect(firstOrder.y, add.u2)
    annotation (Line(points={{17,0},{22,0},{22,52},{28,52}}, color={0,0,127}));
  connect(lineFreq.y, add.u1)
    annotation (Line(points={{-9,64},{28,64}}, color={0,0,127}));
  connect(park.q, firstOrder.u) annotation (Line(points={{-19,-8},{-12,-8},{-12,
          0},{-6,0}}, color={0,0,127}));
  annotation (
    Diagram(graphics),
    Icon(graphics={Line(
          points={{-70,0},{-50,60},{-30,0},{-10,-60},{10,0},{30,60},{50,0},{70,
              -60},{90,0}},
          color={0,0,255},
          smooth=Smooth.Bezier), Line(
          points={{-90,0},{-64,60},{-44,0},{-18,-60},{2,0},{22,60},{44,0},{64,-60},
              {88,0}},
          color={255,0,0},
          smooth=Smooth.Bezier)}),
    Documentation(info="<html>
        <p>
          Phase-locked loop. Given a sinusoidal input, extract the phase.
        </p>
      </html>"));
end PLL;
