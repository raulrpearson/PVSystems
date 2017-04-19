within PVSystems.UsersGuide.ReleaseNotes;
class Version_0_6_1 "Version 0.6.1 (April 19, 2017)"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
  <p>
    <strong>Modifications</strong>:
  </p>
  <ul class=\"org-ul\">
    <li>The averaged switch models have been expanded. As a start, a
      partial
      model <a href=\"modelica://PVSystems.Electrical.Interfaces.SwitchNetworkInterface\">SwitchNetworkInterface</a>
      has been added to provide the common interface.
    </li>
    <li>Many models and blocks (especially blocks) with no icons have
      been given an icon. Things look much better.
    </li>
    <li>The controller assemblies have been moved to
      an <a href=\"modelica://PVSystems.Control.Assemblies\">Assemblies</a>
      package and have been reviewed, cleaned up and some bugs have
      been resolved (in the previous commit, none of them really
      worked).
    </li>
  </ul>
  <p>
    <strong>Additions</strong>:
  </p>
  <ul class=\"org-ul\">
    <li>An <a href=\"modelica://PVSystems.Icons\">Icons</a> package
      has been added to hold icons that can be reused.
    </li>
    <li>Interfaces and Assemblies packages have been added
      to <a href=\"modelica://PVSystems.Electrical\">Electrical</a>
      and <a href=\"modelica://PVSystems.Control\">Control</a> to hold
      partial models and models, respectively, that can be reused.
    </li>
    <li>All of the averaged switch variants
      in <a href=\"modelica://PVSystems.UsersGuide.References.EM01\">EM01</a>
      and <a href=\"modelica://PVSystems.UsersGuide.References.EMA16\">EMA16</a>
      have been added
      (<a href=\"modelica://PVSystems.Electrical.CCM1\">CCM1</a>, <a href=\"modelica://PVSystems.Electrical.CCM2\">CCM2</a>, <a href=\"modelica://PVSystems.Electrical.CCM3\">CCM3</a>, <a href=\"modelica://PVSystems.Electrical.CCM4\">CCM4</a>, <a href=\"modelica://PVSystems.Electrical.CCM5\">CCM5</a>, <a href=\"modelica://PVSystems.Electrical.CCM_DCM1\">CCM-DCM1</a>
      and <a href=\"modelica://PVSystems.Electrical.CCM_DCM2\">CCM-DCM2</a>).
    </li>
    <li>Additionally some averaged and switched control blocks also
      in <a href=\"modelica://PVSystems.UsersGuide.References.EM01\">EM01</a>
      and <a href=\"modelica://PVSystems.UsersGuide.References.EMA16\">EMA16</a>
      have also been added
      (<a href=\"modelica://PVSystems.Control.SwitchingCPM\">SwitchingCPM</a>, <a href=\"modelica://PVSystems.Control.CPM_CCM\">CPM-CCM</a>, <a href=\"modelica://PVSystems.Control.CPM\">CPM</a>).
    </li>
    <li>A <a href=\"modelica://PVSystems.Control.DeadTime\">DeadTime</a>
      block has been added to be used in conjunction with any of the
      blocks producing switching signals
      (currently <a href=\"modelica://PVSystems.Control.SignalPWM\">SignalPWM</a>
      and <a href=\"modelica://PVSystems.Control.SwitchingCPM\">SwitchingCPM</a>),
      to create a complement switching signal with an optional dead
      time value.
    </li>
  </ul>
  <p>
    <strong>Deletions</strong>:
  </p>
  <ul class=\"org-ul\">
    <li>The model Ideal2LevelLeg has been removed since it added
      complexity and didn't seem to be that useful.
    </li>
  </ul>
</html>"));
end Version_0_6_1;
