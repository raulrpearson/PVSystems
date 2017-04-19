within PVSystems.UsersGuide;
class License "License"
  annotation (Documentation(info="<html>
      <p>
        MIT License
      </p>
    
      <p>
        Copyright (c) 2016-2017 Raúl Rodríguez Pearson
      </p>
    
      <p>
        Permission is hereby granted, free of charge, to any person
        obtaining a copy of this software and associated documentation
        files (the \"Software\"), to deal in the Software without
        restriction, including without limitation the rights to use, copy,
        modify, merge, publish, distribute, sublicense, and/or sell copies
        of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:
      </p>
    
      <p>
        The above copyright notice and this permission notice shall be
        included in all copies or substantial portions of the Software.
      </p>
    
      <p>
        THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND,
        EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
        MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
        NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
        HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
        WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
        DEALINGS IN THE SOFTWARE.
      </p>
    </html>"), Icon(graphics={
        Line(points={{-60,60},{60,60}}, color={95,95,95}),
        Line(points={{0,60},{0,-60}}, color={95,95,95}),
        Line(points={{-60,-60},{60,-60}}, color={95,95,95}),
        Ellipse(
          extent={{-10,70},{10,50}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-90,-10},{-30,-50}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=180),
        Ellipse(
          extent={{30,-10},{90,-50}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=180),
        Line(points={{-90,-10},{-60,60},{-30,-10}}, color={95,95,95}),
        Line(points={{30,-10},{60,60},{90,-10}}, color={95,95,95})}));
end License;
