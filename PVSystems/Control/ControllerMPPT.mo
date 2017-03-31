within PVSystems.Control;
block ControllerMPPT "Maximum Power Point Tracking Controller"
  extends Modelica.Blocks.Interfaces.SI2SO;
  parameter Modelica.SIunits.Time sampleTime=1 "Sample time of control block";
  parameter Modelica.SIunits.Voltage vrefStep=5 "Step of change for vref";
  parameter Modelica.SIunits.Power pkThreshold=1
    "Power threshold below which no change is considered";
protected
  Modelica.SIunits.Voltage vk;
  Modelica.SIunits.Current ik;
  Modelica.SIunits.Power pk;
  Modelica.SIunits.Voltage vref;
equation
  when sample(0, sampleTime) then
    if initial() then
      vk = pre(u1);
      ik = pre(u2);
      pk = vk*ik;
      vref = 10;
    else
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
    end if;
  end when;
  y = vref;
  annotation (
    Diagram(graphics),
    Icon(graphics={Text(
          extent={{-70,70},{70,20}},
          lineColor={0,0,255},
          textString="MPPT"), Text(
          extent={{-70,-20},{70,-70}},
          lineColor={0,0,255},
          textString="Controller")}),
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
      </html>"));
end ControllerMPPT;
