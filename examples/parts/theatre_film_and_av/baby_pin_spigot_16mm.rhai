// Baby pin spigot: 16 mm (5/8 in) stud 80 mm long with a 3 mm safety groove 10 mm from the top, 25 mm hex flange 6 mm, 3/8-16 female base bore (8 mm tap drill, 12 mm deep)
let pin = 16.0; // [15.8, 16.2] Pin diameter (mm)
let length = 80.0; // [50.0, 120.0] Pin length (mm)
let groove_from_top = 10.0; // [6.0, 20.0] Safety groove position from the tip (mm)
let hex = 25.0; // [20.0, 32.0] Hex flange across flats (mm)
let rc = hex / 2.0 / (30.0 * PI() / 180.0).cos();
let pts = [];
for k in 0..6 { let a = k.to_float() * 60.0 * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let flange = polygon("XY", pts).to_face().extrude([0, 0, 6.0]);
let r = pin / 2.0;
let p = polygon("XZ", [[0, 5.99], [r, 5.99], [r, 6.0 + length - groove_from_top - 1.5], [r - 1.5, 6.0 + length - groove_from_top - 1.0], [r - 1.5, 6.0 + length - groove_from_top + 1.0], [r, 6.0 + length - groove_from_top + 1.5], [r, 6.0 + length - 1.5], [r - 1.5, 6.0 + length], [0, 6.0 + length]]);
let stud = p.to_face().revolve([0, 0, 0], "Z", 360);
(flange + stud) - cylinder([0, 0, -1.0], "Z", 4.0, 13.0)
