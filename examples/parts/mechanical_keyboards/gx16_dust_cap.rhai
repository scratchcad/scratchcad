// GX16 aviator connector dust cap: 19 mm OD, 12 mm tall, 16.2 mm bore 10 mm deep with 1 mm thread-relief ribs, 16 grip ribs and a 3 mm lanyard eye
let bore = 16.2; // [15.8, 16.6] Bore for the M16 thread (mm)
let depth = 10.0; // [6.0, 14.0] Bore depth (mm)
const od = 19.0;
let height = depth + 2.0;
let c = cylinder([0, 0, 0], "Z", od / 2.0, height);
let ribs = [];
for i in 0..16 { ribs.push(box_centered(1.0, 1.0, height).translate([od / 2.0, 0, height / 2.0]).rotate_z(i.to_float() * 22.5)); }
let eye = cylinder([od / 2.0 + 2.0, -1.5, height - 3.0], "Y", 3.0, 3.0) - cylinder([od / 2.0 + 2.5, -2.0, height - 3.0], "Y", 1.5, 4.0);
c + fuse_all(ribs) + eye - cylinder([0, 0, -1.0], "Z", bore / 2.0, depth + 1.0)
