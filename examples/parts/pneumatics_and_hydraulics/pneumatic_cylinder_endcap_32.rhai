// ISO 15552 32 mm bore cylinder end cap: 45 mm square, 22 mm thick, 32.5 mm bore spigot 6 mm, G1/8 port, 4 tie rod holes on 32.5 mm
let square = 45.0; // [40.0, 60.0] Cap size (mm)
let bore = 32.0; // [25.0, 50.0] Cylinder bore (mm)
let t = 22.0; // [15.0, 30.0] Thickness (mm)
let tie = 32.5; // [28.0, 45.0] Tie rod square (mm)
let cap = box_centered(square, square, t).translate([0, 0, t / 2.0]);
let c = cap.fillet(3.0, cap.edges("|Z"));
let spigot = cylinder([0, 0, t - 0.01], "Z", bore / 2.0 + 2.0, 6.0) - cylinder([0, 0, t + 3.0], "Z", bore / 2.0 + 0.25, 4.0);
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * tie / 2.0, sy * tie / 2.0, -1], "Z", 3.3, t + 2.0)); } }
c + spigot - compound(holes) - cylinder([-square, 0, t / 2.0], "X", 4.25, square / 2.0 + 2.0) - cylinder([0, 0, t / 2.0], "Z", 2.0, t)
