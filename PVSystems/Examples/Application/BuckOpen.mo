within PVSystems.Examples.Application;
model BuckOpen "Ideal synchronous open-loop buck converter"
      extends Modelica.Icons.Example;
      Modelica.Electrical.Analog.Sources.ConstantVoltage src(V=5)
        annotation (Placement(transformation(
            origin={-20,-32},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor resav(R=0.4)
        annotation (Placement(transformation(
            origin={80,-42},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Inductor indav(L=1e-6)
        annotation (Placement(transformation(extent={{30,-32},{50,-12}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Capacitor capav(C=200e-6)
        annotation (Placement(transformation(
            origin={60,-42},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      PVSystems.Electrical.IdealAverageCCMSwitch idealAverageCCMSwitch
        annotation (Placement(transformation(extent={{0,-28},{20,-8}}, rotation=
               0)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch
        annotation (Placement(transformation(extent={{-10,38},{10,58}},
              rotation=0)));
      Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode
        annotation (Placement(transformation(
            origin={20,28},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Control.SignalPWM signalPWM(period=1e-5)
        annotation (Placement(transformation(extent={{-30,58},{-10,78}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Resistor ressw(R=0.4)
        annotation (Placement(transformation(
            origin={80,28},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Inductor indsw(L=1e-6)
        annotation (Placement(transformation(extent={{30,38},{50,58}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Capacitor capsw(C=200e-6)
        annotation (Placement(transformation(
            origin={60,28},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.Step iStep(
        height=0.4,
        startTime=0.01,
        offset=0.2)
        annotation (Placement(transformation(extent={{-100,-22},{-80,-2}},
              rotation=0)));
      Modelica.Blocks.Sources.Step fStep(
        height=0.1,
        offset=0,
        startTime=0.015)
        annotation (Placement(transformation(extent={{-100,20},{-80,40}},
              rotation=0)));
      Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent=
                {{-62,-2},{-42,18}}, rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground gsrc
        annotation (Placement(transformation(extent={{-30,-68},{-10,-48}},
              rotation=0)));
      Modelica.Electrical.Analog.Basic.Ground gsw
        annotation (Placement(transformation(extent={{30,-2},{50,18}}, rotation=
               0)));
      Modelica.Electrical.Analog.Basic.Ground gav
        annotation (Placement(transformation(extent={{30,-72},{50,-52}},
              rotation=0)));
    equation
      connect(capav.n, gav.p)
        annotation (Line(points={{60,-52},{40,-52}}, color={0,0,255}));
      connect(resav.n, gav.p)
        annotation (Line(points={{80,-52},{40,-52}}, color={0,0,255}));
      connect(indav.n, resav.p)
        annotation (Line(points={{50,-22},{80,-22},{80,-32}}, color={0,0,255}));
      connect(capav.p, indav.n)
        annotation (Line(points={{60,-32},{60,-22},{50,-22}}, color={0,0,255}));
      connect(src.p, idealAverageCCMSwitch.p1)
        annotation (Line(points={{-20,-22},{-20,-13},{0,-13}}, color={0,0,255}));
      connect(idealAverageCCMSwitch.p2, indav.p)
        annotation (Line(points={{20,-13},{30,-13},{30,-22}}, color={0,0,255}));
      connect(idealAverageCCMSwitch.n2, gav.p)
        annotation (Line(points={{20,-23},{20,-52},{40,-52}}, color={0,0,255}));
      connect(idealAverageCCMSwitch.n1, indav.p)
        annotation (Line(points={{0,-23},{0,-42},{30,-42},{30,-22}}, color={0,0,
              255}));
      connect(signalPWM.fire,idealClosingSwitch. control)
        annotation (Line(points={{-10,73},{0,73},{0,55}}, color={255,0,255}));
      connect(idealClosingSwitch.p, src.p)
        annotation (Line(points={{-10,48},{-20,48},{-20,-22}}, color={0,0,255}));
      connect(idealClosingSwitch.n, idealDiode.n)
        annotation (Line(points={{10,48},{20,48},{20,38}}, color={0,0,255}));
      connect(indsw.n, ressw.p)
        annotation (Line(points={{50,48},{80,48},{80,38}}, color={0,0,255}));
      connect(capsw.p, indsw.n)
        annotation (Line(points={{60,38},{60,48},{50,48}}, color={0,0,255}));
      connect(indsw.p, idealDiode.n)
        annotation (Line(points={{30,48},{20,48},{20,38}}, color={0,0,255}));
      connect(fStep.y, add.u1)
        annotation (Line(points={{-79,30},{-70,30},{-70,14},{-64,14}}, color={0,
              0,127}));
      connect(iStep.y, add.u2)
        annotation (Line(points={{-79,-12},{-70,-12},{-70,2},{-64,2}}, color={0,
              0,127}));
      connect(add.y, idealAverageCCMSwitch.d)
        annotation (Line(points={{-41,8},{10,8},{10,-30}}, color={0,0,127}));
      connect(signalPWM.duty, add.y)
        annotation (Line(points={{-30,68},{-36,68},{-36,8},{-41,8}}, color={0,0,
              127}));
      connect(capsw.n, ressw.n)
        annotation (Line(points={{60,18},{80,18}}, color={0,0,255}));
      connect(idealDiode.p, gsw.p)
        annotation (Line(points={{20,18},{40,18}}, color={0,0,255}));
      connect(gsw.p, capsw.n)
        annotation (Line(points={{40,18},{60,18}}, color={0,0,255}));
      connect(gsrc.p, src.n)
        annotation (Line(points={{-20,-48},{-20,-45},{-20,-42},{-20,-42}},
            color={0,0,255}));
      annotation (
        Diagram(graphics={Text(
              extent={{20,70},{64,62}},
              lineColor={0,0,255},
              textString=
                   "Switched buck"), Text(
              extent={{18,-74},{62,-82}},
              lineColor={0,0,255},
              textString=
                   "Averaged buck")}),
        experiment(StartTime=0, StopTime=0.02, Tolerance=1e-4),
        Documentation(info="<html>
      <p>
        This compares two implementations of a buck DC-DC converter. The
        switched version is built using mostly blocks
        from <a href=\"Modelica://Modelica.Electrical.Analog\">Modelica's
          electrical library</a> but also includes
        the <a href=\"Modelica://PVSystems.Control.SignalPWM\">SignalPWM</a>
        model. The averaged version is built around the average switch model
        for CCM (continuous conduction mode).
      </p>

      <p>
        This example showcases how components from PVSystems can be mixed with
        components from the Modelica Standard Library to build systems that
        might be of interest. Additionally, it aims validating the average
        switch model performance by comparison with the more
        accurate/detailed switched model.
      </p>

      <p>
        This is still an open-loop system. A duty cycle value is fed to the
        SignalPWM block to drive the ideal closing switch or to the
        IdealAverageCCMSwitch model. The duty cycle value begins at 0.2 and
        changes to 0.6 and finally to 0.7. The effect of this change can be
        observed by plotting the output voltage:
      </p>

      <div class=\"figure\">
        <p><img src=\"modelica://PVSystems/Resources/Images/BuckOpenResultsA.png\"
      	  alt=\"BuckOpenResultsA.png\" />
        </p>
      </div>

      <p>
        This figure also displays the input voltage for the sake of
        comparison. It make the point that the function of the buck
        converter is to reduce the voltage level from the input to the
        output.
      </p>

      <p>
        Additionally, one can see that the output voltage for both
        implementations is not exactly the same. The main difference can be
        found at the begining of the simulation, when the duty cycle is
        0.2. By close inspection of the inductor current one can see that
        the converters are not operating in CCM but rather are working in
        DCM (Discontinuous Conduction Mode). This condition is defined by
        the fact that the inductor current remains at 0 for a certain part
        of the switching period, as shown in the following figure:
      </p>


      <div class=\"figure\">
        <p><img src=\"modelica://PVSystems/Resources/Images/BuckOpenResultsB.png\"
      	  alt=\"BuckOpenResultsB.png\" />
        </p>
      </div>

      <p>
        Since the average model used is valid only in CCM, this innaccuaricy
        is to be expected.
      </p>

      <p>
        An interesting exercise to complete this example would be to build a
        controller to close the loop and study the system's behaviour.
      </p>
      </html>"));
    end BuckOpen;