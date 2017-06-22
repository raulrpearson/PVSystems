package PVSystems "A Modelica library for photovoltaic system and power converter design"
extends Modelica.Icons.Package;







annotation (
  uses(Modelica(version="3.2.2")),
  preferredView="info",
  version="0.6.1",
  versionDate="2017-04-19",
  Documentation(info="<html>
        <p>
          <b>Overview</b>
        </p>
      
        <p>
          <b>PVSystems</b> is
          a <a href=\"https://www.modelica.org/\">Modelica</a> library
          providing models useful for the design and evaluation of
          photovoltaic systems and power converters as well as their
          associated control algorithms.
        </p>
      
      
        <div class=\"figure\">
          <p><img src=\"modelica://PVSystems/Resources/Images/screenshot_small.png\"
                  alt=\"screenshot.png\" />
          </p>
        </div>
      
        <p>
          The library is the result of a research project carried out in the
          form of a master's degree thesis. There are two intended audiences
          for the library:
        </p>
      
        <ul class=\"org-ul\">
          <li><b><b>Users</b></b>: the library is intended to be rich enough
            in component and subsystem models that it proves useful for
            those interested in designing and evaluating photovoltaic
            systems, power converters and their associated control
            algorithms. Check out the usage section to learn more.
          </li>
          <li><b><b>Developers</b></b>: the library is also intended to
            explore and showcase best practices for the development of
            Modelica libraries. Many of these best practices are inspired or
            taken from
            other <a href=\"https://github.com/raulrpearson?language=modelica&tab=stars\">Modelica
            libraries on GitHub</a> and from the
            excellent <a href=\"http://book.xogeny.com/\">Modelica by
            Example</a>.
          </li>
        </ul>
      
        <p>
          The library is currently in the early stages of development, so
          the structure and contents will probably be updated regularly. The
          intention is to provide models in the following categories:
        </p>
      
        <ul class=\"org-ul\">
          <li><b><b><a href=\"modelica://PVSystems.Control\">Control</a></b></b>:
            based on the interfaces provided
            in <a href=\"modelica://Modelica.Blocks\">Modelica.Blocks</a>,
            common blocks used in the control of power converters, including
            Park and Clarke transforms, Space Vector Modulation and grid
            synchronization blocks.
          </li>
          <li><b><b><a href=\"modelica://PVSystems.Electrical\">Electrical</a></b></b>:
            based on the interfaces provided
            in <a href=\"modelica://Modelica.Electrical.Analog\">Modelica.Electrical.Analog</a>,
            common electrical models including PV arrays, energy storage
            devices, power converters, transformers, loads and other grid
            elements. The library features both switched and averaged models
            of power converters.
          </li>
          <li><b><b><a href=\"modelica://PVSystems.Examples\">Examples</a></b></b>:
            a comprehensive set of examples will be provided to showcase the
            capabilities and explain the use of the library.
          </li>
        </ul>
      
        <p>
          <b>Download and usage</b>
        </p>
      
        <p>
          You can grab a copy of the library by clonning the repository or
          downloading
          a <a href=\"https://github.com/raulrpearson/PVSystems/archive/master.zip\">zip
          of the latest commit</a>. Take into account that the library is
          currently in the early stages of development, so some models might
          not be stable and the structure and contents of the library will
          probably be updated regularly. If you want to stay up to date with
          development, you
          can <a href=\"https://github.com/raulrpearson/PVSystems/subscription\">watch
          the project</a> if you have a GitHub account or you can subscribe
          to
          the <a href=\"https://github.com/raulrpearson/PVSystems/commits/master.atom\">commits
          feed</a>.
        </p>
      
        <p>
          The library can be used inside tools
          like <a href=\"http://www.3ds.com/products-services/catia/products/dymola/\">Dymola</a>
          or <a href=\"https://openmodelica.org/\">OpenModelica</a> to
          create models of PV systems. These same tools can be used in
          conjuntion with other tools supporting
          the <a href=\"https://fmi-standard.org\">FMI standard</a> for
          model exchange and co-simulation. For example, a PV system model
          developed in OpenModelica using this library could then be used to
          validate a control algorithm developed in MATLAB/Simulink or
          LabVIEW.
        </p>
      
        <p>
          <b>Contributing</b>
        </p>
      
        <p>
          If you have any <b><b>questions, comments, suggestions, ideas or
              feature requests</b></b>, please do share those as well as
              any <b><b>mistakes or bugs</b></b> you might discover. You can
              open an issue in
              the <a href=\"https://github.com/raulrpearson/PVSystems/issues\">Issues</a>
              section of the repository or, if you prefer, contact me
              by <a href=\"mailto:raul.rodriguez.pearson@gmail.com\">email</a>. Contributions
              in the form
              of <a href=\"https://github.com/raulrpearson/PVSystems/pulls\">Pull
              Requests</a> are always welcome.
        </p>
      
        <p>
          <b>License</b>
        </p>
      
        <p>
          PVSystems is licensed under the MIT
          License. See <a href=\"modelica://PVSystems.UsersGuide.License\">License</a>
          for the full license text.
        </p>
      </html>"),
  Icon(graphics={Ellipse(
        extent={{-70,52},{-10,-6}},
        pattern=LinePattern.None,
        lineColor={0,0,0},
        fillColor={229,184,0},
        fillPattern=FillPattern.Solid), Polygon(
        points={{-78,-60},{-42,14},{42,14},{86,-60},{-78,-60}},
        fillColor={27,77,130},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None)}),
  __Dymola_Commands(file="Resources/Scripts/Dymola/callCheckLibrary.mos"
      "Run regression tests"));
end PVSystems;
