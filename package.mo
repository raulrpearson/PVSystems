package PVlib "Photovoltaics library"
extends Modelica.Icons.Library;


annotation (
  uses(Modelica(version="2.2.1")),
  preferedView="info",
  version="0.3",
  versionDate="2016-09-23",
  Documentation(
    info="<html>
      <p>
        PVlib is a Modelica library focused on providing the components
        typically useful for the electrical design of converters as well as
        the development of control algorithms. PVlib is a library created to
        aide in the modeling and simulation of photovoltaic power systems
        like this one:
      </p>
 
      <div class=\"figure\">
        <p><img src=\"../Resources/Images/TypicalSystem.png\"
                alt=\"TypicalSystem.png\" />
        </p>
      </div>
 
      <p>
        As specified under the <b>Package Content</b> heading, this library
        is divided into three
        packages: <a href=\"Modelica://PVlib.Control\">Control</a>, <a href=\"Modelica://PVlib.Electrical\">Electrical</a>
        and
        <a href=\"Modelica://PVlib.Examples\">Examples</a>. In total, the
        library contains these 5 original component models:
      </p>
 
      <ul class=\"org-ul\">
        <li><a href=\"Modelica://PVlib.Control.SignalPWM\">SignalPWM</a>: a
          PWM switching signal generator
        </li>
        <li><a href=\"Modelica://PVlib.Control.IdealCBSwitch\">IdealCBSwitch</a>:
          an ideal current bidirectional switch
        </li>
        <li><a href=\"Modelica://PVlib.Control.Ideal2LevelLeg\">Ideal2LevelLeg</a>:
          a basic two-level leg composed of two ideal current bidirectional
          switches in series
        </li>
        <li><a href=\"Modelica://PVlib.Control.IdealHBridge\">IdealHBridge</a>:
          two basic two-level legs arranged in an H-bridge
        </li>
        <li><a href=\"Modelica://PVlib.Control.PVArray\">PVArray</a>: a
          flexible PV array model
        </li>
      </ul>
 
      <p>
        After this brief introduction, the best way to go about learning to
        use this library is to check out the
        great <a href=\"Modelica://PVlib.Examples\">Examples</a> package!
      </p>
      </html>"));
end PVlib;
