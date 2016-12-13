package PVSystems "PV Systems library"
extends Modelica.Icons.Library;

annotation (
  uses(Modelica(version="2.2.1")),
  preferedView="info",
  version="0.5.0",
  versionDate="2016-12-13",
  Documentation(info="<html>
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
        and <a href=\"Modelica://PVlib.Examples\">Examples</a>. There is
        also an <a href=\"Modelica://PVlib.Icons\">Icons</a> package that
        for the moment only includes an icon that can be applied to classes
        to indicate that they
        are <a href=\"Modelica://PVlib.Icons.UnderConstruction\">under
          construction</a>.
      </p>
 
      <p>
        After this brief introduction, the best way to go about learning to
        use this library is to check out the
        great <a href=\"Modelica://PVlib.Examples\">Examples</a> package!
      </p>
      </html>"));
end PVSystems;
