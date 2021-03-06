within PVSystems.Icons;
partial class AssembliesPackage "Icon for packages of assemblies"
  extends Modelica.Icons.Package;
  annotation (
    Icon(
      graphics={
        Polygon(
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          points={{-80,60},{-30,60},{-30,60},{-30,10},{-30,10},{10,10},{10,10},
              {20,30},{40,30},{50,0},{40,-30},{20,-30},{10,-10},{10,-10},{-30,-10},
              {-30,-10},{-30,-60},{-30,-60},{-80,-60},{-80,-60},{-80,0},{-80,60},
              {-80,60}},
          lineColor={95,95,95},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-20,60},{-20,60},{80,60},{80,60},{80,-60},{80,-60},{-20,-60},
              {-20,-60},{-20,-20},{-20,-20},{10,-20},{10,-40},{50,-40},{60,0},{
              50,40},{10,40},{10,20},{-20,20},{-20,20},{-20,60}},
          lineColor={95,95,95},
          smooth=Smooth.Bezier,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="
      <html>
        <p>
          This icon shall be used for a package that contains assemblies of
          components aimed at being used as subsystems of a system
          model.</p>
      </html>"));
end AssembliesPackage;
