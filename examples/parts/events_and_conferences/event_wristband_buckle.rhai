// Event wristband one-way buckle: 20 x 14 mm buckle 4 mm thick for a 15 mm band, with a 15.5 x 1.5 mm band slot and 4 one-way teeth 1 mm inside the slot
let band = 15.0; // [10.0, 25.0] Band width (mm)
let t = 4.0; // [3.0, 6.0] Buckle thickness (mm)
let w = band + 5.0;
let b = box_centered(w, 14.0, t).translate([0, 0, t / 2.0]);
let b = b.fillet(3.0, b.edges("|Z"));
let slot = box_centered(band + 0.5, 1.5, t + 2.0).translate([0, 0, t / 2.0]);
let teeth = [];
for i in 0..4 { teeth.push(face(polygon([[-band / 2.0 + 2.0 + i.to_float() * (band - 4.0) / 3.0 - 1.0, 0.76, t - 0.5], [-band / 2.0 + 2.0 + i.to_float() * (band - 4.0) / 3.0 + 1.0, 0.76, t - 0.5], [-band / 2.0 + 2.0 + i.to_float() * (band - 4.0) / 3.0, -0.2, t - 1.5]])).extrude([0, 0, -1.0]).translate([0, 0, 0])); }
b - slot + fuse_all(teeth)
