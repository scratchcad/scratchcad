// Irrigation barbed elbow: 90 degree elbow for 16 mm LDPE drip pipe (13.6 mm bore), 18 mm square hub, two 25 mm legs with three 15.6 mm barbs each over a 12.4 mm spigot, 9 mm flow bore
// # Pipe
let pipe_id = 13.6; // [11.0, 17.0] Pipe inside diameter (mm)
let leg_length = 25.0; // [15.0, 35.0] Leg length from the hub (mm)
let barbs = 3; // [1, 4] Number of barbs per leg
// # Body
let bore = 9.0; // [6.0, 12.0] Flow bore diameter (mm)
let hub = 18.0; // [14.0, 24.0] Hub size (mm)
let rs = pipe_id / 2.0 - 0.6;
let rb = pipe_id / 2.0 + 1.0;
let block = box_centered(hub, hub, hub).fillet(2.0, "|Z");
let parts = [block];
for axis in ["X", "Y"] {
    let leg = [cylinder([0, 0, hub / 2.0 - 0.5], "Z", rs, leg_length + 0.5)];
    let pitch = (leg_length - 4.0) / barbs.to_float();
    for i in 0..barbs {
        leg.push(cone(rb, rs - 0.3, pitch * 0.8).translate([0, 0, hub / 2.0 + 2.0 + i.to_float() * pitch]));
    }
    let l = fuse_all(leg);
    parts.push(if axis == "X" { l.rotate_y(90.0) } else { l.rotate_x(-90.0) });
}
let body = fuse_all(parts);
let bores = [cylinder([0, 0, 0], "X", bore / 2.0, hub / 2.0 + leg_length + 1.0), cylinder([0, 0, 0], "Y", bore / 2.0, hub / 2.0 + leg_length + 1.0), sphere(bore / 2.0 + 0.2)];
body - fuse_all(bores)
