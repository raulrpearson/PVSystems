within PVSystems.Examples.Application;
model PVInverter1ph "Stand-alone 1-phase closed-loop inverter with PV source"
  extends Modelica.Icons.Example;
  Electrical.PVArray PV(v(start=450)) annotation (Placement(transformation(
        origin={-40,60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Constant Gn(k=1000) annotation (Placement(
        transformation(extent={{-80,70},{-60,90}}, rotation=0)));
  Modelica.Blocks.Sources.Constant Tn(k=298.15) annotation (Placement(
        transformation(extent={{-80,30},{-60,50}}, rotation=0)));
  PVSystems.Electrical.Assemblies.HBridge Inverter annotation (Placement(
        transformation(extent={{40,50},{60,70}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor L(L=1e-3)   annotation (Placement(
        transformation(
        origin={90,74},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor R(R=1e-2)
                                                     annotation (Placement(
        transformation(
        origin={90,48},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor Cdc(               C=5e-1, v(start=
          10))
    annotation (Placement(transformation(
        origin={20,60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor Rdc(R=1e-3, v(start=30))
    annotation (Placement(transformation(extent={{-20,70},{0,90}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-20,20},{0,40}}, rotation=0)));
  Modelica.Blocks.Sources.Cosine vacEmulation(freqHz=50) annotation (Placement(
        transformation(extent={{-40,-70},{-20,-50}}, rotation=0)));
  Control.Assemblies.Inverter1phCompleteController controller(
    fline=50,
    ik=0.1,
    iT=0.01,
    vk=10,
    vT=0.5,
    iqMax=10,
    vdcMax=71,
    idMax=10)
            annotation (Placement(transformation(
        origin={30,-30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.RealExpression iacSense(y=L.i)
    annotation (Placement(transformation(extent={{-40,-44},{-20,-24}})));
  Modelica.Blocks.Sources.RealExpression idcSense(y=-PV.i)
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Blocks.Sources.RealExpression vdcSense(y=PV.v)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.RealExpression DCPower(y=-PV.i*PV.v)
    annotation (Placement(transformation(extent={{40,-72},{60,-52}})));
  Modelica.Blocks.Sources.RealExpression ACPower(y=R.i*R.v)
    annotation (Placement(transformation(extent={{40,-92},{60,-72}})));
  Modelica.Blocks.Math.Mean meanACPower(f=50)
    annotation (Placement(transformation(extent={{70,-92},{90,-72}})));
equation
  connect(Gn.y, PV.G) annotation (Line(points={{-59,80},{-54,80},{-54,63},{-45.5,
          63}}, color={0,0,127}));
  connect(Tn.y, PV.T) annotation (Line(points={{-59,40},{-54,40},{-54,57},{-45.5,
          57}}, color={0,0,127}));
  connect(Cdc.p, Inverter.p1) annotation (Line(points={{20,70},{34,70},{34,65},
          {40,65}}, color={0,0,255}));
  connect(L.n, R.p)
    annotation (Line(points={{90,64},{90,58}}, color={0,0,255}));
  connect(Cdc.n, Inverter.n1) annotation (Line(points={{20,50},{34,50},{34,55},
          {40,55}}, color={0,0,255}));
  connect(PV.p, Rdc.p) annotation (Line(points={{-40,70},{-40,70},{-40,80},{-20,
          80}}, color={0,0,255}));
  connect(Cdc.n, ground.p) annotation (Line(points={{20,50},{20,48},{20,40},{-10,
          40}}, color={0,0,255}));
  connect(PV.n, ground.p)
    annotation (Line(points={{-40,50},{-40,40},{-10,40}}, color={0,0,255}));
  connect(Rdc.n, Cdc.p) annotation (Line(points={{0,80},{10,80},{20,80},{20,70}},
        color={0,0,255}));
  connect(Inverter.p2, L.p) annotation (Line(points={{60,65},{70,65},{70,90},{
          90,90},{90,84}}, color={0,0,255}));
  connect(Inverter.n2, R.n) annotation (Line(points={{60,55},{70,55},{70,30},{
          90,30},{90,38}}, color={0,0,255}));
  connect(idcSense.y, controller.idc) annotation (Line(points={{-19,-10},{0,-10},
          {0,-26},{18,-26}}, color={0,0,127}));
  connect(vdcSense.y, controller.vdc) annotation (Line(points={{-19,10},{10,10},
          {10,-22},{18,-22}}, color={0,0,127}));
  connect(vacEmulation.y, controller.vac) annotation (Line(points={{-19,-60},{0,
          -60},{0,-38},{18,-38}}, color={0,0,127}));
  connect(iacSense.y, controller.iac)
    annotation (Line(points={{-19,-34},{-0.5,-34},{18,-34}}, color={0,0,127}));
  connect(ACPower.y, meanACPower.u)
    annotation (Line(points={{61,-82},{64.5,-82},{68,-82}}, color={0,0,127}));
  connect(controller.d, Inverter.d)
    annotation (Line(points={{41,-30},{50,-30},{50,48}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(initialScale=0.1)), experiment(StopTime=
          3, Interval=0.001),
          Documentation(info="<html>
              <p>
                This example adds a PV array to the DC side. To start as
                simple as possible, the AC side is just a passive RL
                load. A general controller for this kind of setup is
                devised and packaged
                as <a href=\"Modelica://PVSystems.Control.Assemblies.Inverter1phCompleteController\">Inverter1phCompleteController</a>. This
                block accepts no input because it's assumed that the
                controller will try to extract the maximum active power
                from the PV array. Internally, the q current setpoint is
                set to zero.
              </p>
            
              <p>
                Plotting the DC bus voltage and the output current
                confirms shows that this is in fact how the controller
                is behaving:
              </p>
            
            
              <div class=\"figure\">
                <p><img src=\"modelica://PVSystems/Resources/Images/PVInverter1phResultsA.png\"
                        alt=\"PVInverter1phResultsA.png\" />
                </p>
              </div>
            
              <p>
                The maximum power point is achieved by indirectly
                balancing the difference between the power delivered by
                the PV array and the power dumped on to the grid. As the
                maximum power point is being reached, the difference
                tends to zero:
              </p>
            
            
              <div class=\"figure\">
                <p><img src=\"modelica://PVSystems/Resources/Images/PVInverter1phResultsB.png\"
                        alt=\"PVInverter1phResultsB.png\" /></p>
              </div>
            </html>"));
end PVInverter1ph;
