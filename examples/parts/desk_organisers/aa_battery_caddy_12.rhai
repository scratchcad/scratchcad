// Desk AA battery caddy for 12 cells: 3 x 4 grid of 15.2 mm holes 30 mm deep for 14.5 x 50.5 mm AA cells, 18 mm pitch, 3 mm floor with 6 mm push-out holes, front label recess 50 x 12 mm
let cols = 4; // [2, 8] Cells per row
let rows = 3; // [1, 6] Number of rows
let cell_d = 15.2; // [10.8, 15.6] Hole diameter (mm)
let pitch = 18.0; // [13.0, 24.0] Cell pitch (mm)
let hole_depth = 30.0; // [15.0, 45.0] Hole depth (mm)

const floor_t = 3.0;
const margin = 5.0;
let p = max(pitch, cell_d + 2.0);
let w = cols * p + 2.0 * margin - (p - cell_d);
let d = rows * p + 2.0 * margin - (p - cell_d);
let h = hole_depth + floor_t;
let block = box_from_corners([0, 0, 0], [w, d, h]);
block = block.fillet(4.0, block.edges("|Z"));
block = block.fillet(1.0, block.edges(">Z"));
let cuts = [];
for j in 0..rows {
    for i in 0..cols {
        let x = margin + cell_d / 2.0 + i * p;
        let y = margin + cell_d / 2.0 + j * p;
        cuts.push(cylinder([x, y, floor_t], "Z", cell_d / 2.0, h));
        cuts.push(cylinder([x, y, -1.0], "Z", 3.0, floor_t + 2.0));
    }
}
block = block - fuse_all(cuts);
let lw = min(50.0, w - 10.0);
block - box_from_corners([w / 2.0 - lw / 2.0, -1.0, h / 2.0 - 6.0], [w / 2.0 + lw / 2.0, 0.8, h / 2.0 + 6.0])
