within PVSystems.Electrical;
model SimpleBattery "Simple battery model"
  // Model taken from
  // TODO:
  // + Would be cool to have capacities relative to absolute battery capacity,
  //   i.e., 'it' from 0 to 1 instead of from 0 to Q.
  // + Would probably be more intuitive to provide parameter for initial State
  //   of charge (in relative terms) instead of initial depth of discharge.
  // + Would probably be nice to introduce safeguards around Q = it, which
  //   currently just produces a division by 0 an a simulation error.
  // + Would probably be more convenient to move the type definition of
  //   BatteryCapacity to another place.
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
