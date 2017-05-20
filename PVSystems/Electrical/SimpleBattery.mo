within PVSystems.Electrical;
model SimpleBattery "Simple battery model"
  extends Interfaces.BatteryInterface;
  import Modelica.SIunits.Resistance;
  import Modelica.SIunits.Voltage;
  import Modelica.SIunits.Current;
  type BatteryCapacity = Real (final quantity="Energy", final unit="A.h");
  // Parameters (Li-ion values as defaults)
  parameter Resistance Rint=0.09 "Internal resistance";
  parameter Voltage E0=3.7348 "Constant battery voltage";
  parameter Voltage K=0.00876 "Polarization voltage";
  parameter BatteryCapacity Q=1 "Rated battery capacity";
  parameter Voltage A=0.468 "Exponential region amplitude";
  parameter Real B=3.5294 "Exponential zone time constant inverse";
  parameter BatteryCapacity DoDini=0 "Initial Depth of Discharge";
  // Variables
  Voltage E;
  BatteryCapacity it(start=DoDini, fixed=true) "Actual depth of discharge";
equation
  v = E + i*Rint;
  der(it) = -i/3600;
  E = max(0, E0 - K*Q/(Q - it) + A*exp(-B*it));
end SimpleBattery;
