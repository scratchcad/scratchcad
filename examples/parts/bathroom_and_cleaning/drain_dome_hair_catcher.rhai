// Domed shower drain hair catcher: 70 mm flange 2 mm, 41 mm dome 14 mm high, 1.6 mm wall, 12 radial slots 2 mm wide
let flange_d = 70.0; // [50.0, 100.0] Flange diameter (mm)
let dome_r = 22.0; // [16.0, 30.0] Dome sphere radius (mm)
let wall = 1.6; // [1.0, 2.5] Wall thickness (mm)
let slots = 12; // [6, 24] Number of slots
let slot_w = 2.0; // [1.2, 3.0] Slot width (mm)
const sink = 8.0;
let dome = (sphere([0, 0, -sink], dome_r) - sphere([0, 0, -sink], dome_r - wall)) & box_from_corners([-dome_r, -dome_r, 0], [dome_r, dome_r, dome_r]);
let hole_r = (dome_r - wall) * (dome_r - wall) - sink * sink;
let flange = cylinder(flange_d / 2.0, 2.0) - cylinder([0, 0, -1], "Z", hole_r.sqrt() - 0.8, 4.0);
let cuts = [];
for i in 0..slots { cuts.push(box_from_corners([6.0, -slot_w / 2.0, 3.0], [dome_r + 2.0, slot_w / 2.0, dome_r]).rotate_z(i.to_float() * 360.0 / slots.to_float())); }
dome + flange - compound(cuts)
