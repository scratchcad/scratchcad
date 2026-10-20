// Broadhead wrench: 70 x 30 x 5 mm plate with a 9 mm ferrule hole and three 1.2 mm blade slots 14 mm long at 120 degrees, plus a 6 mm lanyard hole
let length = 70.0; // [55.0, 90.0] Wrench length (mm)
let slot_w = 1.2; // [0.8, 2.0] Blade slot width (mm)
let slot_l = 14.0; // [10.0, 15.0] Slot length from centre (mm)
const t = 5.0;
let plate = box_centered(length, 30.0, t).translate([0, 0, t / 2.0]);
let plate = plate.fillet(8.0, plate.edges("|Z"));
let c = [-length / 2.0 + 15.0, 0, 0];
let cut = [cylinder([c[0], 0, -1.0], "Z", 4.5, t + 2.0), cylinder([length / 2.0 - 8.0, 0, -1.0], "Z", 3.0, t + 2.0)];
for i in 0..3 { cut.push(box_from_corners([0, -slot_w / 2.0, -1.0], [slot_l, slot_w / 2.0, t + 1.0]).rotate_z(90.0 + 120.0 * i.to_float()).translate([c[0], 0, 0])); }
plate - fuse_all(cut)
