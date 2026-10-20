// Walker glide ski: snap-on ski for a 29 mm (1 1/8 in) walker leg, 120 mm long x 40 mm wide, 6 mm sole with 30 degree upturned toe and heel, 32 mm socket boss 35 mm tall with a 3 mm locking-pin hole
// # Fit
let leg = 29.0; // [22.0, 32.0] Walker leg diameter (mm)
let boss_height = 35.0; // [20.0, 50.0] Socket boss height (mm)
// # Ski
let length = 120.0; // [90.0, 160.0] Ski length (mm)
let width = 40.0; // [35.0, 55.0] Ski width (mm)
let sole = 6.0; // [4.8, 10.0] Sole thickness (mm)
let toe = length / 2.0;
let ski = polygon("XZ", [[-toe, 8.0], [-toe + 14.0, 0.0], [toe - 14.0, 0.0], [toe, 8.0], [toe, 8.0 + sole * 0.8], [toe - 14.0, sole], [-toe + 14.0, sole], [-toe, 8.0 + sole * 0.8]]).to_face().extrude([0, width, 0]).translate([0, -width / 2.0, 0]);
let boss_r = leg / 2.0 + 3.5;
let boss = cylinder([0, 0, sole - 0.5], "Z", boss_r, boss_height + 0.5);
let bore = cylinder([0, 0, sole + 2.0], "Z", leg / 2.0, boss_height + 1.0);
let pin = cylinder([0, -boss_r - 1.0, sole + boss_height - 10.0], "Y", 1.5, 2.0 * boss_r + 2.0);
(ski.fillet(1.5, "|Y") + boss) - bore - pin
