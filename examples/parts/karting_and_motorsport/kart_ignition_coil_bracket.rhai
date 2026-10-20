// Kart ignition coil bracket: 4 mm plate 70 x 40 mm with two M5 holes (5.3 mm) 50 mm apart for the coil, bent down 90 degrees into a 35 mm leg with an M8 clearance slot (8.5 x 16 mm) to the engine, a 2 mm cable tie slot 4 x 10 mm and 3 mm rounded corners
let plate_len = 70.0; // [55.0, 100.0] Coil plate length (mm)
let width = 40.0; // [30.0, 60.0] Bracket width (mm)
let leg_h = 35.0; // [25.0, 60.0] Leg height (mm)
let coil_spacing = 50.0; // [35.0, 80.0] Coil hole spacing (mm)
const t = 4.0;
let top = box_from_corners([0, -width / 2.0, leg_h - t], [plate_len, width / 2.0, leg_h]);
let top = top.fillet(3.0, top.edges("|Z and >X"));
let leg = box_from_corners([0, -width / 2.0, 0], [t, width / 2.0, leg_h]);
let leg = leg.fillet(3.0, leg.edges("|X and <Z"));
let body = top + leg;
let sp = min(coil_spacing, plate_len - 14.0);
let xc = t + (plate_len - t) / 2.0;
let zs = min(16.0, (leg_h - t) / 2.0 + 2.0);
let cuts = [
    cylinder([xc - sp / 2.0 + 2.0, 0, leg_h - t - 1.0], "Z", 2.65, t + 2.0),
    cylinder([xc + sp / 2.0 - 2.0, 0, leg_h - t - 1.0], "Z", 2.65, t + 2.0),
    box_centered(10.0, 4.0, t + 2.0).translate([xc, width / 2.0 - 6.0, leg_h - t / 2.0]),
    box_centered(t + 2.0, 8.5, 16.0 - 8.5).translate([t / 2.0, 0, zs]),
    cylinder([-1.0, 0, zs - 3.75], "X", 4.25, t + 2.0),
    cylinder([-1.0, 0, zs + 3.75], "X", 4.25, t + 2.0)
];
body - fuse_all(cuts)
