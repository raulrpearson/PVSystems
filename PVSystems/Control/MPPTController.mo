within PVSystems.Control;
block MPPTController "Maximum Power Point Tracking Controller"
  extends Modelica.Blocks.Interfaces.SI2SO;
  parameter Modelica.SIunits.Time sampleTime=1 "Sample time of control block";
  parameter Modelica.SIunits.Voltage vrefStep=5 "Step of change for vref";
  parameter Modelica.SIunits.Power pkThreshold=1
    "Power threshold below which no change is considered";
  parameter Modelica.SIunits.Voltage vrefStart=10
    "Voltage reference initial value";
protected
  discrete Modelica.SIunits.Voltage vk;
  discrete Modelica.SIunits.Current ik;
  discrete Modelica.SIunits.Power pk;
  discrete Modelica.SIunits.Voltage vref(start=vrefStart);
equation
  when sample(sampleTime, sampleTime) then
    vk = pre(u1);
    ik = pre(u2);
    pk = vk*ik;
    if abs(pk - pre(pk)) < pkThreshold then
      // power unchanged => don't change vref
      vref = pre(vref);
    elseif pk - pre(pk) > 0 then
      // power increased => repeat last action
      vref = pre(vref) + vrefStep*sign(vk - pre(vk));
    else
      // power decreased => change last action
      vref = pre(vref) - vrefStep*sign(vk - pre(vk));
    end if;
  end when;
  y = vref;
  annotation (
    Diagram(graphics),
    Documentation(info="<html>
        <p>
          Maximum power-point tracking controller. Given the DC voltage and
          current, this controller will output a moving reference for a DC
          voltage control loop in order to maximize the power extracted from a
          PV array for a given (unknown) solar irradiation and junction
          temperature.
        </p>

        <p>
          The operation of the block can be customized by setting the
          following parameters:
        </p>

        <ul class=\"org-ul\">
          <li><i>sampleTime</i>: sample time of the control block. The control
            output will be updated with this period.
          </li>
          <li><i>vrefStep</i>: amount of change to vref when updated.
          </li>
          <li><i>pkThreshold</i>: amount of power below which it is considered
            that no change in power has occurred.
          </li>
        </ul>
      </html>"),
    Icon(graphics={
        Line(points={{-80,80},{-80,-80},{80,-80}}, color={0,0,0}),
        Line(
          points={{-80,-80},{40,80},{60,-80}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-80,40},{30,40},{30,-80}},
          color={255,0,0},
          pattern=LinePattern.Dash),
        Text(
          extent={{-60,80},{60,40}},
          lineColor={0,0,255},
          pattern=LinePattern.Dash,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString="MPPT")}));
end MPPTController;
