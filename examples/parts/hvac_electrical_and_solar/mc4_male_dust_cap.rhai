// Protective dust cap for an MC4 male connector: 17 mm OD, 22 mm long, 12.4 mm socket with a snap ring, 10 grip ribs, sealed end and lanyard loop
let od = 17.0; // [14.0, 20.0] Outside diameter (mm)
let length = 22.0; // [15.0, 30.0] Length (mm)
let socket = 12.4; // [10.0, 14.0] Socket diameter (mm)
let ribs = 10; // [0, 16] Number of grip ribs
let ro = od / 2.0;
let rs = min(socket, od - 3.0) / 2.0;
let cap = cylinder(ro, length).fillet(1.5, ">Z").chamfer(0.6, "<Z");
cap -= cylinder([0, 0, -1], "Z", rs, length - 2.0);
cap += torus(rs, 0.5).translate([0, 0, 4.0]) & cylinder(rs + 1.0, 10.0);
let r = [];
for i in 0..ribs { r.push(cylinder([ro + 0.15, 0, 2.0], "Z", 0.55, length - 5.0).rotate_z(i.to_float() * 360.0 / ribs.to_float())); }
if ribs > 0 { cap -= fuse_all(r); }
let loop_ring = (torus(4.0, 1.0).rotate_x(90.0).translate([0, 0, length + 2.5])) & box_centered(20.0, 20.0, 20.0).translate([0, 0, length + 10.0 - 0.6]);
cap + loop_ring
