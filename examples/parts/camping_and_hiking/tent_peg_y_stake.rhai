// Y-section tent peg: 180 mm aluminium, 3 vanes 10 mm wide 1.8 mm thick, hook cap, 6 mm cord hole
let length = 180.0; // [120.0, 250.0] Length (mm)
let vane = 10.0; // [6.0, 15.0] Vane reach (mm)
let t = 1.8; // [1.2, 3.0] Vane thickness (mm)
let vanes = [];
for k in 0..3 { vanes.push(box_from_corners([0, -t / 2.0, 0], [vane, t / 2.0, length]).rotate_z(k.to_float() * 120.0)); }
let body = fuse_all(vanes) + cylinder(t, length);
let tip = cone(vane + 2.0, 0.5, 30.0).rotate_x(180.0).translate([0, 0, 30.0]);
let shaped = body & (tip + cylinder([0, 0, 29.99], "Z", vane + 2.0, length));
let cap = cylinder([0, 0, length - 0.01], "Z", vane + 1.0, 4.0);
shaped + cap - cylinder([0, -20, length - 15.0], "Y", 3.0, 40.0).rotate_z(30.0)
