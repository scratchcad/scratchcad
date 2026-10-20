// Goggle strap ladder buckle: 30 x 20 mm three-bar slider 2.2 mm thick for 25 mm elastic strap, 2.5 mm bars, raised 1 mm grip ridge on the center bar
let strap = 25.0; // [18.0, 40.0] Strap width (mm)
let thickness = 2.2; // [1.5, 3.5] Thickness (mm)
let bar = 2.5; // [1.8, 4.0] Bar width (mm)
let slot = 4.0; // [2.5, 6.0] Slot width (mm)
let w = strap + 1.0 + 2.0 * bar;
let h = 3.0 * bar + 2.0 * slot;
let frame = box_centered(w, h, thickness).translate([0, 0, thickness / 2.0]);
let f = frame.fillet(2.0, frame.edges("|Z"));
let cuts = [];
for s in [-1.0, 1.0] { cuts.push(box_centered(strap + 1.0, slot, thickness + 2.0).translate([0, s * (slot + bar) / 2.0, thickness / 2.0])); }
let ridge = box_centered(strap * 0.8, 1.0, 1.0).translate([0, 0, thickness + 0.49]);
f - compound(cuts) + ridge
