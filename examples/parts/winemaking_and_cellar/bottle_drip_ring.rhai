// Wine bottle drip ring: 32 mm bore for the neck with 0.8 mm grip fins, 44 mm OD, 12 mm tall with a 2 mm absorbent-felt groove
let neck = 32.0; // [28.0, 36.0] Neck diameter (mm)
let height = 12.0; // [8.0, 18.0] Ring height (mm)
const od = 44.0;
let ring = cylinder([0, 0, 0], "Z", od / 2.0, height) - cylinder([0, 0, -1.0], "Z", neck / 2.0 + 1.0, height + 2.0);
let fins = [];
for i in 0..6 { fins.push(box_centered(1.6, 0.8, height).translate([neck / 2.0 + 0.6, 0, height / 2.0]).rotate_z(i.to_float() * 60.0)); }
let groove = cylinder([0, 0, height / 2.0 - 1.0], "Z", od / 2.0 + 1.0, 2.0) - cylinder([0, 0, height / 2.0 - 2.0], "Z", od / 2.0 - 1.5, 4.0);
ring + fuse_all(fins) - groove
