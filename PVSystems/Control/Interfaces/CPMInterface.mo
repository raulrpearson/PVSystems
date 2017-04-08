within PVSystems.Control.Interfaces;
model CPMInterface "Common interface for averaged CPM block"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Inductance L "Inductance";
  parameter Modelica.SIunits.Resistance Rf "Equivalent sensing resistance";
  parameter Modelica.SIunits.Frequency fs "Switching frequency";
  parameter Modelica.SIunits.Voltage Va "Articial ramp amplitude";
  Modelica.Blocks.Interfaces.RealInput vc "Control voltage" annotation (
      Placement(transformation(extent={{-140,70},{-100,110}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput vs "Sensed voltage" annotation (
      Placement(transformation(extent={{-140,10},{-100,50}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput vm1 "Voltage accross inductor in DTs"
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealInput vm2 "Voltage accros inductor in D'Ts"
    annotation (Placement(transformation(extent={{-140,-110},{-100,-70}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput d "Duty cycle" annotation (Placement(
        transformation(extent={{100,-10},{120,10}}, rotation=0)));
end CPMInterface;
