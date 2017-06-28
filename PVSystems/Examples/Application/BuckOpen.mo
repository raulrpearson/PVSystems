within PVSystems.Examples.Application;
model BuckOpen "Ideal open-loop buck converter"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Sources.ConstantVoltage DC(V=24)
                                                             annotation (
      Placement(transformation(
        origin={-30,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor Rav(R=3)   annotation (Placement(
        transformation(
        origin={70,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor Lav(L=8e-6) annotation (Placement(
        transformation(extent={{20,-40},{40,-20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor Cav(C=10e-6)  annotation (
      Placement(transformation(
        origin={50,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  replaceable Electrical.CCM_DCM1 sn(Le=Lav.L, fs=PWM.fs)
                                                      constrainedby
    PVSystems.Electrical.Interfaces.SwitchNetworkInterface annotation (
      Placement(transformation(extent={{-10,-36},{10,-16}},
                                                         rotation=0)),
      choicesAllMatching=true);
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch sw annotation (Placement(
        transformation(extent={{-20,70},{0,50}},  rotation=0)));
  Modelica.Electrical.Analog.Ideal.IdealDiode dsw annotation (Placement(
        transformation(
        origin={10,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Control.SwitchingPWM PWM(fs=1e5) annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},            rotation=90,
        origin={-10,30})));
  Modelica.Electrical.Analog.Basic.Resistor Rsw(R=3)   annotation (Placement(
        transformation(
        origin={70,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor Lsw(L=8e-6) annotation (Placement(
        transformation(extent={{20,50},{40,70}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor Csw(C=10e-6)  annotation (
      Placement(transformation(
        origin={50,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground gin annotation (Placement(
        transformation(extent={{-40,-76},{-20,-56}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground gsw annotation (Placement(
        transformation(extent={{20,10},{40,30}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground gav annotation (Placement(
        transformation(extent={{20,-80},{40,-60}}, rotation=0)));
  Modelica.Blocks.Sources.RealExpression duty(y=if time < 5e-4 then 0.1 else 0.6)
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
equation
  connect(Cav.n, gav.p)
    annotation (Line(points={{50,-60},{30,-60}}, color={0,0,255}));
  connect(Rav.n, gav.p)
    annotation (Line(points={{70,-60},{30,-60}}, color={0,0,255}));
  connect(Lav.n, Rav.p)
    annotation (Line(points={{40,-30},{70,-30},{70,-40}}, color={0,0,255}));
  connect(Cav.p, Lav.n)
    annotation (Line(points={{50,-40},{50,-30},{40,-30}}, color={0,0,255}));
  connect(DC.p, sn.p1)
    annotation (Line(points={{-30,-30},{-30,-21},{-10,-21}}, color={0,0,255}));
  connect(sn.p2, Lav.p)
    annotation (Line(points={{10,-21},{20,-21},{20,-30}}, color={0,0,255}));
  connect(sn.n2, gav.p)
    annotation (Line(points={{10,-31},{10,-60},{30,-60}}, color={0,0,255}));
  connect(sw.p, DC.p)
    annotation (Line(points={{-20,60},{-30,60},{-30,-30}}, color={0,0,255}));
  connect(sw.n, dsw.n)
    annotation (Line(points={{0,60},{10,60},{10,50}},  color={0,0,255}));
  connect(Lsw.n, Rsw.p)
    annotation (Line(points={{40,60},{70,60},{70,50}}, color={0,0,255}));
  connect(Csw.p, Lsw.n)
    annotation (Line(points={{50,50},{50,60},{40,60}}, color={0,0,255}));
  connect(Lsw.p, dsw.n)
    annotation (Line(points={{20,60},{10,60},{10,50}}, color={0,0,255}));
  connect(Csw.n, Rsw.n)
    annotation (Line(points={{50,30},{70,30}}, color={0,0,255}));
  connect(dsw.p, gsw.p)
    annotation (Line(points={{10,30},{30,30}}, color={0,0,255}));
  connect(gsw.p, Csw.n)
    annotation (Line(points={{30,30},{50,30}}, color={0,0,255}));
  connect(gin.p, DC.n)
    annotation (Line(points={{-30,-56},{-30,-53},{-30,-50}}, color={0,0,255}));
  connect(PWM.c1, sw.control)
    annotation (Line(points={{-10,41},{-10,41},{-10,53}}, color={255,0,255}));
  connect(PWM.vc, sn.d) annotation (Line(points={{-10,18},{-10,10},{-50,10},{-50,
          -80},{0,-80},{0,-38}}, color={0,0,127}));
  connect(sn.n1, Lav.p) annotation (Line(points={{-10,-31},{-20,-31},{-20,-4},{20,
          -4},{20,-30}}, color={0,0,255}));
  connect(duty.y, sn.d)
    annotation (Line(points={{-69,-80},{0,-80},{0,-38}}, color={0,0,127}));
  annotation (
    Diagram(graphics={Text(
          extent={{32,-8},{70,-20}},
          lineColor={0,0,255},
          textString="Modifiable model"),
                      Text(
          extent={{32,78},{70,66}},
          lineColor={0,0,255},
          textString="Switched model")}),
    experiment(StopTime=0.001, __Dymola_NumberOfIntervals=1000),
    Documentation(info="<html>
        <p>
          This example compares two implementations of a buck
          DC-DC converter. The switched version is built using
          mostly blocks
          from <a href=\"Modelica://Modelica.Electrical.Analog\">Modelica's
          electrical library</a> but also includes
          the <a href=\"Modelica://PVSystems.Control.SwitchingPWM\">SwitchingPWM</a>
          model. The averaged version is built around a
          replaceable instance of the average switch model for CCM
          (continuous conduction mode) and DCM (discontinuous
          conduction mode) considering no losses.
        </p>
      
        <p>
          This example showcases how components from PVSystems can
          be mixed with components from the Modelica Standard
          Library to build systems that might be of
          interest. Additionally, it aims validating the average
          switch model performance by comparison with the more
          accurate/detailed switched model.
        </p>
      
        <p>
          This is still an open-loop system. A duty cycle value is
          fed to the SwitchingPWM block to drive the ideal closing
          switch or to the averaged switch network model. The duty
          cycle value begins at 0.1 and changes to 0.6 in the
          middle of the simulation. The effect of this change can
          be observed by plotting the output voltages:
        </p>
      
      
        <div class=\"figure\">
          <p><img src=\"modelica://PVSystems/Resources/Images/BuckOpenResultsA.png\"
                  alt=\"BuckOpenResultsA.png\" />
          </p>
        </div>
      
        <p>
          The output voltage for both implementations is not
          exactly the same but it can be seen that the averaged
          model provides a very decent approximation. This is the
          case because both the switching and the averaged
          implementations are neglecting losses and because they
          are both correctly modelling CCM and DCM modes. The
          converter is operating in DCM in the first interval and
          in CCM in the second:
        </p>
      
      
        <div class=\"figure\">
          <p><img src=\"modelica://PVSystems/Resources/Images/BuckOpenResultsB.png\"
                  alt=\"BuckOpenResultsB.png\" />
          </p>
        </div>
      
        <p>
          An interesting exercise to complete this example would
          be to build a controller to close the loop and study the
          system's behaviour.</p>
      </html>"),
    __Dymola_experimentSetupOutput);
end BuckOpen;
