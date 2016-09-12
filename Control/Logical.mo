package Logical "Library of components with Boolean input and output signals" 
  block Not "Logical 'not': y = not u" 
    extends Interfaces.BooleanSISO;
    annotation (
      defaultComponentName="notBlock",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}),
        Text(
          extent=[62,-38; -52,42],
          style(color=3, rgbcolor={0,0,255}),
          string="NOT")),
      Documentation(info="<html>
<p>
The output is <b>true</b> if the input is <b>false</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  equation 
    y = not u;
  end Not;
  
  block Less "Output y is true, if input u1 is less than input u2" 
    extends Interfaces.MI2BooleanMOs;
  protected 
    Real u1=inPort1.signal[1];
    Real u2=inPort2.signal[1];
  equation 
    outPort.signal[1] = u1 < u2;
    annotation (Icon(Text(
          extent=[-75,75; 75,-75],
          style(color=3, rgbcolor={0,0,255}),
          string=">")));
  end Less;
end Logical;
