within PVSystems.Electrical.Assemblies;
model CPMBidirectionalBuckBoost
  "Bidirectional Buck Boost for battery USB interface"
  extends Interfaces.TwoPortConverter;
  parameter Modelica.SIunits.Capacitance Cin "Input capacitance";
  parameter Modelica.SIunits.Voltage vCin_ini=0
    "Guess for initial voltage of Cin";
  parameter Modelica.SIunits.Capacitance Cout "Output capacitance";
  parameter Modelica.SIunits.Voltage vCout_ini=0
    "Guess for initial voltage of Cout";
  parameter Modelica.SIunits.Inductance L "Inductance";
  parameter Modelica.SIunits.Current iL_ini=0 "Guess for initial current of L";
  parameter Modelica.SIunits.Resistance RL "Series resistance of inductor";
  parameter Modelica.SIunits.Resistance Rf "Equivalent sensing resistance";
  parameter Modelica.SIunits.Frequency fs "Switching frequency";
  parameter Modelica.SIunits.Voltage Va_buck
    "Articial ramp amplitude for buck CPM";
  parameter Modelica.SIunits.Voltage Va_boost
    "Articial ramp amplitude for boost CPM";
  Control.CPM_CCM buck_cpm(
    L=L,
    Rf=1,
    fs=fs,
    Va=Va_buck) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-10})));
  Modelica.Electrical.Analog.Basic.Capacitor outputCapacitor(C=Cout, v(start=
          vCout_ini)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,30})));
  Modelica.Electrical.Analog.Basic.Capacitor inputCapacitor(C=Cin, v(start=
          vCin_ini)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,30})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(start=iL_ini))
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Electrical.CCM1 buck_switch
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Electrical.CCM1 boost_switch
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Control.CPM_CCM boost_cpm(
    L=L,
    Rf=1,
    fs=fs,
    Va=Va_boost) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-10})));
  Modelica.Blocks.Sources.RealExpression vsense(y=inductor.i)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Sources.RealExpression vm1_buck(y=v1 - v2)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Sources.RealExpression vm2_buck(y=-v2)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Sources.RealExpression vm1_boost(y=v1)
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Modelica.Blocks.Interfaces.RealInput vc_buck "Buck control voltage"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-50,-120})));
  Modelica.Blocks.Interfaces.RealInput vc_boost "Boost control voltage"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={50,-120})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=RL)
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
equation
  connect(buck_switch.n1, inductor.p) annotation (Line(points={{-50,25},{-70,25},
          {-70,50},{-20,50}}, color={0,0,255}));
  connect(buck_switch.p2, inductor.p)
    annotation (Line(points={{-30,35},{-30,50},{-20,50}}, color={0,0,255}));
  connect(outputCapacitor.n, buck_switch.n2) annotation (Line(points={{90,20},{
          90,10},{-30,10},{-30,25}}, color={0,0,255}));
  connect(boost_switch.n1, buck_switch.n2) annotation (Line(points={{40,25},{40,
          10},{-30,10},{-30,25}}, color={0,0,255}));
  connect(boost_switch.n2, boost_switch.p1) annotation (Line(points={{60,25},{
          70,25},{70,50},{40,50},{40,35}}, color={0,0,255}));
  connect(inputCapacitor.n, buck_switch.n2) annotation (Line(points={{-90,20},{
          -90,10},{-30,10},{-30,25}}, color={0,0,255}));
  connect(buck_cpm.d, buck_switch.d)
    annotation (Line(points={{-40,1},{-40,10},{-40,18}}, color={0,0,127}));
  connect(boost_cpm.d, boost_switch.d)
    annotation (Line(points={{50,1},{50,10},{50,18}}, color={0,0,127}));
  connect(p1, buck_switch.p1) annotation (Line(points={{-100,50},{-100,50},{-80,
          50},{-80,35},{-50,35}}, color={0,0,255}));
  connect(n1, buck_switch.n2) annotation (Line(points={{-100,-50},{-90,-50},{-90,
          10},{-30,10},{-30,25}}, color={0,0,255}));
  connect(n2, buck_switch.n2) annotation (Line(points={{100,-50},{90,-50},{90,
          10},{-30,10},{-30,25}}, color={0,0,255}));
  connect(vsense.y, buck_cpm.vs)
    annotation (Line(points={{-59,-30},{-43,-30},{-43,-22}}, color={0,0,127}));
  connect(vsense.y, boost_cpm.vs) annotation (Line(points={{-59,-30},{-16,-30},
          {47,-30},{47,-22}},color={0,0,127}));
  connect(vm1_buck.y, buck_cpm.vm1) annotation (Line(points={{-59,-50},{-42,-50},
          {-37,-50},{-37,-22}}, color={0,0,127}));
  connect(vm2_buck.y, buck_cpm.vm2)
    annotation (Line(points={{-59,-70},{-31,-70},{-31,-22}}, color={0,0,127}));
  connect(vm1_buck.y, boost_cpm.vm2) annotation (Line(points={{-59,-50},{-10,-50},
          {59,-50},{59,-22}}, color={0,0,127}));
  connect(vm1_boost.y, boost_cpm.vm1) annotation (Line(points={{-59,-90},{-12,-90},
          {53,-90},{53,-22}}, color={0,0,127}));
  connect(vc_buck, buck_cpm.vc) annotation (Line(points={{-50,-120},{-50,-120},
          {-50,-96},{-49,-96},{-49,-22}},color={0,0,127}));
  connect(vc_boost, boost_cpm.vc) annotation (Line(points={{50,-120},{50,-96},{
          41,-96},{41,-22}}, color={0,0,127}));
  connect(outputCapacitor.p, boost_switch.p2) annotation (Line(points={{90,40},
          {90,50},{80,50},{80,35},{60,35}},color={0,0,255}));
  connect(p2, boost_switch.p2) annotation (Line(points={{100,50},{80,50},{80,35},
          {60,35}}, color={0,0,255}));
  connect(inputCapacitor.p, buck_switch.p1) annotation (Line(points={{-90,40},{
          -90,50},{-80,50},{-80,35},{-50,35}}, color={0,0,255}));
  connect(resistor.n, boost_switch.p1)
    annotation (Line(points={{30,50},{40,50},{40,35}}, color={0,0,255}));
  connect(inductor.n, resistor.p)
    annotation (Line(points={{0,50},{5,50},{10,50}}, color={0,0,255}));
  annotation (
    Diagram(graphics={Text(
          extent={{-28,-44},{36,-48}},
          lineColor={0,0,255},
          textString="vm1_buck = vm2_boost")}),
    Icon(graphics={
        Text(
          extent={{-60,30},{60,-30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="1-ph"),
        Line(points={{-70,50},{-10,50}}, color={0,0,255}),
        Line(points={{-70,70},{-10,70}}, color={0,0,255}),
        Line(points={{10,-70},{70,-70}},color={0,0,255}),
        Line(points={{10,-50},{70,-50}},color={0,0,255})}),
    Documentation(info="<html><p>Bidirectional buck boost converter</p></html>"));
end CPMBidirectionalBuckBoost;
