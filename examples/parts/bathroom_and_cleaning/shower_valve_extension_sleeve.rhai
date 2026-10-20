// Shower valve trim extension sleeve: 80 mm OD x 3 mm wall tube 50 mm long, 90 mm flange 3 mm, 3 internal grip ribs, 3 x 4.5 mm screw slots in the flange
let od = 80.0; // [60.0, 110.0] Sleeve outside diameter (mm)
let wall = 3.0; // [2.0, 5.0] Wall thickness (mm)
let length = 50.0; // [25.0, 90.0] Sleeve length (mm)
let flange_d = 92.0; // [70.0, 130.0] Flange diameter (mm)
let ri = od / 2.0 - wall;
let tube = cylinder(od / 2.0, length) - cylinder([0, 0, -1], "Z", ri, length + 2.0);
let flange = cylinder(flange_d / 2.0, 3.0) - cylinder([0, 0, -1], "Z", ri, 5.0);
let ribs = [];
for i in 0..3 { ribs.push(box_from_corners([ri - 2.0, -1.5, 3.0], [ri + 0.5, 1.5, length - 3.0]).rotate_z(i.to_float() * 120.0)); }
let slots = [];
for i in 0..3 {
    let a = (i.to_float() * 120.0 + 60.0) * PI() / 180.0;
    let rm = (flange_d / 2.0 + od / 2.0) / 2.0;
    slots.push(cylinder([rm * a.cos(), rm * a.sin(), -1], "Z", 2.25, 5.0));
}
tube + flange + fuse_all(ribs) - compound(slots)
