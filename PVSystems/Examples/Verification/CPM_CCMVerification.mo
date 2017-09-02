within PVSystems.Examples.Verification;
model CPM_CCMVerification "Averaged CPM_CCM verification"
  extends Modelica.Icons.Example;
  Control.SwitchingCPM switchingCPM(
    dMin=0.05,
    dMax=0.95,
    fs=200e3,
    vcMax=10,
    Va=0.01)  annotation (Placement(transformation(extent={{-40,36},{-20,56}})));
  Modelica.Blocks.Continuous.Integrator integrator(initType=Modelica.Blocks.Types.Init.InitialState,
    k=1e4,
    y_start=3.99)
    annotation (Placement(transformation(extent={{50,40},{70,60}})));
  Modelica.Blocks.Sources.Constant vdT(k=2)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Sources.Constant vdpT(k=-1)
    annotation (Placement(transformation(extent={{-40,4},{-20,24}})));
  Modelica.Blocks.Sources.Constant vc(k=4)
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Control.CPM_CCM CPM_CCM(
    L=1e-4,
    fs=200e3,
    Rf=1,
    d_disabled=0.05,
    Va=0.01) annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  Modelica.Blocks.Sources.BooleanStep enable(startTime=1e-5) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-60})));
  Modelica.Blocks.Math.Mean mean(f=200e3)
    annotation (Placement(transformation(extent={{-40,-36},{-20,-16}})));
equation
  connect(vdT.y, switch1.u1)
    annotation (Line(points={{-19,80},{0,80},{0,58},{18,58}},
                                                            color={0,0,127}));
  connect(switch1.y, integrator.u)
    annotation (Line(points={{41,50},{41,50},{48,50}},
                                                    color={0,0,127}));
  connect(vdpT.y, switch1.u3) annotation (Line(points={{-19,14},{10,14},{10,42},
          {18,42}}, color={0,0,127}));
  connect(switchingCPM.c, switch1.u2)
    annotation (Line(points={{-19,50},{18,50}},
                                            color={255,0,255}));
  connect(integrator.y, switchingCPM.vs) annotation (Line(points={{71,50},{80,50},
          {80,-80},{-50,-80},{-50,42},{-42,42}}, color={0,0,127}));
  connect(vc.y, switchingCPM.vc)
    annotation (Line(points={{-69,50},{-42,50}},
                                               color={0,0,127}));
  connect(CPM_CCM.vc, switchingCPM.vc) annotation (Line(points={{38,-20},{20,-20},
          {20,-8},{-60,-8},{-60,50},{-42,50}}, color={0,0,127}));
  connect(abs1.u, vdpT.y) annotation (Line(points={{-2,-60},{-10,-60},{-10,14},{
          -19,14}}, color={0,0,127}));
  connect(abs1.y, CPM_CCM.vm2) annotation (Line(points={{21,-60},{28,-60},{28,-40},
          {38,-40}}, color={0,0,127}));
  connect(CPM_CCM.vm1, vdT.y) annotation (Line(points={{38,-34},{0,-34},{0,80},{
          -19,80}}, color={0,0,127}));
  connect(mean.y, CPM_CCM.vs)
    annotation (Line(points={{-19,-26},{10,-26},{38,-26}}, color={0,0,127}));
  connect(mean.u, switchingCPM.vs) annotation (Line(points={{-42,-26},{-50,-26},
          {-50,42},{-42,42}}, color={0,0,127}));
  connect(enable.y, CPM_CCM.enable)
    annotation (Line(points={{50,-49},{50,-42}}, color={255,0,255}));
  annotation (experiment(StopTime=2e-4), Diagram(graphics={Rectangle(extent={{
              -100,100},{90,-90}}, lineColor={255,255,255})}));
end CPM_CCMVerification;
