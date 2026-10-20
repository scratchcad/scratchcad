// Ampoule tray for 10 x 2 ml glass ampoules (11.5 mm body, 60 mm long): 12 mm thick tray 50 mm deep with 10 cradles 12.2 mm across sunk to half their diameter at 17 mm pitch, a 26 mm finger groove 5 mm deep across the middle for lifting the ampoules out, and 3 mm rounded corners
let count = 10; // [4, 16] Number of ampoules
let ampoule_d = 12.2; // [8.0, 16.0] Cradle diameter (mm)
let pitch = 17.0; // [14.0, 24.0] Cradle spacing (mm)
let tray_depth = 50.0; // [35.0, 80.0] Tray depth (mm)
const tray_t = 12.0;
const margin = 8.0;
let r = ampoule_d / 2.0;
let p = max(pitch, ampoule_d + 2.0);
let lx = (count - 1) * p + 2.0 * (margin + r);
let tray = box_from_corners([0, 0, 0], [lx, tray_depth, tray_t]);
let tray = tray.fillet(3.0, tray.edges("|Z"));
let zc = tray_t;
let cutters = [];
for i in 0..count {
    cutters.push(cylinder([margin + r + i * p, -1.0, zc], "Y", r, tray_depth + 2.0));
}
cutters.push(cylinder([-1.0, tray_depth / 2.0, tray_t + 15.0], "X", 20.0, lx + 2.0));
tray - fuse_all(cutters)
