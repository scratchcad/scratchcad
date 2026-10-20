// Liquid soap pump collar, 28/410 neck: 32 mm OD, 28.6 mm bore, 12 mm tall, 9 mm stem hole, 30 grip ribs, inner snap bead
let od = 32.0; // [28.0, 40.0] Outside diameter (mm)
let bore = 28.6; // [24.0, 36.0] Bore for the bottle neck (mm)
let height = 12.0; // [8.0, 18.0] Collar height (mm)
let stem_hole = 9.0; // [6.0, 14.0] Pump stem hole (mm)
let ribs = 30; // [12, 48] Grip ribs
const top = 2.0;
let body = cylinder(od / 2.0, height) - cylinder([0, 0, -1], "Z", bore / 2.0, height - top + 1.0) - cylinder([0, 0, 0], "Z", stem_hole / 2.0, height + 1.0);
let bead = cylinder([0, 0, 2.0], "Z", bore / 2.0 + 0.01, 1.2) - cylinder([0, 0, 1.0], "Z", bore / 2.0 - 0.6, 4.0);
let rs = [];
for i in 0..ribs { rs.push(box_from_corners([od / 2.0 - 0.5, -0.5, 1.0], [od / 2.0 + 0.6, 0.5, height - 1.0]).rotate_z(i.to_float() * 360.0 / ribs.to_float())); }
body + bead + fuse_all(rs)
