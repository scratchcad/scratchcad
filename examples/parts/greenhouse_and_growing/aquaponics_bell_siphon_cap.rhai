// Aquaponics bell siphon bell: 75 mm bell (for a 25 mm standpipe in a grow bed) 250 mm tall with 2.5 mm wall, closed domed top with a 6 mm snorkel port, 8 intake slots 8 x 30 mm at the base
// # Bell
let bell_d = 75.0; // [50.0, 110.0] Bell outer diameter (mm)
let height = 250.0; // [150.0, 350.0] Bell height (mm)
let wall = 2.5; // [2.0, 4.0] Wall thickness (mm)
// # Slots
let slots = 8; // [4, 12] Number of intake slots
let slot_w = 8.0; // [4.0, 12.0] Intake slot width (mm)
let slot_h = 30.0; // [15.0, 50.0] Intake slot height (mm)
let snorkel = 6.0; // [4.0, 12.0] Snorkel port diameter (mm)
let r = bell_d / 2.0;
let body = sketch("XZ").move_to(0, 0).hline_to(r).vline_to(height - 12.0).line_to(r * 0.55, height).hline_to(0).close().to_face().revolve("Z", 360);
let inner = sketch("XZ").move_to(0, -1.0).hline_to(r - wall).vline_to(height - 12.0 - wall * 0.5).line_to(r * 0.55 - wall * 0.5, height - wall).hline_to(0).close().to_face().revolve("Z", 360);
let cuts = [];
for i in 0..slots {
    cuts.push(box_from_corners([r - wall * 3.0, -slot_w / 2.0, -1.0], [r + 1.0, slot_w / 2.0, slot_h]).rotate_z(i.to_float() * 360.0 / slots.to_float()));
}
let port = cylinder([0, 0, height - wall * 2.0], "Z", snorkel / 2.0, wall * 4.0);
let boss = cylinder([0, 0, height - 0.01], "Z", snorkel / 2.0 + 2.0, 8.0);
(body - inner + boss) - fuse_all(cuts) - port
