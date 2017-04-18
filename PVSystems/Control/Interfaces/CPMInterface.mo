within PVSystems.Control.Interfaces;
partial model CPMInterface "Common interface for averaged CPM block"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Inductance L
    "Equivalent inductance, referred to primary";
  parameter Modelica.SIunits.Frequency fs
    "Switching frequency";
  parameter Modelica.SIunits.Voltage Va
    "Amplitude of the artificial ramp, Va=Rf*ma/fs";
  parameter Modelica.SIunits.Resistance Rf
    "Equivalent current-sense resistance";
  Modelica.Blocks.Interfaces.RealInput vc
    "Control input, vc=Rf*ic"
    annotation (
      Placement(transformation(extent={{-140,80},{-100,120}}, rotation=0),
        iconTransformation(extent={{-140,80},{-100,120}})));
  Modelica.Blocks.Interfaces.RealInput vs
    "Sensed average inductor current vs=Rf*iL"
    annotation (
      Placement(transformation(extent={{-140,20},{-100,60}}, rotation=0),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput vm1
    "Voltage across L in interval 1, slope m1=vm1/L"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}},
          rotation=0), iconTransformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput vm2
    "(-) Voltage across L in interval 2, slope m2=vm2/L"
    annotation (Placement(transformation(extent={{-140,-120},{-100,-80}},
          rotation=0), iconTransformation(extent={{-140,-120},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealOutput d
    "Duty cycle"
    annotation (Placement(
        transformation(extent={{100,-10},{120,10}}, rotation=0)));
  annotation(Documentation(info="
    <html>
      <p>
        Common interface for averaged CPM block</p>
    </html>"));
end CPMInterface;
