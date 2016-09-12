package PVlib "Photovoltaics library"
  extends Modelica.Icons.Library;
  import SI = Modelica.SIunits;
  import C = Modelica.Constants;
  annotation (
    Documentation(info="<html><p>PVlib is a library aimed at providing
                  all the components for PV power converter designers.
                  The library was developed in Dymola 6.1 and is heavily
                  based in the MSL 1.6 (Modelica Standard Library) released
                  October 14, 2005. This applies mainly to the <i>Control</i>
                  and <i>Electrical</i> packages. The rationale behind this
                  implementation choice is that many of the packages that
                  will be useful for the development of PV system models will
                  require a lot of these blocks and models. The components are
                  included in the library instead of referenced to avoid
                  dependency problems.</p>
                  <p>The library adds the following classes to the following
                  packages:</p>
                  <ul>
                  <li><b>Control</b>: includes two logical functions as
                  blocks, <i>Not</i> and <i>Less</i>, that were needed in the
                  construction of other original components. Additionally, it
                  includes the <i>PowerConverters</i> sub-package in order to
                  provide common blocks and functions used in power converter
                  control. In this release, this sub-package only includes a
                  PWM generator.</li>
                  <li><b>Electrical</b>: includes two original sub-packages,
                  <i>PowerConverters</i> and <i>Solar</i>. The former includes
                  models for an ideal current bi-directional switch (i.e. an
                  idealization of the typical IGBT + diode switch) and two
                  switch configurations achieved through de compositio of
                  several instances of this ideal switch model. The latter
                  includes a flexible PV array model.</li>
                  <li><b>Examples</b>: includes several models used to
                  showcase and validate the elements introduced in the previous
                  packages.</li></ul></html>"),
    uses(Modelica(version="1.6")));
end PVlib;
