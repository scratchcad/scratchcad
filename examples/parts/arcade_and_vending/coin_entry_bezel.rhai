// Coin entry bezel: 50 x 25 mm bezel 4 mm thick with a funnelled 28 x 3.5 mm coin slot (tapering from 34 x 8 mm at the face), 2 mm walls behind and two M3 studs
let slot_w = 28.0; // [22.0, 34.0] Coin slot width (mm)
let slot_t = 3.5; // [2.5, 4.5] Coin slot thickness (mm)
const t = 4.0;
let b = box_centered(50.0, 25.0, t).translate([0, 0, t / 2.0]);
let b = b.fillet(4.0, b.edges("|Z"));
let funnel = loft([rect(plane([0, 0, t + 0.01], [0, 0, 1]), slot_w + 6.0, slot_t + 4.5), rect(plane([0, 0, 0.5], [0, 0, 1]), slot_w, slot_t)], true);
let thru = box_centered(slot_w, slot_t, t + 2.0).translate([0, 0, t / 2.0]);
let studs = cylinder([-20.0, 0, -6.0], "Z", 1.5, 6.01) + cylinder([20.0, 0, -6.0], "Z", 1.5, 6.01);
b - funnel - thru + studs
