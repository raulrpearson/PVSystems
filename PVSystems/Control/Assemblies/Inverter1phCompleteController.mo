within PVSystems.Control.Assemblies;
block Inverter1phCompleteController
  "Complete synchronous reference frame inverter controller"
  extends Modelica.Blocks.Icons.Block;
  extends Modelica.Icons.UnderConstruction;
  // Parameters
  parameter Real ik=0.1 "Current PI gain";
  parameter Modelica.SIunits.Time iT=0.01 "Current PI time constant";
  parameter Real idMax=Modelica.Constants.inf "Maximum effort for id loop";
  parameter Real iqMax=Modelica.Constants.inf "Maximum effort for iq loop";
  parameter Real vk=0.1 "Voltage PI gain";
  parameter Modelica.SIunits.Time vT=0.01 "Voltage PI time constant";
  parameter Real vdcMax=Modelica.Constants.inf "Maximum effort for vdc loop";
  parameter Modelica.SIunits.Frequency fline=50 "Line frequency";
  // Interface
  Modelica.Blocks.Interfaces.RealInput iac "AC current sense" annotation (
      Placement(transformation(extent={{-140,-60},{-100,-20}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput vac "AC voltage sense" annotation (
      Placement(transformation(extent={{-140,-100},{-100,-60}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput idc "DC current sense" annotation (
      Placement(transformation(extent={{-140,20},{-100,60}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput vdc "DC voltage sense" annotation (
      Placement(transformation(extent={{-140,60},{-100,100}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput d "Duty cycle" annotation (Placement(
        transformation(extent={{100,-10},{120,10}}, rotation=0)));
  // Components
  Modelica.Blocks.Sources.Constant iqs(k=0) annotation (Placement(
        transformation(extent={{-20,-30},{0,-10}}, rotation=0)));
  PVSystems.Control.Assemblies.MPPTController mppt(
    sampleTime=1,
    vrefStep=0.5,
    pkThreshold=0.5,
    vrefStart=15) annotation (Placement(transformation(extent={{-80,36},{-60,56}},
          rotation=0)));
  Modelica.Blocks.Continuous.LimPID vdcPI(
    k=vk,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=vT,
    yMax=vdcMax) annotation (Placement(transformation(extent={{-20,56},{0,36}},
          rotation=0)));
  Inverter1phCurrentController currentController(
    k=ik,
    T=iT,
    fline=fline,
    idMax=idMax,
    iqMax=iqMax)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  PLL pLL(frequency=fline)
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Modelica.Blocks.Sources.RealExpression vdcClone(y=vdc)
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
equation
  connect(currentController.d, d)
    annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
  connect(idc, mppt.u2)
    annotation (Line(points={{-120,40},{-120,40},{-82,40}},color={0,0,127}));
  connect(vdc, mppt.u1) annotation (Line(points={{-120,80},{-90,80},{-90,52},{-82,
          52}}, color={0,0,127}));
  connect(vdcPI.y, currentController.ids)
    annotation (Line(points={{1,46},{20,46},{20,6},{38,6}}, color={0,0,127}));
  connect(iac, currentController.i) annotation (Line(points={{-120,-40},{-70,-40},
          {-70,0},{38,0}}, color={0,0,127}));
  connect(iqs.y, currentController.iqs) annotation (Line(points={{1,-20},{20,-20},
          {20,-6},{38,-6}}, color={0,0,127}));
  connect(vac, pLL.v) annotation (Line(points={{-120,-80},{-120,-80},{-82,-80}},
        color={0,0,127}));
  connect(pLL.theta, currentController.theta)
    annotation (Line(points={{-59,-80},{46,-80},{46,-12}}, color={0,0,127}));
  connect(vdcClone.y, currentController.vdc) annotation (Line(points={{1,-90},{
          1,-90},{54,-90},{54,-12}}, color={0,0,127}));
  connect(mppt.y, vdcPI.u_s)
    annotation (Line(points={{-59,46},{-22,46}}, color={0,0,127}));
  connect(vdc, vdcPI.u_m)
    annotation (Line(points={{-120,80},{-10,80},{-10,58}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-48,50},{12,-10}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-38,40},{-38,-4}}, color={192,192,192}),
        Polygon(
          points={{-38,40},{-42,32},{-34,32},{-38,40}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-42,0},{2,0}}, color={192,192,192}),
        Line(points={{-38,0},{-38,14},{-30,24},{2,24}}, color={0,0,127}),
        Line(
          visible=strict,
          points={{-30,24},{2,24}},
          color={255,0,0}),
        Polygon(
          points={{0,4},{-4,-4},{4,-4},{0,4}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          origin={-2,0},
          rotation=270),
        Line(points={{12,20},{52,20}}, color={0,0,127}),
        Line(points={{-88,20},{-48,20}}, color={0,0,127}),
        Line(points={{-68,20},{-68,-30},{32,-30},{32,20}}, color={0,0,127}),
        Polygon(
          points={{0,4},{-4,-4},{4,-4},{0,4}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          origin={56,20},
          rotation=270),
        Polygon(
          points={{0,4},{-4,-4},{4,-4},{0,4}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          origin={-52,20},
          rotation=270),
        Rectangle(
          extent={{-18,10},{42,-50}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-8,0},{-8,-44}}, color={192,192,192}),
        Polygon(
          points={{-8,0},{-12,-8},{-4,-8},{-8,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-12,-40},{32,-40}}, color={192,192,192}),
        Line(points={{-8,-40},{-8,-26},{0,-16},{32,-16}}, color={0,0,127}),
        Line(
          visible=strict,
          points={{0,-16},{32,-16}},
          color={255,0,0}),
        Polygon(
          points={{0,4},{-4,-4},{4,-4},{0,4}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          origin={28,-40},
          rotation=270),
        Line(points={{42,-20},{82,-20}}, color={0,0,127}),
        Line(points={{-58,-20},{-18,-20}}, color={0,0,127}),
        Line(points={{-38,-20},{-38,-70},{62,-70},{62,-20}}, color={0,0,127}),
        Polygon(
          points={{0,4},{-4,-4},{4,-4},{0,4}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          origin={86,-20},
          rotation=270),
        Polygon(
          points={{0,4},{-4,-4},{4,-4},{0,4}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          origin={-22,-20},
          rotation=270),
        Text(
          extent={{-100,80},{100,70}},
          lineColor={0,0,255},
          textString="PV control")}), Documentation(info="<html>
      <p>
        Complete controller for monophasic inverter. Currently under
        construction.
      </p>
      </html>"));
end Inverter1phCompleteController;
