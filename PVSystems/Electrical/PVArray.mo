within PVSystems.Electrical;
model PVArray "Flexible PV array model"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  // Interface
  Modelica.Blocks.Interfaces.RealInput G "Solar irradiation" annotation (
      Placement(transformation(
        origin={-30,-55},
        extent={{-15,-15},{15,15}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealInput T "Panel temperature" annotation (
      Placement(transformation(
        origin={30,-55},
        extent={{-15,-15},{15,15}},
        rotation=90)));
  // Constants
  constant Modelica.SIunits.Charge q=1.60217646e-19 "Electron charge";
  constant Real Gn=1000 "STC irradiation";
  constant Modelica.SIunits.Temperature Tn=298.15 "STC temperature";
  // Basic datasheet parameters
  parameter Modelica.SIunits.Current Imp=7.61 "Maximum power current";
  parameter Modelica.SIunits.Voltage Vmp=26.3 "Maximum power voltage";
  parameter Modelica.SIunits.Current Iscn=8.21 "Short circuit current";
  parameter Modelica.SIunits.Voltage Vocn=32.9 "Open circuit voltage";
  parameter Real Kv=-0.123 "Voc temperature coefficient";
  parameter Real Ki=3.18e-3 "Isc temperature coefficient";
  // Basic model parameters
  parameter Real Ns=54 "Number of cells in series";
  parameter Real Np=1 "Number of cells in parallel";
  parameter Modelica.SIunits.Resistance Rs=0.221
    "Equivalent series resistance of array";
  parameter Modelica.SIunits.Resistance Rp=415.405
    "Equivalent parallel resistance of array";
  parameter Real a=1.3 "Diode ideality constant";
  // Derived model parameters
  parameter Modelica.SIunits.Current Ipvn=Iscn "Photovoltaic current at STC";
  // Variables
  Modelica.SIunits.Voltage Vt "Thermal voltage of the array";
  Modelica.SIunits.Current Ipv "Photovoltaic current of the cell";
  Modelica.SIunits.Current I0 "Saturation current of the cell";
  Modelica.SIunits.Current Id "Diode current";
  Modelica.SIunits.Current Ir "Rp current";
equation
  // Auxiliary variables
  Vt = Ns*Modelica.Constants.k*T/q;
  Ipv = (Ipvn + Ki*(T - Tn))*G/Gn;
  I0 = (Iscn + Ki*(T - Tn))/(exp((Vocn + Kv*(T - Tn))/a/Vt) - 1);
  Id = I0*(exp((v - Rs*i)/a/Vt) - 1);
  Ir = (v - Rs*i)/Rp;
  if v < 0 then
    i = v/((Rs + Rp)/Np);
  elseif v > Vocn then
    i = 0;
  else
    i = -Np*(Ipv - Id - Ir);
  end if;
  annotation (
    Documentation(info="<html><p>Flexible PV array model. The model can be
  parametrized with the use of PV module datasheets. As a default, the
  data from the Kyocera KC200GT is provided. The model is presented in
  \"Comprehensive Approach to Modeling and Simulation of Photovoltaic
  Arrays\" by M.G. Villalva et al.</p></html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Line(points={{-90,0},{-60,0}}, color={0,0,0}),
          Rectangle(
          extent={{-60,-40},{60,40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Line(points={{-60,-40},{-20,0}}, color
          ={0,0,0}),Line(points={{-20,0},{-60,40}}, color={0,0,0}),Line(points=
          {{60,0},{90,0}}, color={0,0,0})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2})));
end PVArray;
