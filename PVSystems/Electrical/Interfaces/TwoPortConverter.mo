within PVSystems.Electrical.Interfaces;
partial model TwoPortConverter
  "Common interface for power converters with two ports"
  Modelica.SIunits.Voltage v1 "Voltage drop over the left port";
  Modelica.SIunits.Voltage v2 "Voltage drop over the right port";
  Modelica.SIunits.Current i1
    "Current flowing from pos. to neg. pin of the left port";
  Modelica.SIunits.Current i2
    "Current flowing from pos. to neg. pin of the right port";
  Modelica.Electrical.Analog.Interfaces.PositivePin p1
    "Positive pin of the left port (potential p1.v > n1.v for positive voltage drop v1)"
    annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n1
    "Negative pin of the left port"
    annotation (Placement(transformation(extent={{-90,-60},{-110,-40}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p2
    "Positive pin of the right port (potential p2.v > n2.v for positive voltage drop v2)"
    annotation (Placement(transformation(extent={{110,40},{90,60}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n2
    "Negative pin of the right port"
    annotation (Placement(transformation(extent={{90,-60},{110,-40}})));
equation
  v1 = p1.v - n1.v;
  v2 = p2.v - n2.v;
  i1 = p1.i;
  i2 = p2.i;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Polygon(
          points={{-120,53},{-110,50},{-120,47},{-120,53}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),Line(points={{-136,50},{-111,50}},
          color={160,160,164}),Polygon(
          points={{127,-47},{137,-50},{127,-53},{127,-47}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),Line(points={{111,-50},{136,-50}},
          color={160,160,164}),Text(
          extent={{112,-44},{128,-29}},
          lineColor={160,160,164},
          textString="i2"),Text(
          extent={{118,52},{135,67}},
          lineColor={0,0,0},
          textString="i2"),Polygon(
          points={{120,53},{110,50},{120,47},{120,53}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),Line(points={{111,50},{136,50}}),Line(points
          ={{-136,-49},{-111,-49}}, color={160,160,164}),Polygon(
          points={{-126,-46},{-136,-49},{-126,-52},{-126,-46}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),Text(
          extent={{-127,-46},{-110,-31}},
          lineColor={160,160,164},
          textString="i1"),Text(
          extent={{-136,53},{-119,68}},
          lineColor={160,160,164},
          textString="i1")}),Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Line(points={{-100,-100},{100,100}},
          color={0,0,255})}));
end TwoPortConverter;
