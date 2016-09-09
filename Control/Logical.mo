package Logical "Library of components with Boolean input and output signals" 
  block Not "Logical 'not': y = not u" 
    extends Interfaces.BooleanSISO;
    annotation (
      defaultComponentName="not1",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            lineColor={0,0,0},
            textString="not")}),
      Documentation(info="<html>
<p>
The output is <b>true</b> if the input is <b>false</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  equation 
    y = not u;
  end Not;
end Logical;
