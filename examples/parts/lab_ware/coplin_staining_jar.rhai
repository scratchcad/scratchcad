// Coplin staining jar for 10 slides: 70 x 40 x 90 mm, 3 mm walls, 3 mm floor, internal slot ribs on both long sides
let slides = 5; // [3, 8] Slots per side
let jar = box_centered(70.0, 40.0, 90.0).translate([0, 0, 45.0]).fillet(4.0, "|Z") - box_centered(64.0, 34.0, 90.0).translate([0, 0, 48.0]).fillet(2.0, "|Z");
let ribs = [];
for k in 0..(slides + 1) { for s in [-1.0, 1.0] { ribs.push(box_centered(1.5, 4.0, 80.0).translate([-27.5 + k.to_float() * 55.0 / slides.to_float(), s * 15.0, 43.0])); } }
fuse_all([jar] + ribs)
