// Spin-lock collar for 1 in (25 mm) threaded dumbbell handles: 62 mm star nut with 6 lobes, 30 mm long, 25.4 mm thread bore with 4 mm pitch grooves, 2 mm face chamfers
let thread_d = 25.4; // [22.0, 30.0] Thread diameter (mm)
let pitch = 4.0; // [2.5, 6.0] Thread pitch (mm)
let outer_d = 62.0; // [45.0, 80.0] Outer diameter (mm)
let length = 30.0; // [20.0, 45.0] Length (mm)
let lobes = 6; // [3, 8] Number of grip lobes
let r = outer_d / 2.0;
let nut = cylinder(r, length);
let scallops = [];
for i in 0..lobes {
    let a = (i.to_float() + 0.5) * 2.0 * PI() / lobes.to_float();
    scallops.push(cylinder([(r + 4.0) * a.cos(), (r + 4.0) * a.sin(), -1.0], "Z", r * 0.32, length + 2.0));
}
nut = nut - compound(scallops);
let rb = thread_d / 2.0;
let turns = ((length - 2.0) / pitch).floor().to_int();
let bore = [[0.0, -1.0], [rb, -1.0], [rb, 1.0]];
for i in 0..turns {
    bore.push([rb, 1.0 + i.to_float() * pitch + pitch * 0.25]);
    bore.push([rb - 1.6, 1.0 + i.to_float() * pitch + pitch * 0.75]);
    bore.push([rb, 1.0 + (i.to_float() + 1.0) * pitch]);
}
bore.push([rb, length + 1.0]);
bore.push([0.0, length + 1.0]);
nut = nut - polygon("XZ", bore).to_face().revolve("Z", 360);
nut.chamfer(1.0, nut.edges("%CIRCLE").filter(|e| e.radius() > rb + 0.5 && e.radius() < r + 0.1))
