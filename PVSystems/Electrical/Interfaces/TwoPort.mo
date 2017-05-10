within PVSystems.Electrical.Interfaces;
partial model TwoPort "Common interface for power converters with two ports"
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
end TwoPort;
