within PVSystems.Examples.Verification;
model SwitchingCPMValidation "Simple model to validate SwitchingCPM behaviour"
  extends Modelica.Icons.Example;
  Control.SwitchingCPM switchingCPM(
    vcMax=5,
    dMin=0.05,
    dMax=0.95,
    fs=200e3,
    Va=0.005) annotation (Placement(transformation(extent={{-20,-14},{0,6}})));
  Modelica.Blocks.Continuous.Integrator integrator(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=3.99)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Blocks.Sources.Constant vdT(k=2e4)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Constant vdpT(k=-1e4)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Blocks.Sources.Constant vc(k=4)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(vdT.y, switch1.u1)
    annotation (Line(points={{1,40},{10,40},{10,8},{18,8}}, color={0,0,127}));
  connect(switch1.y, integrator.u)
    annotation (Line(points={{41,0},{41,0},{48,0}}, color={0,0,127}));
  connect(vdpT.y, switch1.u3) annotation (Line(points={{1,-40},{10,-40},{10,-8},
          {18,-8}}, color={0,0,127}));
  connect(switchingCPM.c, switch1.u2)
    annotation (Line(points={{1,0},{18,0}}, color={255,0,255}));
  connect(integrator.y, switchingCPM.vs) annotation (Line(points={{71,0},{80,0},
          {80,-60},{-30,-60},{-30,-8},{-22,-8}}, color={0,0,127}));
  connect(vc.y, switchingCPM.vc)
    annotation (Line(points={{-39,0},{-22,0}}, color={0,0,127}));
  annotation (experiment(StopTime=0.001, __Dymola_NumberOfIntervals=5000),
      Documentation(info="<html>
      <p>
        SignalPWMValidation presents a very simple model aimed at validating
        the behaviour of the SignalPWM block. It provides a changing duty
        cycle with the use of two step blocks. When running the simulation
        with the provided values, plotting the fire output generates the
        following graph:
      </p>


      <div class=\"figure\">
        <p><img src=\"modelica://PVSystems/Resources/Images/SignalPWMValidationResults.png\"
                alt=\"SignalPWMValidationResults.png\" />
        </p>
      </div>

      <p>
        Through inspection of the plot, it can be seen how the signal
        constitutes a PWM signal with a duty cycle changing in steps through
        the values 0.2, 0.5 and 0.8. Zoom into the signal to confirm this
        fact as well as the value of the period, set at 10 milliseconds.
      </p>
      </html>"));
end SwitchingCPMValidation;
