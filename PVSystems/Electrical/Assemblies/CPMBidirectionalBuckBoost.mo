within PVSystems.Electrical.Assemblies;
model CPMBidirectionalBuckBoost
  "Bidirectional Buck Boost for battery USB interface"
  extends Interfaces.TwoPort;
  extends PVSystems.Icons.ConverterIcon;
  parameter Modelica.SIunits.Capacitance Cin "Input capacitance"
    annotation (Dialog(group="Power stage"));
  parameter Modelica.SIunits.Voltage vCin_ini=0
    "Guess for initial voltage of Cin"
    annotation (Dialog(group="Initialization"));
  parameter Modelica.SIunits.Capacitance Cout "Output capacitance"
    annotation (Dialog(group="Power stage"));
  parameter Modelica.SIunits.Voltage vCout_ini=0
    "Guess for initial voltage of Cout"
    annotation (Dialog(group="Initialization"));
  parameter Modelica.SIunits.Inductance L "Inductance"
    annotation (Dialog(group="Power stage"));
  parameter Modelica.SIunits.Current iL_ini=0 "Guess for initial current of L"
    annotation (Dialog(group="Initialization"));
  parameter Modelica.SIunits.Resistance RL "Series resistance of inductor"
    annotation (Dialog(group="Power stage"));
  parameter Modelica.SIunits.Resistance Rf "Equivalent sensing resistance"
    annotation (Dialog(group="CPM modulator"));
  parameter Modelica.SIunits.Frequency fs "Switching frequency"
    annotation (Dialog(group="CPM modulator"));
  parameter Modelica.SIunits.Voltage Va_buck
    "Articial ramp amplitude for buck CPM"
    annotation (Dialog(group="CPM modulator"));
  parameter Modelica.SIunits.Voltage Va_boost
    "Articial ramp amplitude for boost CPM"
    annotation (Dialog(group="CPM modulator"));
  Control.CPM_CCM buck_cpm(
    L=L,
    Rf=1,
    fs=fs,
    Va=Va_buck,
    d_disabled=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={40,40})));
  Control.CPM_CCM boost_cpm(
    L=L,
    Rf=1,
    fs=fs,
    Va=Va_boost,
    d_disabled=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,4})));
  Modelica.Blocks.Sources.RealExpression vsense(y=Rf*conv.inductor.i)
    annotation (Placement(transformation(extent={{-80,60},{-44,80}})));
  Modelica.Blocks.Sources.RealExpression vm1_buck(y=v1 - v2)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Blocks.Sources.RealExpression vm2_buck(y=-v2)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.RealExpression vm1_boost(y=v1)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Interfaces.RealInput vc "Buck control voltage" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-120})));
  Modelica.Blocks.Interfaces.BooleanInput mode "Boost control voltage"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={40,-120})));
  BidirectionalBuckBoost conv(
    Cin=Cin,
    Cout=Cout,
    L=L,
    RL=RL,
    vCin_ini=vCin_ini,
    vCout_ini=vCout_ini,
    iL_ini=iL_ini,
    Rcin=1e-3,
    Rcout=1e-3,
    dmax=1,
    dmin=1e-3) annotation (Placement(transformation(extent={{66,80},{86,100}})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={40,-30})));
equation
  connect(conv.p1, p1)
    annotation (Line(points={{66,95},{-100,95},{-100,50}}, color={0,0,255}));
  connect(conv.p2, p2)
    annotation (Line(points={{86,95},{100,95},{100,50}}, color={0,0,255}));
  connect(conv.n2, n2) annotation (Line(points={{86,85},{92,85},{92,-50},{100,-50}},
        color={0,0,255}));
  connect(conv.n1, n1) annotation (Line(points={{66,85},{-92,85},{-92,-50},{-100,
          -50}}, color={0,0,255}));
  connect(vm2_buck.y, buck_cpm.vm2)
    annotation (Line(points={{-59,30},{-59,30},{28,30}}, color={0,0,127}));
  connect(vsense.y, boost_cpm.vs) annotation (Line(points={{-42.2,70},{-30,70},
          {-30,8},{-2,8}}, color={0,0,127}));
  connect(vm1_buck.y, boost_cpm.vm2) annotation (Line(points={{-59,-20},{-20,
          -20},{-20,-6},{-2,-6}}, color={0,0,127}));
  connect(vm1_boost.y, boost_cpm.vm1)
    annotation (Line(points={{-59,0},{-59,0},{-2,0}}, color={0,0,127}));
  connect(vm1_buck.y, buck_cpm.vm1) annotation (Line(points={{-59,-20},{-20,-20},
          {-20,36},{28,36}}, color={0,0,127}));
  connect(vsense.y, buck_cpm.vs) annotation (Line(points={{-42.2,70},{-30,70},{
          -30,44},{28,44}}, color={0,0,127}));
  connect(vc, buck_cpm.vc)
    annotation (Line(points={{-40,-120},{-40,50},{28,50}}, color={0,0,127}));
  connect(vc, boost_cpm.vc)
    annotation (Line(points={{-40,-120},{-40,14},{-2,14}}, color={0,0,127}));
  connect(mode, not1.u) annotation (Line(points={{40,-120},{40,-120},{40,-72},{
          40,-42}}, color={255,0,255}));
  connect(mode, boost_cpm.enable) annotation (Line(points={{40,-120},{40,-120},
          {40,-72},{10,-72},{10,-8}}, color={255,0,255}));
  connect(not1.y, buck_cpm.enable)
    annotation (Line(points={{40,-19},{40,28}}, color={255,0,255}));
  connect(boost_cpm.d, conv.dboost)
    annotation (Line(points={{21,4},{80,4},{80,78}}, color={0,0,127}));
  connect(buck_cpm.d, conv.dbuck)
    annotation (Line(points={{51,40},{72,40},{72,78}}, color={0,0,127}));
  annotation (
    Diagram(graphics={Text(
          extent={{-22,2},{22,-2}},
          lineColor={0,0,255},
          textString="vm1_buck = vm2_boost",
          origin={-112,12},
          rotation=90)}),
    Icon(graphics={
        Text(
          extent={{-60,30},{60,-30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="1-ph"),
        Line(points={{-70,50},{-10,50}}, color={0,0,255}),
        Line(points={{-70,70},{-10,70}}, color={0,0,255}),
        Line(points={{10,-70},{70,-70}}, color={0,0,255}),
        Line(points={{10,-50},{70,-50}}, color={0,0,255})}),
    Documentation(info="<html><p>Bidirectional buck boost converter</p></html>"));
end CPMBidirectionalBuckBoost;
