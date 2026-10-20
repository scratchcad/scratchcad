// Cupboard knob, 30 mm beehive: 30 mm head 25 mm tall, 14 mm neck, M4 tapped base 8 mm, 3 rings
let head = 30.0; // [20.0, 45.0] Head diameter (mm)
let height = 25.0; // [15.0, 40.0] Height (mm)
let neck = 14.0; // [10.0, 20.0] Neck diameter (mm)
let p = sketch("XZ").move_to(0, 0).hline_to(neck / 2.0 + 2.0).arc_to(neck / 2.0, 4.0, neck / 2.0 + 1.0, 8.0).line_to(head / 2.0, height * 0.55).arc_to(head / 2.0 - 2.0, height - 3.0, 0, height).close();
let k = p.face().revolve("Z", 360);
let rings = [];
for z in [height * 0.65, height * 0.75, height * 0.85] { rings.push(cylinder([0, 0, z], "Z", head, 0.8) - cylinder([0, 0, z - 1.0], "Z", head / 2.0 * 0.7, 3.0)); }
k - compound(rings) - cylinder([0, 0, -1], "Z", 1.7, 9.0)
