within PVSystems.Examples.Application;
model Inverter1phOpenSynch
  "Grid synchronized 1-phase open-loop inverter fed by constant DC source"
  extends Modelica.Icons.Example;
  PVSystems.Electrical.Assemblies.HBridgeSwitched HBsw annotation (Placement(
        transformation(extent={{30,70},{50,90}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage DCsrc(V=580) annotation (
      Placement(transformation(
        origin={-10,70},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sources.SineVoltage Grid(freqHz=50, V=480)
    annotation (Placement(transformation(
        origin={130,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor Lsw(L=500e-6) annotation (Placement(
        transformation(
        origin={80,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Control.PLL pLL annotation (Placement(transformation(
        origin={-90,-16},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Control.SignalPWM signalPWM(fs=3125) annotation (Placement(transformation(
        origin={40,10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Math.Cos sin annotation (Placement(transformation(
        origin={-56,-16},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Blocks.Math.Add add(k2=1, k1=580/580/2) annotation (Placement(
        transformation(
        origin={-20,-10},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Blocks.Sources.Constant const(k=0.5) annotation (Placement(
        transformation(
        origin={-90,16},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Ground gsrc annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,70})));
  Modelica.Electrical.Analog.Basic.Resistor Rsw(R=0.1) annotation (Placement(
        transformation(
        origin={110,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  PVSystems.Electrical.Assemblies.HBridgeAveraged HBav annotation (Placement(
        transformation(extent={{30,-40},{50,-20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor Lav(L=500e-6) annotation (Placement(
        transformation(
        origin={80,-20},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor Rav(R=0.1) annotation (Placement(
        transformation(
        origin={110,-20},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground gsw annotation (Placement(
        transformation(extent={{10,52},{30,72}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground gav annotation (Placement(
        transformation(extent={{10,-60},{30,-40}}, rotation=0)));
  Control.DeadTime deadTime annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,50})));
  Modelica.Blocks.Sources.RealExpression VacSense(y=Grid.v)
    annotation (Placement(transformation(extent={{-134,-26},{-114,-6}})));
equation
  connect(gsw.p, HBsw.n1)
    annotation (Line(points={{20,72},{20,75},{30,75}}, color={0,0,255}));
  connect(pLL.theta, sin.u)
    annotation (Line(points={{-79,-16},{-68,-16}}, color={0,0,127}));
  connect(const.y, add.u2) annotation (Line(points={{-79,16},{-40,16},{-40,-4},
          {-32,-4}},color={0,0,127}));
  connect(HBav.n1, gav.p)
    annotation (Line(points={{30,-35},{20,-35},{20,-40}}, color={0,0,255}));
  connect(sin.y, add.u1)
    annotation (Line(points={{-45,-16},{-32,-16}}, color={0,0,127}));
  connect(Rsw.p, Lsw.n)
    annotation (Line(points={{100,90},{90,90}}, color={0,0,255}));
  connect(Lav.n, Rav.p)
    annotation (Line(points={{90,-20},{100,-20}}, color={0,0,255}));
  connect(Rav.n, Grid.p)
    annotation (Line(points={{120,-20},{130,-20},{130,-60}}, color={0,0,255}));
  connect(HBsw.p2, Lsw.p) annotation (Line(points={{50,85},{60,85},{60,90},{70,
          90}}, color={0,0,255}));
  connect(HBav.p2, Lav.p) annotation (Line(points={{50,-25},{60,-25},{60,-20},{
          70,-20}}, color={0,0,255}));
  connect(gsrc.p, DCsrc.n)
    annotation (Line(points={{-30,70},{-20,70}}, color={0,0,255}));
  connect(DCsrc.p, HBsw.p1) annotation (Line(points={{0,70},{10,70},{10,85},{30,
          85}}, color={0,0,255}));
  connect(DCsrc.p, HBav.p1) annotation (Line(points={{0,70},{10,70},{10,-25},{
          30,-25}}, color={0,0,255}));
  connect(Rsw.n, Grid.p)
    annotation (Line(points={{120,90},{130,90},{130,-60}}, color={0,0,255}));
  connect(deadTime.c1, HBsw.c1)
    annotation (Line(points={{36,61},{36,70},{36,70}}, color={255,0,255}));
  connect(deadTime.c2, HBsw.c2)
    annotation (Line(points={{44,61},{44,65.5},{44,70}}, color={255,0,255}));
  connect(signalPWM.c1, deadTime.c)
    annotation (Line(points={{40,21},{40,30},{40,38}}, color={255,0,255}));
  connect(Grid.n, HBsw.n2) annotation (Line(points={{130,-80},{130,-90},{56,-90},
          {56,75},{50,75}}, color={0,0,255}));
  connect(Grid.n, HBav.n2) annotation (Line(points={{130,-80},{130,-90},{56,-90},
          {56,-35},{50,-35}}, color={0,0,255}));
  connect(add.y, signalPWM.vc) annotation (Line(points={{-9,-10},{0,-10},{40,-10},
          {40,-2}}, color={0,0,127}));
  connect(HBav.d, signalPWM.vc) annotation (Line(points={{40,-42},{40,-70},{0,-70},
          {0,-10},{40,-10},{40,-2}}, color={0,0,127}));
  connect(VacSense.y, pLL.v) annotation (Line(points={{-113,-16},{-113,-16},{-102,
          -16}}, color={0,0,127}));
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
        <p><img src=\"modelica://PVSystems/Resources/Images/Inverter1phOpenSynchResults.png\"
                alt=\"Inverter1phOpenSynchResults.png\" />
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

    Icon(coordinateSystem(initialScale=0.1)));
end Inverter1phOpenSynch;
