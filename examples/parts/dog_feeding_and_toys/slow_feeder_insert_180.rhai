// Dog bowl slow feeder insert: 180 mm disc 3 mm with 3 concentric maze rings 25 mm tall, each broken by 2 gaps 30 mm wide, and a 40 mm centre post
let dia = 180.0; // [120.0, 240.0] Bowl inner diameter (mm)
let ridge = 25.0; // [15.0, 40.0] Ridge height (mm)
const t = 3.0;
let r = dia / 2.0 - 1.0;
let base = cylinder([0, 0, 0], "Z", r, t);
let rings = [];
for k in 1..4 {
    let rr = r * k.to_float() / 4.0;
    let ring = cylinder([0, 0, t - 0.01], "Z", rr + 1.5, ridge) - cylinder([0, 0, t - 1.0], "Z", rr - 1.5, ridge + 2.0);
    let rot = 60.0 * k.to_float();
    rings.push(ring - box_centered(30.0, dia, ridge + 4.0).translate([0, 0, t + ridge / 2.0]).rotate_z(rot));
}
base + fuse_all(rings) + cylinder([0, 0, t - 0.01], "Z", 20.0, ridge)
