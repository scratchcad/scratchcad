// Grow bag ring pot: bottomless ring pot pushed into a tomato grow bag, 230 mm top tapering to 200 mm, 150 mm deep, 2.5 mm wall with a 10 mm stiffening rim, 4 cut-in teeth at the base and an inner 120 mm watering reservoir collar
// # Ring
let top_d = 230.0; // [180.0, 280.0] Top diameter (mm)
let base_d = 200.0; // [150.0, 260.0] Base diameter (mm)
let depth = 150.0; // [100.0, 200.0] Ring depth (mm)
let wall = 2.5; // [2.0, 4.0] Wall thickness (mm)
// # Detail
let teeth = 4; // [0, 8] Number of base teeth
let collar_d = 120.0; // [80.0, 160.0] Watering collar diameter (mm)
let rt = top_d / 2.0;
let rb = base_d / 2.0;
let shell = cone(rb, rt, depth) - cone(rb - wall, rt - wall, depth + 0.02).translate([0, 0, -0.01]);
let rim = cylinder([0, 0, depth - 10.0], "Z", rt + 5.0, 10.0) - cylinder([0, 0, depth - 11.0], "Z", rt - wall - 0.5, 12.0);
let ts = [];
for i in 0..teeth {
    let a = i.to_float() * 360.0 / teeth.to_float();
    ts.push(polygon("XZ", [[rb - wall - 1.0, 0.01], [rb + 0.5, 0.01], [rb + 0.5 - 1.0, -15.0]]).to_face().extrude([0, 20.0, 0]).translate([0, -10.0, 0]).rotate_z(a));
}
let cr = min(collar_d / 2.0, rb - 20.0);
let collar = cylinder([0, 0, depth - 40.0], "Z", cr, 40.0) - cylinder([0, 0, depth - 41.0], "Z", cr - wall, 42.0);
let spokes = [];
for i in 0..3 {
    spokes.push(box_from_corners([cr - wall - 0.5, -2.0, depth - 10.0], [rt - wall + 0.5, 2.0, depth]).rotate_z(i.to_float() * 120.0 + 60.0));
}
let base = shell + rim + collar + fuse_all(spokes);
if teeth > 0 { base + fuse_all(ts) } else { base }
