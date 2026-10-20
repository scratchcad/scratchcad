// T-handle seed dibber: 150 mm tapered shaft from 28 mm to an 8 mm rounded tip, depth rings every 25 mm, 100 mm crossbar handle
let shaft_length = 150.0; // [80.0, 250.0] Shaft length (mm)
let top_diameter = 28.0; // [18.0, 40.0] Shaft diameter at the top (mm)
let tip_diameter = 8.0; // [4.0, 16.0] Tip diameter (mm)
let handle_length = 100.0; // [60.0, 140.0] Handle length (mm)
const ring_step = 25.0;
let rt = top_diameter / 2.0;
let rp = min(tip_diameter / 2.0, rt - 2.0);
let shaft = cone(rp, rt, shaft_length - rp).translate([0, 0, rp]) + sphere([0, 0, rp], rp);
let n = ((shaft_length - 5.0) / ring_step).floor().to_int();
let rings = [];
for i in 1..=n {
    let z = i.to_float() * ring_step;
    let r = rp + (rt - rp) * (z - rp) / (shaft_length - rp);
    rings.push(torus(r, 0.8).translate([0, 0, z]));
}
shaft = shaft - compound(rings);
let handle = cylinder([-handle_length / 2.0, 0, shaft_length + 12.0], "X", 14.0, handle_length).fillet(6.0, "%CIRCLE");
let neck = cylinder([0, 0, shaft_length - 1.0], "Z", rt, 12.0);
fuse_all([shaft, neck, handle])
