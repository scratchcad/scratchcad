// Unit dose cup tray for a medicine round: 3 x 4 tapered pockets matching 30 ml cups (30.5 mm at the base widening at the cups' 10 degree side taper), 20 mm deep in a 23 mm thick tray at 50 mm pitch, with 6 mm rounded corners and two 80 x 22 mm hand slots at the ends
let rows = 3; // [1, 4] Number of rows
let cols = 4; // [2, 6] Number of columns
let base_d = 30.5; // [24.0, 36.0] Pocket base diameter (mm)
let pocket_depth = 20.0; // [12.0, 26.0] Pocket depth (mm)
let pitch = 50.0; // [48.0, 60.0] Pocket spacing (mm)
const floor_t = 3.0;
const margin = 6.0;
const handle = 30.0;
let rb = base_d / 2.0;
let rt = rb + pocket_depth * 0.176;
let lx = cols * pitch + 2.0 * handle;
let ly = rows * pitch + 2.0 * margin;
let h = floor_t + pocket_depth;
let tray = box_from_corners([0, 0, 0], [lx, ly, h]);
let tray = tray.fillet(6.0, tray.edges("|Z"));
let cutters = [];
for i in 0..cols {
    for j in 0..rows {
        cutters.push(cone(rb, rt + 0.18, pocket_depth + 1.0).translate([handle + pitch / 2.0 + i * pitch, margin + pitch / 2.0 + j * pitch, floor_t]));
    }
}
let slot_l = min(80.0, ly - 20.0);
for x in [handle / 2.0, lx - handle / 2.0] {
    let r = 11.0;
    let slot = fuse_all([
        box_from_corners([x - r, ly / 2.0 - slot_l / 2.0 + r, -1.0], [x + r, ly / 2.0 + slot_l / 2.0 - r, h + 1.0]),
        cylinder([x, ly / 2.0 - slot_l / 2.0 + r, -1.0], "Z", r, h + 2.0),
        cylinder([x, ly / 2.0 + slot_l / 2.0 - r, -1.0], "Z", r, h + 2.0),
    ]);
    cutters.push(slot);
}
tray - fuse_all(cutters)
