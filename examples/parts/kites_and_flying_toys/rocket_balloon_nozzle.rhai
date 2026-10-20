// Balloon rocket nozzle: 12 mm balloon neck spigot 15 mm long with a 2 mm retaining bead, tapering 3 mm throat 10 mm long, and three 20 x 15 mm stabilising fins 1.5 mm thick
let neck = 12.0; // [8.0, 16.0] Balloon neck spigot (mm)
let throat = 3.0; // [2.0, 6.0] Throat diameter (mm)
let spig = cylinder([0, 0, 0], "Z", neck / 2.0, 15.01) + (cylinder([0, 0, 10.0], "Z", neck / 2.0 + 1.0, 2.0));
let cone_ = cone(neck / 2.0, throat / 2.0 + 1.5, 10.0).translate([0, 0, 15.0]);
let fins = [];
for i in 0..3 { fins.push(face(polygon([[neck / 2.0 - 0.5, 0, 15.0], [neck / 2.0 + 15.0, 0, 25.0], [neck / 2.0 - 0.5, 0, 25.0]])).extrude([0, 1.5, 0]).translate([0, -0.75, 0]).rotate_z(i.to_float() * 120.0)); }
spig + cone_ + fuse_all(fins) - cylinder([0, 0, -1.0], "Z", neck / 2.0 - 1.5, 16.0) - cone(neck / 2.0 - 1.5, throat / 2.0, 10.02).translate([0, 0, 14.99])
