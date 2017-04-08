within PVSystems.Examples.Application;
model Inverter1phOpenSynch
  "Grid synchronized 1-phase open-loop inverter fed by constant DC source"
  extends Modelica.Icons.Example;
  PVSystems.Electrical.Assemblies.HBridgeSwitched HBsw annotation (Placement(
        transformation(extent={{-60,80},{-40,100}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage DCsrc(V=580) annotation (
      Placement(transformation(
        origin={-90,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.SineVoltage Grid(freqHz=50, V=480)
    annotation (Placement(transformation(
        origin={90,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor Lsw1(L=500e-6) annotation (
      Placement(transformation(
        origin={90,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Control.PLL pLL annotation (Placement(transformation(
        origin={-74,-60},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor VSac annotation (Placement(
        transformation(
        origin={70,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Control.SignalPWM signalPWM(fs=3125, provideComplement=true) annotation (
      Placement(transformation(
        origin={-52,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Math.Cos sin annotation (Placement(transformation(
        origin={-44,-60},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Blocks.Math.Add add(k2=1, k1=580/580/2) annotation (Placement(
        transformation(
        origin={-10,-54},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Blocks.Sources.Constant const(k=0.5) annotation (Placement(
        transformation(
        origin={-70,-30},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Ground gsrc annotation (Placement(
        transformation(extent={{-100,12},{-80,32}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor Rsw1(R=0.1) annotation (Placement(
        transformation(
        origin={90,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  PVSystems.Electrical.Assemblies.HBridgeAveraged HBav
    annotation (Placement(transformation(extent={{0,48},{20,68}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor Lav1(L=500e-6) annotation (
      Placement(transformation(
        origin={50,38},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor Rav1(R=0.1) annotation (Placement(
        transformation(
        origin={50,8},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground gsw annotation (Placement(
        transformation(extent={{-80,62},{-60,82}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground gav annotation (Placement(
        transformation(extent={{-20,28},{0,48}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor Lsw2(L=500e-6) annotation (
      Placement(transformation(
        origin={-28,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor Rsw2(R=0.1) annotation (Placement(
        transformation(
        origin={-28,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor Lav2(L=500e-6) annotation (
      Placement(transformation(
        origin={28,22},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor Rav2(R=0.1) annotation (Placement(
        transformation(
        origin={28,-8},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(HBsw.acp, Lsw1.p)
    annotation (Line(points={{-40,95},{90,95},{90,80}}, color={0,0,255}));
  connect(Lsw1.n, Rsw1.p)
    annotation (Line(points={{90,60},{90,50}}, color={0,0,255}));
  connect(Rsw1.n, Grid.p)
    annotation (Line(points={{90,30},{90,-20}}, color={0,0,255}));
  connect(Grid.p, VSac.p)
    annotation (Line(points={{90,-20},{70,-20}}, color={0,0,255}));
  connect(Grid.n, VSac.n)
    annotation (Line(points={{90,-40},{70,-40}}, color={0,0,255}));
  connect(Lav1.n, Rav1.p)
    annotation (Line(points={{50,28},{50,18}}, color={0,0,255}));
  connect(HBav.acp, Lav1.p)
    annotation (Line(points={{20,63},{50,63},{50,48}}, color={0,0,255}));
  connect(DCsrc.p, HBsw.dcp)
    annotation (Line(points={{-90,60},{-90,95},{-60,95}}, color={0,0,255}));
  connect(HBav.dcp, DCsrc.p)
    annotation (Line(points={{0,63},{-90,63},{-90,60}}, color={0,0,255}));
  connect(gsrc.p, DCsrc.n)
    annotation (Line(points={{-90,32},{-90,40}}, color={0,0,255}));
  connect(gsw.p, HBsw.dcn)
    annotation (Line(points={{-70,82},{-70,85},{-60,85}}, color={0,0,255}));
  connect(pLL.theta, sin.u)
    annotation (Line(points={{-63,-60},{-56,-60}}, color={0,0,127}));
  connect(const.y, add.u2) annotation (Line(points={{-59,-30},{-30,-30},{-30,-48},
          {-22,-48}}, color={0,0,127}));
  connect(HBav.dcn, gav.p)
    annotation (Line(points={{0,53},{-10,53},{-10,48}}, color={0,0,255}));
  connect(sin.y, add.u1)
    annotation (Line(points={{-33,-60},{-22,-60}}, color={0,0,127}));
  connect(HBav.d, add.y)
    annotation (Line(points={{10,46},{10,-54},{1,-54}}, color={0,0,127}));
  connect(Rav1.n, VSac.p)
    annotation (Line(points={{50,-2},{50,-20},{70,-20}}, color={0,0,255}));
  connect(VSac.v, pLL.v) annotation (Line(points={{60,-30},{50,-30},{50,-90},{-94,
          -90},{-94,-60},{-86,-60}}, color={0,0,127}));
  connect(Lsw2.n, Rsw2.p) annotation (Line(points={{-28,30},{-28,27.5},{-28,
          27.5},{-28,25},{-28,20},{-28,20}}, color={0,0,255}));
  connect(HBsw.acn, Lsw2.p)
    annotation (Line(points={{-40,85},{-28,85},{-28,50}}, color={0,0,255}));
  connect(Rsw2.n, VSac.n)
    annotation (Line(points={{-28,0},{-28,-40},{70,-40}}, color={0,0,255}));
  connect(Lav2.n, Rav2.p) annotation (Line(points={{28,12},{28,9.5},{28,9.5},{
          28,7},{28,2},{28,2}}, color={0,0,255}));
  connect(HBav.acn, Lav2.p)
    annotation (Line(points={{20,53},{28,53},{28,32}}, color={0,0,255}));
  connect(Rav2.n, VSac.n)
    annotation (Line(points={{28,-18},{28,-40},{70,-40}}, color={0,0,255}));
  connect(add.y, signalPWM.vc) annotation (Line(points={{1,-54},{10,-54},{10,-10},
          {-52,-10},{-52,18}}, color={0,0,127}));
  connect(signalPWM.c1, HBsw.fireA)
    annotation (Line(points={{-52,41},{-52,80},{-53,80}}, color={255,0,255}));
  connect(signalPWM.c2, HBsw.fireB)
    annotation (Line(points={{-44,41},{-47,41},{-47,80}}, color={255,0,255}));
  annotation (experiment(
      StartTime=0,
      StopTime=0.1,
      Tolerance=1e-4), Documentation(info="<html>
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
      </html>"));
end Inverter1phOpenSynch;
