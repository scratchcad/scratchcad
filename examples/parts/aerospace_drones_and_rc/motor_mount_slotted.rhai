// Universal motor mount cross: 3 mm plate, 36 mm cross arms 8 mm wide, slotted M3 holes for 16 to 19 mm patterns, 7 mm centre hole
let t = 3.0; // [2.0, 5.0] Thickness (mm)
let plate = box_centered(36.0, 8.0, t) + box_centered(8.0, 36.0, t) + cylinder([0, 0, -t / 2.0], "Z", 8.0, t);
let cuts = [cylinder([0, 0, -t], "Z", 3.5, 2.0 * t)];
for k in 0..4 { cuts.push((box_from_corners([8.0, -1.6, -t], [9.5, 1.6, t]) + cylinder([8.0, 0, -t], "Z", 1.6, 2.0 * t) + cylinder([9.5, 0, -t], "Z", 1.6, 2.0 * t)).translate([3.3, 0, 0]).rotate("Z", k.to_float() * 90.0)); }
plate - fuse_all(cuts)
