// Tape dispenser hub for 25 mm (1 in) cores: 24.5 mm drum 19 mm wide with three relief slots, 6 mm axle stubs either side
let core = 25.0; // [25.0, 76.0] Tape core diameter (mm)
let w = 19.0; // [12.0, 25.0] Tape width (mm)
let r = core / 2.0 - 0.25;
let drum = cylinder([0, 0, 0], "Y", r, w) - cylinder([0, -1, 0], "Y", r - 2.0, w + 2.0);
let web = cylinder([0, w / 2.0 - 1.5, 0], "Y", r - 1.0, 3.0);
let slots = [];
for k in 0..3 { slots.push(box_centered(1.5, w * 0.7, 3.0).translate([0, w * 0.35, r - 1.0]).rotate([0, 0, 0], "Y", k.to_float() * 120.0)); }
fuse_all([drum - fuse_all(slots), web, cylinder([0, -6.0, 0], "Y", 3.0, w + 12.0)])
