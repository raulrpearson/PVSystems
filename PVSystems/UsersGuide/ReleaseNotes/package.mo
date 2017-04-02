within PVSystems.UsersGuide;
package ReleaseNotes "Release notes"
extends Modelica.Icons.ReleaseNotes;


class Version_0_6_0 "Version 0.6.0 (April 3, 2017)"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
      <p>
        <b>Changes</b>:
      </p>
      <ul class=\"org-ul\">
        <li>The main change in this release is a very heavy refactoring of
          files. Functionality wise, the library hasn't changed that much,
          but every model has been split into it's own file.
        </li>
        <li>Updated the info text for the root class PVSystems with the
          contents of the README.md file.
        </li>
      </ul>
      <p>
        <b>Additions</b>:
      </p>
      <ul class=\"org-ul\">
        <li>Added battery model together with a validation example model.
        </li>
        <li>Added User's Guide package with References, Release Notes,
          Contact and License information.
        </li>
      </ul>
    </html>"));
  end Version_0_6_0;

annotation (Documentation(info="<html>
      <p>
        This section includes an item per release, indicating version
        number and release date. Release notes are included under each
        corresponding item.
      </p>
    
      <p>
        <a href=\"http://semver.org/\">Semantic Versioning</a> is followed
        to establish version numbers. Given a version number
        MAJOR.MINOR.PATCH, an increment in the:
      </p>
      <ul class=\"org-ul\">
        <li>MAJOR version indicates incompatible API changes.
        </li>
        <li>MINOR version indicates new functionality in a
          backwards-compatible manner.
        </li>
        <li>PATCH version indicates backwards-compatible bug fixes.
        </li>
      </ul>
    
      <p>
        Notice, though, that major version zero (0.y.z) is for initial
        development - anything may change at any time and the public API
        should not be considered stable.</p>
    </html>"));
end ReleaseNotes;
