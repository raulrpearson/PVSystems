within PVSystems.Examples.Application;
model Inverter1phClosed
  "Stand-alone 1-phase closed-loop inverter with constant DC source"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Sources.ConstantVoltage DC(V=580) annotation (
      Placement(transformation(
        origin={-20,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-30,14},{-10,34}}, rotation=0)));
  PVSystems.Electrical.Assemblies.HBridge HB annotation (Placement(
        transformation(extent={{20,40},{40,60}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R(R=1e-2) annotation (Placement(
        transformation(
        origin={70,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor L(L=1e-3) annotation (Placement(
        transformation(
        origin={70,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Step iqSetpoint(height=141.4, startTime=0.3)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}}, rotation=0)));
  Modelica.Blocks.Sources.Step idSetpoint(
    height=141.4 - 200,
    offset=200,
    startTime=0.3)     annotation (Placement(transformation(extent={{-70,-40},{
            -50,-20}}, rotation=0)));
  Modelica.Blocks.Sources.SawTooth sawTooth(amplitude=2*Modelica.Constants.pi,
      period=0.02) annotation (Placement(transformation(extent={{-40,-60},{-20,
            -40}},rotation=0)));
  Control.Assemblies.Inverter1phCurrentController control annotation (Placement(
        transformation(
        origin={10,-10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.RealExpression iacSense(y=L.i)
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Blocks.Sources.RealExpression vdcSense(y=DC.v)
    annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
equation
  connect(DC.n, ground.p)
    annotation (Line(points={{-20,40},{-20,37},{-20,34}}, color={0,0,255}));
  connect(R.p, L.n)
    annotation (Line(points={{70,40},{70,60}}, color={0,0,255}));
  connect(HB.p1, DC.p) annotation (Line(points={{20,55},{0,55},{0,60},{-20,60}},
        color={0,0,255}));
  connect(HB.n1, DC.n) annotation (Line(points={{20,45},{0,45},{0,40},{-20,40}},
        color={0,0,255}));
  connect(HB.p2, L.p) annotation (Line(points={{40,55},{46,55},{46,80},{70,80}},
        color={0,0,255}));
  connect(HB.n2, R.n) annotation (Line(points={{40,45},{46,45},{46,20},{70,20}},
        color={0,0,255}));
  connect(sawTooth.y, control.theta) annotation (Line(points={{-19,-50},{-19,-50},
          {6,-50},{6,-22}}, color={0,0,127}));
  connect(control.d, HB.d)
    annotation (Line(points={{21,-10},{30,-10},{30,38}}, color={0,0,127}));
  connect(iqSetpoint.y, control.ids) annotation (Line(points={{-49,10},{-10,10},
          {-10,-4},{-2,-4}}, color={0,0,127}));
  connect(idSetpoint.y, control.iqs) annotation (Line(points={{-49,-30},{-10.5,
          -30},{-10.5,-16},{-2,-16}}, color={0,0,127}));
  connect(iacSense.y, control.i)
    annotation (Line(points={{-19,-10},{-2,-10}}, color={0,0,127}));
  connect(vdcSense.y, control.vdc) annotation (Line(points={{-49,-70},{-49,-70},
          {14,-70},{14,-22}}, color={0,0,127}));
  annotation (experiment(StopTime=0.6, __Dymola_NumberOfIntervals=3000),
                       Documentation(info="<html>
        <p>
          This example explores a closed-loop inverter. No grid is
          present, which simplifies things. But, since the
          controller is implemented in the synchronous (dq)
          reference frame, a synchronization source needs to
          exist. This is implemented with the saw tooth generator,
          which emulates the output of the PLL.
        </p>
      
        <p>
          As can be seen in the following figure, one can now
          comfortably specify the setpoint for the output current
          of the inverter:
        </p>
      
      
        <div class=\"figure\">
          <p><img src=\"modelica://PVSystems/Resources/Images/Inverter1phClosedResults.png\"
                  alt=\"Inverter1phClosedResults.png\" />
          </p>
        </div>
      
        <p>
          Having the posibility to separately control the current
          in each dq axis enables one to control the power factor
          (i.e. the phase lag between the voltage and the current)
          as well as the amplitude of the current.
        </p>
      
        <p>
          In this example, the equivalent synchronization signal
          is plotted to see this phase shift as the setpoints
          change. Notice how, when the q component of the current
          is 0, the d component is equal to the peak current.</p>
      </html>"),
    __Dymola_experimentSetupOutput);
end Inverter1phClosed;
