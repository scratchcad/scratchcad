// Motorcycle kickstand puck for soft ground: 90 mm disc 10 mm thick, 42 x 26 mm foot pocket 5 mm deep, base grip grooves, lanyard tab with a 6 mm hole
let diameter = 90.0; // [60.0, 130.0] Diameter (mm)
let thickness = 10.0; // [6.0, 16.0] Thickness (mm)
let pocket_length = 42.0; // [25.0, 60.0] Foot pocket length (mm)
let pocket_width = 26.0; // [15.0, 40.0] Foot pocket width (mm)
let pocket_depth = 5.0; // [2.0, 8.0] Pocket depth (mm)
let grooves = 5; // [0, 9] Number of base grooves
let r = diameter / 2.0;
let puck = cylinder(r, thickness) + box_from_corners([r - 5.0, -9.0, 0], [r + 12.0, 9.0, 5.0]).fillet(8.0, "|Z and >X");
puck = puck.chamfer(1.5, puck.edges(">Z"));
let pd = min(pocket_depth, thickness - 3.0);
puck = puck - box_centered(min(pocket_length, diameter - 20.0), min(pocket_width, diameter - 30.0), pd + 1.0).translate([0, 0, thickness - pd + (pd + 1.0) / 2.0]).fillet(5.0, "|Z");
puck = puck - cylinder([r + 5.0, 0, -1.0], "Z", 3.0, 8.0);
let cuts = [];
let pitch = diameter / (grooves.to_float() + 1.0);
for i in 1..=grooves { cuts.push(box_centered(3.0, diameter + 2.0, 3.0).translate([-r + i.to_float() * pitch, 0, 0])); }
if grooves > 0 { puck = puck - compound(cuts); }
puck
