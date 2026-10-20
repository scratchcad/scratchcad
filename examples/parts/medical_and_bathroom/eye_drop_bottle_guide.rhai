// Eye drop bottle guide: 16 mm sleeve over the bottle nozzle 20 mm deep, flaring into a 34 mm eye cup with a soft rolled rim, 6 mm drop window at the bottom
let bottle_diameter = 16.0; // [10.0, 30.0] Bottle neck diameter (mm)
let sleeve_depth = 20.0; // [10.0, 35.0] Sleeve depth (mm)
let cup_diameter = 34.0; // [25.0, 45.0] Eye cup diameter (mm)
let cup_depth = 16.0; // [8.0, 25.0] Eye cup depth (mm)
let wall = 1.6; // [1.0, 3.0] Wall thickness (mm)
let rs = bottle_diameter / 2.0 + 0.3;
let rc = max(cup_diameter / 2.0, rs + 4.0);
let h = cup_depth;
let outer = sketch("XZ").move_to(0, 0).hline_to(rc).line_to(rs + wall + 2.0, h).vline_to(h + sleeve_depth).hline_to(0).close().to_face().revolve("Z", 360);
let inner = sketch("XZ").move_to(0, -1.0).hline_to(rc - wall).vline_to(0).line_to(3.0, h - wall).vline_to(h + 0.1).hline_to(0).close().to_face().revolve("Z", 360);
let guide = outer - inner;
guide -= cylinder([0, 0, h - 1.0], "Z", rs, sleeve_depth + 2.0);
guide += torus(rc - wall / 2.0, wall * 0.9);
guide - box_centered(2.0 * rc + 4.0, 6.0, 2.0 * wall + 1.0).translate([0, rc * 0.0, -wall])
