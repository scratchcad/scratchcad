// Capsule filling plate for size 0 hard capsules (7.34 mm body, 18.4 mm body length): 20 mm thick plate with a 6 x 8 grid of 7.5 mm blind holes 18.4 mm deep at 10 mm pitch, 8 mm margins, and a 3 mm wide powder rim 4 mm high around the top
let rows = 6; // [3, 10] Number of rows
let cols = 8; // [3, 10] Number of columns
let hole_d = 7.5; // [5.0, 8.0] Hole diameter (mm)
let hole_depth = 18.4; // [10.0, 22.0] Hole depth (mm)
let pitch = 10.0; // [9.5, 14.0] Hole spacing (mm)
const plate_t = 24.0;
const margin = 8.0;
const rim_w = 3.0;
const rim_h = 4.0;
let deck = plate_t - rim_h;
let lx = (cols - 1) * pitch + 2.0 * margin;
let ly = (rows - 1) * pitch + 2.0 * margin;
let plate = box_from_corners([0, 0, 0], [lx, ly, plate_t]) - box_from_corners([rim_w, rim_w, deck], [lx - rim_w, ly - rim_w, plate_t + 1.0]);
let depth = min(hole_depth, deck - 1.5);
let holes = [];
for i in 0..cols {
    for j in 0..rows {
        holes.push(cylinder([margin + i * pitch, margin + j * pitch, deck - depth], "Z", hole_d / 2.0, depth + 1.0));
    }
}
plate - fuse_all(holes)
