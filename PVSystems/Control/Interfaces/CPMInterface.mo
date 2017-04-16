within PVSystems.Control.Interfaces;
partial model CPMInterface "Common interface for averaged CPM block"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Inductance L "Inductance";
  parameter Modelica.SIunits.Resistance Rf "Equivalent sensing resistance";
  parameter Modelica.SIunits.Frequency fs "Switching frequency";
  parameter Modelica.SIunits.Voltage Va "Articial ramp amplitude";
  Modelica.Blocks.Interfaces.RealInput vc "Control voltage" annotation (
      Placement(transformation(extent={{-140,80},{-100,120}}, rotation=0),
        iconTransformation(extent={{-140,80},{-100,120}})));
  Modelica.Blocks.Interfaces.RealInput vs "Sensed voltage" annotation (
      Placement(transformation(extent={{-140,20},{-100,60}}, rotation=0),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput vm1 "Voltage accross inductor in DTs"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}},
          rotation=0), iconTransformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput vm2 "Voltage accros inductor in D'Ts"
    annotation (Placement(transformation(extent={{-140,-120},{-100,-80}},
          rotation=0), iconTransformation(extent={{-140,-120},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealOutput d "Duty cycle" annotation (Placement(
        transformation(extent={{100,-10},{120,10}}, rotation=0)));
end CPMInterface;
