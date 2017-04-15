within PVSystems.Electrical;
model IdealCBSwitch "Basic two-cuadrant current bidirectional switch"
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  // Components
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=0)));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode annotation (Placement(
        transformation(
        origin={0,40},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Blocks.Interfaces.BooleanInput c annotation (Placement(
        transformation(
        origin={0,-70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  connect(p, idealClosingSwitch.p)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
  connect(idealClosingSwitch.n, n)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(idealDiode.p, n) annotation (Line(points={{10,40},{60,40},{60,0},{100,
          0}}, color={0,0,255}));
  connect(idealDiode.n, p) annotation (Line(points={{-10,40},{-60,40},{-60,0},{
          -100,0}}, color={0,0,255}));
  connect(c, idealClosingSwitch.control)
    annotation (Line(points={{0,-70},{0,-7}}, color={255,0,255}));
  annotation (Icon(graphics={Line(points={{-98,0},{-20,0}}, color={0,0,255}),
          Line(points={{-20,-20},{20,0},{100,0}}, color={0,0,255}),Line(points=
          {{-40,0},{-40,40},{-20,40}}, color={0,0,255}),Line(points={{-20,40},{
          10,60},{10,20},{-20,40}}, color={0,0,255}),Line(points={{10,40},{40,
          40},{40,0}}, color={0,0,255}),Line(points={{-20,60},{-20,20}}, color=
          {0,0,255}),Line(points={{0,-78},{0,-10}}, color={255,85,255})}),
      Documentation(info="<html>
      <p>This model represents and idealized current bi-directional
      switch. This is the typical IGBT in anti-parallel with a diode from
      which many converters are built.</p>
      </html>"));
end IdealCBSwitch;
