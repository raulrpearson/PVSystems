within PVSystems.Examples.Application;
model Inverter1phOpenSynch
  "Grid synchronized 1-phase open-loop inverter fed by constant DC source"
  extends Modelica.Icons.Example;
  Electrical.Assemblies.HBridge HBsw(redeclare model SwitchModel =
        Electrical.SwitchedSynchronous (fs=3125))
    annotation (Placement(transformation(extent={{0,40},{20,60}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage Ssw(V=580) annotation (
      Placement(transformation(
        origin={-30,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.SineVoltage Gsw(freqHz=50, V=480)
    annotation (Placement(transformation(
        origin={50,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor Lsw(L=500e-6) annotation (Placement(
        transformation(
        origin={50,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Control.PLL pLL annotation (Placement(transformation(
        origin={-80,-56},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Blocks.Math.Cos sin annotation (Placement(transformation(
        origin={-46,-56},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Blocks.Math.Add add(k2=1, k1=580/580/2) annotation (Placement(
        transformation(
        origin={-10,-50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Blocks.Sources.Constant const(k=0.5) annotation (Placement(
        transformation(
        origin={-80,-24},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Resistor Rsw(R=0.1) annotation (Placement(
        transformation(
        origin={50,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  PVSystems.Electrical.Assemblies.HBridge HBav annotation (Placement(
        transformation(extent={{70,-20},{90,0}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor Lav(L=500e-6) annotation (Placement(
        transformation(
        origin={120,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor Rav(R=0.1) annotation (Placement(
        transformation(
        origin={120,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground gsw annotation (Placement(
        transformation(extent={{-40,20},{-20,40}},
                                                 rotation=0)));
  Modelica.Blocks.Sources.RealExpression VacSense(y=Gsw.v)
    annotation (Placement(transformation(extent={{-120,-66},{-100,-46}})));
  Modelica.Electrical.Analog.Sources.SineVoltage Gav(freqHz=50, V=480)
    annotation (Placement(transformation(
        origin={120,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage Sav(V=580) annotation (
      Placement(transformation(
        origin={40,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground gav annotation (Placement(
        transformation(extent={{30,-40},{50,-20}}, rotation=0)));
equation
  connect(pLL.theta, sin.u)
    annotation (Line(points={{-69,-56},{-58,-56}}, color={0,0,127}));
  connect(const.y, add.u2) annotation (Line(points={{-69,-24},{-30,-24},{-30,
          -44},{-22,-44}},
                    color={0,0,127}));
  connect(sin.y, add.u1)
    annotation (Line(points={{-35,-56},{-22,-56}}, color={0,0,127}));
  connect(VacSense.y, pLL.v) annotation (Line(points={{-99,-56},{-99,-56},{-92,
          -56}}, color={0,0,127}));
  connect(Gav.p, Rav.n)
    annotation (Line(points={{120,-20},{120,-20}}, color={0,0,255}));
  connect(Rav.p, Lav.n)
    annotation (Line(points={{120,0},{120,0}}, color={0,0,255}));
  connect(HBav.p2, Lav.p) annotation (Line(points={{90,-5},{100,-5},{100,20},{
          120,20}}, color={0,0,255}));
  connect(HBav.n2, Gav.n) annotation (Line(points={{90,-15},{100,-15},{100,-40},
          {120,-40}}, color={0,0,255}));
  connect(Gsw.p, Rsw.n)
    annotation (Line(points={{50,40},{50,40}}, color={0,0,255}));
  connect(Rsw.p, Lsw.n)
    annotation (Line(points={{50,60},{50,60}}, color={0,0,255}));
  connect(HBsw.n2, Gsw.n) annotation (Line(points={{20,45},{30,45},{30,20},{50,
          20}}, color={0,0,255}));
  connect(HBsw.p2, Lsw.p) annotation (Line(points={{20,55},{30,55},{30,80},{50,
          80}}, color={0,0,255}));
  connect(Sav.n, gav.p)
    annotation (Line(points={{40,-20},{40,-20}}, color={0,0,255}));
  connect(Ssw.n, gsw.p)
    annotation (Line(points={{-30,40},{-30,40}}, color={0,0,255}));
  connect(Ssw.p, HBsw.p1) annotation (Line(points={{-30,60},{-14,60},{-14,55},{
          0,55}}, color={0,0,255}));
  connect(Ssw.n, HBsw.n1) annotation (Line(points={{-30,40},{-14,40},{-14,45},{
          0,45}}, color={0,0,255}));
  connect(Sav.n, HBav.n1) annotation (Line(points={{40,-20},{56,-20},{56,-15},{
          70,-15}}, color={0,0,255}));
  connect(Sav.p, HBav.p1)
    annotation (Line(points={{40,0},{56,0},{56,-5},{70,-5}}, color={0,0,255}));
  connect(add.y, HBav.d)
    annotation (Line(points={{1,-50},{80,-50},{80,-22}}, color={0,0,127}));
  connect(HBsw.d, HBav.d) annotation (Line(points={{10,38},{10,-50},{80,-50},{
          80,-22}}, color={0,0,127}));
  annotation (
    experiment(
      StartTime=0,
      StopTime=0.1,
      Tolerance=1e-4),
    Documentation(info="<html>
      <p>
        This example goes a step further
        than <a href=\"Modelica://PVSystems.Examples.Application.Inverter1phOpen\">Inverter1phOpen</a>
        and includes grid synchronization. Typically this is the condition
        for inverters in real-life situations. Both switched and averaged
        implementations are presented for comparison purposes and it can be
        seen that they both provide very similar results (excluding the fact
        that high frequencies are left out in the averaged model).
      </p>


      <div class=\"figure\">
        <p><img src=\"modelica://PVSystems/Resources/Images/Inverter1phOpenSynch_Plot.png\"
                alt=\"Inverter1phOpenSynch_Plot.png\" />
        </p>
      </div>

      <p>
        Since this is still open-loop and there's no in-quadrature
        separation, the value of the current can't comfortably be specified
        to be of a certain value. Since the RL load has almost equal real
        and imaginary parts, the current that is drawn from the inverter has
        a power factor different than one.
      </p>

      <p>
        A key value to pay attention to in this example is the gain that is
        placed in the <i>Add</i> block.
      </p>


      <div class=\"figure\">
        <p><img src=\"modelica://PVSystems/Resources/Images/Inverter1phOpenSynchDialog.png\"
                alt=\"Inverter1phOpenSynchDialog.png\" />
        </p>
      </div>

      <p>
        It's initially set at 0.5. The value is expressed as 580/580/2 to
        highlight the fact that this gain should be normalized to the DC
        voltage value. Above that, over-modulation will occur and the output
        current of the inverter will become quite ugly. Play around with
        this value (using values between 0 and 0.5) to see how the output
        current of the inverter changes.
      </p>
      </html>"),
    Diagram(coordinateSystem(extent={{-140,-100},{140,100}}, initialScale=0.1)),
    Icon(coordinateSystem(initialScale=0.1)),
    __Dymola_Commands(file="Resources/Scripts/Dymola/Inverter1phOpenSynch_RunPlotAndSave.mos"
        "RunPlotAndSave"));
end Inverter1phOpenSynch;
