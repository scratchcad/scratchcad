// Reservoir float valve bracket: a 4 mm thick U clip 30 mm wide that hooks over a tank wall up to 8 mm thick with legs 40 mm deep, an M5 clamp screw hole (4.2 mm tapping) in the outer leg, and a 45 mm shelf at the foot of the inner leg with a 21.5 mm hole for a 1/2 inch BSP float valve shank
let wall_gap = 8.0; // [3.0, 20.0] Tank wall thickness (mm)
let leg_depth = 40.0; // [30.0, 80.0] Inner leg depth (mm)
let shelf_len = 45.0; // [35.0, 70.0] Shelf length (mm)
let width = 30.0; // [26.0, 45.0] Bracket width (mm)
let valve_hole = 21.5; // [10.0, 22.0] Valve shank hole diameter (mm)
const t = 4.0;
let g = wall_gap;
let h = leg_depth;
const outer = 25.0;
let pts = [[g + t, 0, h + t], [-t, 0, h + t], [-t, 0, t], [-t - shelf_len, 0, t], [-t - shelf_len, 0, 0], [0, 0, 0], [0, 0, h], [g, 0, h], [g, 0, h - outer], [g + t, 0, h - outer]];
let body = face(polygon(pts)).extrude([0, width, 0]).translate([0, -width / 2.0, 0]);
let hr = min(valve_hole / 2.0, width / 2.0 - 3.0);
let hx = -t - shelf_len + hr + 4.0;
let cuts = [
    cylinder([hx, 0, -1.0], "Z", hr, t + 2.0),
    cylinder([g - 1.0, 0, h - 12.0], "X", 2.1, t + 2.0)
];
body - fuse_all(cuts)
