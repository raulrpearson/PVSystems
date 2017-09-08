within PVSystems.UsersGuide.ReleaseNotes;
class Version_0_6_3 "Version 0.6.3 (September 8, 2017)"
  extends Modelica.Icons.ReleaseNotes;
  annotation(Documentation(info="<html>
      <p>
        <strong>Fixes and modifications</strong>:
      </p>
      <ul class=\"org-ul\">
        <li>USBBatteryConverter, which instantiates
          CPMBidirectionalBuckBoost couldn't run the simulation
          through a mode change (from buck to boost or
          viceversa). CPMBidirectionalBuckBoost now incorporates
          one on delay block for each mode enable to prevent
          them from being active at the same time. This allows
          for transitions to be simulated, without loss of
          accuracy.
        </li>
        <li>CCM4 was missing the term for forward voltage drop
          loss. This release adds that.
        </li>
        <li>CCM_DCM1 and CCM_DCM2 had an incorrect calculation
          of mu which could provide negative values. This was
          fixed. Additionally, CCM_DCM2 was missing an 'n' term
          in the calculation of Re.
        </li>
        <li>CPM had some missing terms in the equation for d.
        </li>
      </ul>
      <p>
        <strong>Additions</strong>:
      </p>
      <ul class=\"org-ul\">
        <li>Verification models were added in the corresponding
          examples package for SW1, SW2, SW3, CCM1, CCM2, CCM3,
          CCM4, CCM5, CCM_DCM1, CCM_DCM2, CPM_CCM, CPM and
          DeadTime.
        </li>
      </ul>
      <p>
        <strong>Deletions</strong>:
      </p>
      <ul class=\"org-ul\">
        <li>No deletions.
        </li>
      </ul>
    </html>"));
end Version_0_6_3;
