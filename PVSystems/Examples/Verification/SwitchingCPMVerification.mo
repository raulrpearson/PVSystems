within PVSystems.Examples.Verification;
model SwitchingCPMVerification "SwitchingCPM verification"
  extends Modelica.Icons.Example;
  Control.SwitchingCPM switchingCPM(
    vcMax=5,
    dMin=0.05,
    dMax=0.95,
    fs=200e3,
    Va=0.01) annotation (Placement(transformation(extent={{-20,-14},{0,6}})));
  Modelica.Blocks.Continuous.Integrator integrator(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=3.99,
    k=1e4)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Blocks.Sources.Constant vdT(k=2)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Constant vdpT(k=-1)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Blocks.Sources.Constant vc(k=4)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(vdT.y, switch1.u1)
    annotation (Line(points={{1,40},{10,40},{10,8},{18,8}}, color={0,0,127}));
  connect(switch1.y, integrator.u)
    annotation (Line(points={{41,0},{41,0},{48,0}}, color={0,0,127}));
  connect(vdpT.y, switch1.u3) annotation (Line(points={{1,-40},{10,-40},{10,-8},
          {18,-8}}, color={0,0,127}));
  connect(switchingCPM.c, switch1.u2)
    annotation (Line(points={{1,0},{18,0}}, color={255,0,255}));
  connect(integrator.y, switchingCPM.vs) annotation (Line(points={{71,0},{80,0},
          {80,-60},{-30,-60},{-30,-8},{-22,-8}}, color={0,0,127}));
  connect(vc.y, switchingCPM.vc)
    annotation (Line(points={{-39,0},{-22,0}}, color={0,0,127}));
  annotation (experiment(StopTime=0.0002),
      Documentation(info="<html>
          <p>
            The switching CPM block requires the <em>vs</em> input,
            corresponding to the voltage output of the current
            sensor. In order to simplify things, a switch with some
            constant sources and an integrator are used to emulate
            the behaviour of an inductor. This setup creates the
            conditions to exercise the CPM block, as can be seen in
            the following figure:
          </p>
        
        
          <div class=\"figure\">
            <p><img src=\"modelica://PVSystems/Resources/Images/SwitchingCPMVerificationresults.Png\"
                    alt=\"SwitchingCPMVerificationresults.Png\"
                    /></p>
          </div>
        </html>>"));
end SwitchingCPMVerification;
