// M8 cross dowel barrel nut: 10 mm diameter 20 mm long, cross-tapped M8 hole at the centre, screwdriver slot in one end
let d = 10.0; // [8.0, 14.0] Diameter (mm)
let len = 20.0; // [12.0, 30.0] Length (mm)
let nut = cylinder([0, 0, 0], "X", d / 2.0, len).chamfer(0.5, "%CIRCLE");
nut - cylinder([len / 2.0, 0, -d], "Z", 3.4, 2.0 * d) - box_centered(3.0, d + 2.0, 1.5).translate([0, 0, 0])
