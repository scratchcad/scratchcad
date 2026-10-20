// 6 x 30 mm nylon wall plug with a collar, two splayed legs separated by a slot, and anti-rotation fins
let diameter = 6.0; // [5.9, 14.0] Diameter (mm)
let length = 30.0; // [20.0, 80.0] Length (mm)
let screw_hole = 3.5; // [2.0, 3.6] Screw hole (mm)
let plug = cylinder(diameter / 2.0, length) + cylinder(diameter / 2.0 + 0.6, 1.0);
let fins = [];
for i in 0..4 { fins.push(box_centered(diameter + 1.6, 0.6, length * 0.25).translate([0, 0, length * 0.25]).rotate_z(i * 45)); }
plug = fuse_all([plug] + fins);
plug = plug - cylinder([0, 0, -1], "Z", screw_hole / 2.0, length + 2.0) - box_centered(diameter * 2.0, 0.8, length * 0.5).translate([0, 0, length * 0.8]);
plug.chamfer(0.6, ">Z")
