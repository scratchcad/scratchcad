// Square 4-way ceiling supply diffuser for a 600 mm lay-in grid: 595 mm face, three nested stepped louver cones, 250 mm round neck 50 mm tall
let face = 595.0; // [300.0, 600.0] Face size (mm)
let neck_d = 250.0; // [150.0, 300.0] Neck diameter (mm)
let rings = 3; // [2, 4] Number of louver rings
const t = 1.0;
const drop = 25.0;
let fr = box_centered(face, face, t).translate([0, 0, drop + t / 2.0]);
let open = face - 60.0;
fr -= box_centered(open, open, 4.0).translate([0, 0, drop]);
let parts = [fr];
let step = (open / 2.0 - neck_d / 2.0 * 0.6) / rings.to_float();
for i in 0..rings {
    let a = open - 2.0 * step * i.to_float() + 10.0;
    let b = a - 2.0 * step * 0.9;
    let z0 = drop + 1.5 - 22.0 - 8.0 * i.to_float();
    let outer = loft([rect(plane([0, 0, z0], "Z"), b, b), rect(plane([0, 0, drop + 1.5], "Z"), a, a)], true);
    let inner = loft([rect(plane([0, 0, z0 - 0.5], "Z"), b - 2.0 * t * 1.4, b - 2.0 * t * 1.4), rect(plane([0, 0, drop + 2.0], "Z"), a - 2.0 * t * 1.4 + 1.0, a - 2.0 * t * 1.4 + 1.0)], true);
    parts.push(outer - inner);
}
let neck = cylinder([0, 0, drop + t * 0.5], "Z", neck_d / 2.0, 50.0) - cylinder([0, 0, drop], "Z", neck_d / 2.0 - t, 52.0);
let collar = box_centered(open + 20.0, open + 20.0, t).translate([0, 0, drop + t * 1.5]) - cylinder([0, 0, drop], "Z", neck_d / 2.0 - t, 10.0);
fuse_all(parts + [neck, collar])
