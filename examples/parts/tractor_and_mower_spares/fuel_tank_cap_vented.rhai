// Small engine fuel cap: 52 mm cap 22 mm tall, 45 mm bore 15 mm deep with 3 thread lugs, 1.5 mm vent hole, 16 grip flutes
let d = 52.0; // [50.0, 70.0] Cap diameter (mm)
let height = 22.0; // [15.0, 30.0] Cap height (mm)
let bore = 45.0; // [35.0, 46.0] Neck bore (mm)
let c = cylinder(d / 2.0, height) - cylinder([0, 0, -1], "Z", bore / 2.0, 16.0);
let flutes = [];
for k in 0..16 { flutes.push(cylinder([d / 2.0 + 1.0, 0, 5.0], "Z", 2.0, height).rotate_z(k.to_float() * 22.5)); }
let lugs = [];
for k in 0..3 { lugs.push(box_from_corners([bore / 2.0 - 1.5, -6.0, 5.0], [bore / 2.0 + 0.01, 6.0, 7.0]).rotate_z(k.to_float() * 120.0)); }
c - fuse_all(flutes) + fuse_all(lugs) - cylinder([0, 0, 10.0], "Z", 0.75, height)
