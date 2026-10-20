// Softbox speed ring: 150 mm ring 15 mm thick with a 105 mm light opening (Bowens fit), 8 rod sockets 8 mm diameter 30 mm deep angled 30 degrees forward in 16 mm bosses
let diameter = 150.0; // [120.0, 200.0] Ring diameter (mm)
let opening = 105.0; // [90.0, 120.0] Light opening (mm)
let thickness = 15.0; // [10.0, 25.0] Ring thickness (mm)
let rods = 8; // [4, 16] Number of rod sockets
let rod = 8.0; // [5.0, 10.0] Rod diameter (mm)
let tilt = 30.0; // [10.0, 45.0] Rod angle (degrees)
let r = diameter / 2.0;
let ring = cylinder(r, thickness) - cylinder([0, 0, -1.0], "Z", opening / 2.0, thickness + 2.0);
let bosses = [];
let sockets = [];
let a = tilt * PI() / 180.0;
let dir = [a.cos(), 0.0, a.sin()];
// each boss leans out of the ring face; the rod socket enters from its outer end
let p0 = [r - 22.0, 0.0, thickness / 2.0];
let p1 = [p0[0] + 24.0 * dir[0], 0.0, p0[2] + 24.0 * dir[2]];
for k in 0..rods {
    let ang = k.to_float() * 360.0 / rods.to_float();
    bosses.push(cylinder(p0, dir, 8.0, 24.0).rotate_z(ang));
    sockets.push(cylinder([p1[0] + dir[0], 0.0, p1[2] + dir[2]], [-dir[0], 0.0, -dir[2]], rod / 2.0, 31.0).rotate_z(ang));
}
(ring + fuse_all(bosses)) - fuse_all(sockets)
