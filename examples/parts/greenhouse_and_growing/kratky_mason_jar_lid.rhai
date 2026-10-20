// Kratky mason jar lid: net cup adapter for a wide-mouth mason jar (86 mm opening, 90 mm lid band), 3 mm top disc with a 2 in (50 mm) net cup hole, 8 mm locating skirt and a 6 mm top-up port with plug notch
// # Jar
let jar_mouth = 86.0; // [60.0, 100.0] Jar mouth inside diameter (mm)
let rim_d = 92.0; // [65.0, 110.0] Top disc diameter (mm)
let skirt = 8.0; // [4.0, 15.0] Skirt depth (mm)
// # Cup
let cup_hole = 50.0; // [30.0, 75.0] Net cup hole diameter (mm)
let port = 6.0; // [4.0, 12.0] Top-up port diameter (mm)
const thickness = 3.0;
let R = rim_d / 2.0;
let disc = cylinder(R, thickness);
let sk = cylinder([0, 0, -skirt], "Z", jar_mouth / 2.0 - 0.3, skirt + 0.01) - cylinder([0, 0, -skirt - 1.0], "Z", jar_mouth / 2.0 - 2.3, skirt + 1.0);
let hole_d = min(cup_hole, jar_mouth - 2.0 * port - 12.0);
let hole = cylinder([0, 0, -skirt - 1.0], "Z", hole_d / 2.0, skirt + thickness + 2.0);
let px = (hole_d / 2.0 + jar_mouth / 2.0 - 2.3) / 2.0;
let port_hole = cylinder([px, 0, -1.0], "Z", port / 2.0, thickness + 2.0);
let notch = box_from_corners([px + port / 2.0 - 0.5, -1.0, thickness - 1.0], [px + port / 2.0 + 3.0, 1.0, thickness + 1.0]);
disc + sk - hole - port_hole - notch
