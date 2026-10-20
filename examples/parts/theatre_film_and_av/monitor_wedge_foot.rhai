// Stage monitor wedge foot: anti-slip foot 60 x 40 mm, 15 mm tall with a 10 degree wedge top, 5 mm deep tread grooves under, countersunk 4.5 mm screw hole
let length = 60.0; // [40.0, 90.0] Foot length (mm)
let width = 40.0; // [25.0, 60.0] Foot width (mm)
let height = 15.0; // [10.0, 25.0] Foot height at the tall end (mm)
let angle = 10.0; // [0.0, 20.0] Wedge angle (degrees)
let drop = length * (angle * PI() / 180.0).sin() / (angle * PI() / 180.0).cos();
let low = (height - drop).max(4.0);
let body = polygon("XZ", [[0, 0], [length, 0], [length, low], [0, height]]).to_face().extrude([0, -width, 0]).translate([0, width / 2.0, 0]);
let b = body.fillet(3.0, body.edges("|Z"));
let grooves = [];
for i in 0..5 { grooves.push(box_from_corners([6.0 + i.to_float() * (length - 12.0) / 4.5, -width, -1.0], [9.0 + i.to_float() * (length - 12.0) / 4.5, width, 1.5])); }
let hole = cylinder([length / 2.0, 0, -1.0], "Z", 2.25, height + 2.0) + cone(2.25, 6.0, 4.0).translate([length / 2.0, 0, (height + low) / 2.0 - 3.0]);
b - compound(grooves) - hole
