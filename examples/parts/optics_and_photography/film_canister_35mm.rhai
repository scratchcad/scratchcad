// 35 mm film canister with snap lid (Kodak style): 31.5 mm OD body 50 mm tall, 1 mm wall, 34 mm lid with a 2 mm plug ring that snaps over a bead at the rim
let body_od = 31.5; // [28.0, 36.0] Body diameter (mm)
let body_height = 50.0; // [40.0, 60.0] Body height (mm)
let wall = 1.0; // [0.6, 2.0] Wall thickness (mm)
let lid_od = 34.0; // [30.0, 40.0] Lid diameter (mm)
let lid_gap = 3.0; // [0.0, 20.0] Lid lifted off for display (mm)
let r = body_od / 2.0;
let body = cylinder(r, body_height).fillet(1.5, "%CIRCLE and <Z");
body = body + torus(r - 0.1, 0.5).translate([0, 0, body_height - 1.5]);
body = body.shell(-wall, ">Z");
// lid: top disc with a skirt that grips the bead and a plug ring that sits inside the rim
let zl = body_height + lid_gap;
let lid = cylinder([0, 0, zl], "Z", lid_od / 2.0, 1.4).fillet(0.6, "%CIRCLE and >Z");
let skirt = cylinder([0, 0, zl - 4.0], "Z", lid_od / 2.0, 4.1) - cylinder([0, 0, zl - 5.0], "Z", r + 0.45, 5.0);
let plug = cylinder([0, 0, zl - 3.0], "Z", r - wall - 0.05, 3.1) - cylinder([0, 0, zl - 4.0], "Z", r - wall - 1.2, 4.0);
compound([body, lid + skirt + plug])
