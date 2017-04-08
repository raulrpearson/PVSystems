within PVSystems.Control;
block ControllerInverter1ph
  "Complete synchronous reference frame inverter controller"
  extends Modelica.Blocks.Icons.Block;
  extends Modelica.Icons.UnderConstruction;
  // Parameters
  parameter Real ik=0.2 "Current PI gain";
  parameter Modelica.SIunits.Time iT=0.02 "Current PI time constant";
  parameter Real vk=0.2 "Voltage PI gain";
  parameter Modelica.SIunits.Time vT=0.02 "Voltage PI time constant";
  parameter Modelica.SIunits.Frequency fline=50 "Line frequency";
  // Interface
  Modelica.Blocks.Interfaces.RealInput iac "AC current sense" annotation (
      Placement(transformation(extent={{-120,70},{-100,90}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput vac "AC voltage sense" annotation (
      Placement(transformation(extent={{-120,20},{-100,40}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput idc "DC current sense" annotation (
      Placement(transformation(extent={{-120,-40},{-100,-20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput vdc "DC voltage sense" annotation (
      Placement(transformation(extent={{-120,-80},{-100,-60}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput d "Duty cycle" annotation (Placement(
        transformation(extent={{100,-10},{120,10}}, rotation=0)));
  // Components
  Park park annotation (Placement(transformation(extent={{-54,66},{-34,86}},
          rotation=0)));
  PLL pLL(frequency=fline) annotation (Placement(transformation(extent={{-80,20},
            {-60,40}}, rotation=0)));
  Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime=1/fline/4)
    annotation (Placement(transformation(extent={{-88,50},{-68,70}}, rotation=0)));
  Modelica.Blocks.Continuous.PI idPI(k=ik, T=iT) annotation (Placement(
        transformation(extent={{50,40},{70,60}}, rotation=0)));
  Modelica.Blocks.Math.Feedback idFB annotation (Placement(transformation(
          extent={{20,60},{40,40}}, rotation=0)));
  Modelica.Blocks.Continuous.PI iqPI(k=ik, T=iT) annotation (Placement(
        transformation(extent={{-8,-10},{12,10}}, rotation=0)));
  Modelica.Blocks.Math.Feedback iqFB annotation (Placement(transformation(
          extent={{-38,10},{-18,-10}}, rotation=0)));
  Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(
        transformation(extent={{-68,-10},{-48,10}}, rotation=0)));
  PVSystems.Control.ControllerMPPT mPPTController annotation (Placement(
        transformation(extent={{-88,-26},{-68,-46}}, rotation=0)));
  Modelica.Blocks.Continuous.PI vdcPI(k=vk, T=vT) annotation (Placement(
        transformation(extent={{-30,-46},{-10,-26}}, rotation=0)));
  Modelica.Blocks.Math.Feedback iqFB1 annotation (Placement(transformation(
          extent={{-60,-46},{-40,-26}}, rotation=0)));
  InversePark inversePark annotation (Placement(transformation(extent={{72,-14},
            {92,6}}, rotation=0)));
equation
  connect(pLL.v, vac)
    annotation (Line(points={{-82,30},{-100,30},{-110,30}}, color={0,0,127}));
  connect(pLL.theta, park.theta)
    annotation (Line(points={{-59,30},{-44,30},{-44,64}}, color={0,0,127}));
  connect(iac, fixedDelay.u) annotation (Line(points={{-110,80},{-96,80},{-96,
          60},{-90,60}}, color={0,0,127}));
  connect(park.alpha, iac)
    annotation (Line(points={{-56,80},{-88,80},{-110,80}}, color={0,0,127}));
  connect(park.beta, fixedDelay.y) annotation (Line(points={{-56,72},{-62,72},{
          -62,60},{-67,60}}, color={0,0,127}));
  connect(idFB.y, idPI.u)
    annotation (Line(points={{39,50},{48,50}}, color={0,0,127}));
  connect(park.d, idFB.u2)
    annotation (Line(points={{-33,80},{30,80},{30,58}}, color={0,0,127}));
  connect(iqFB.y, iqPI.u)
    annotation (Line(points={{-19,0},{-10,0}}, color={0,0,127}));
  connect(park.q, iqFB.u2)
    annotation (Line(points={{-33,72},{-28,72},{-28,8}}, color={0,0,127}));
  connect(const.y, iqFB.u1)
    annotation (Line(points={{-47,0},{-36,0}}, color={0,0,127}));
  connect(idc, mPPTController.u2) annotation (Line(points={{-110,-30},{-104,-30},
          {-90,-30}}, color={0,0,127}));
  connect(vdc, mPPTController.u1) annotation (Line(points={{-110,-70},{-96,-70},
          {-96,-42},{-90,-42}}, color={0,0,127}));
  connect(mPPTController.y, iqFB1.u1)
    annotation (Line(points={{-67,-36},{-58,-36}}, color={0,0,127}));
  connect(iqFB1.u2, vdc) annotation (Line(points={{-50,-44},{-50,-70},{-110,-70}},
        color={0,0,127}));
  connect(iqFB1.y, vdcPI.u)
    annotation (Line(points={{-41,-36},{-32,-36}}, color={0,0,127}));
  connect(vdcPI.y, idFB.u1) annotation (Line(points={{-9,-36},{18,-36},{18,50},
          {22,50}}, color={0,0,127}));
  connect(inversePark.alpha, d)
    annotation (Line(points={{93,0},{110,0}}, color={0,0,127}));
  connect(iqPI.y, inversePark.q)
    annotation (Line(points={{13,0},{42,0},{42,-8},{70,-8}}, color={0,0,127}));
  connect(idPI.y, inversePark.d)
    annotation (Line(points={{71,50},{70,50},{70,0}}, color={0,0,127}));
  connect(pLL.theta, inversePark.theta) annotation (Line(points={{-59,30},{0,30},
          {0,-52},{82,-52},{82,-16}}, color={0,0,127}));
  annotation (Icon(graphics={Text(
          extent={{-70,70},{70,20}},
          lineColor={0,0,255},
          textString="Inverter"),Text(
          extent={{-70,-20},{70,-70}},
          lineColor={0,0,255},
          textString="Ctl")}), Documentation(info="<html>
      <p>
        Complete controller for monophasic inverter. Currently under
        construction.
      </p>
      </html>"));
end ControllerInverter1ph;
