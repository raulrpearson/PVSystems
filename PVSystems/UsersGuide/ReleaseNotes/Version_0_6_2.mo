within PVSystems.UsersGuide.ReleaseNotes;
class Version_0_6_2 "Version 0.6.2 (July 6, 2017)"
  extends Modelica.Icons.ReleaseNotes;
  annotation(Documentation(info="<html>
      <p>
        <strong>Modifications</strong>:
      </p>
      <ul class=\"org-ul\">
        <li>The main new feature of this release is the slight
          restructuring of switch network models that now have
          switching, as well as averaged, variants. This
          provides generic converter blocks that can be changed
          from switched to averaged with the click of a mouse.
        </li>
        <li>The SignalPWM block is renamed to SwitchingPWM and
          its icon is changed.
        </li>
        <li>Documentation for examples is updated and
          completed. The names of components used in some of the
          examples are changed.
        </li>
        <li>The Validation package is renamed to
          Verification. This name change has also been applied
          to models inside this package and associated files
          like results plots.
        </li>
        <li>MPPTController is taken out of Control.Assemblies
          and placed directly in the Control package.
        </li>
        <li>Instances of switch networks are made replaceable to
          allow the use of different flavours of converters and
          circuits (switched and averaged).
        </li>
        <li>HBridgeAveraged is renamed to HBridge since it can
          now be instantiated with switched or averaged models.
        </li>
        <li>The averaged models (CCM1, CCM2&#x2026;) include the
          port current equations that were previously part of
          the TwoPortConverter interface, since they now inherit
          from TwoPort, which doesn't include those equations.
        </li>
      </ul>
      <p>
        <strong>Additions</strong>:
      </p>
      <ul class=\"org-ul\">
        <li>Three variants of switched switch network models,
          SW1 (switch and diode), SW2 (2 switches) and SW3 (2
          switches + antiparallel diode).
        </li>
        <li>The script callCheckLibrary.mos has been added to
          provide a convenient way to run regression tests. To
          provide even more convenience, a
          _<sub>Dymola</sub><sub>Commands</sub> annotation has
          been added to the root package file so that this
          script can be run from the Commands menu when using
          Dymola. The reference regression tests should be
          updated in each release if necessary.
        </li>
        <li>Added a script to export listings for publishing.
        </li>
        <li>TwoPort interface and ConverterIcon added in place
          of TwoPortConverter.
        </li>
      </ul>
      <p>
        <strong>Deletions</strong>:
      </p>
      <ul class=\"org-ul\">
        <li>TwoPortConverter interface is removed and
          substituted by a TwoPort interface (copied from MSL
          without current equations) and a ConverterIcon.
        </li>
      </ul>
    </html>"));
end Version_0_6_2;
