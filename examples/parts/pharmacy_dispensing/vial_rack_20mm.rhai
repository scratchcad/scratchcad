// Vial rack for 20 mm vials: 4 x 5 grid at 25 mm pitch, 4 mm top plate with 20.6 mm holes held 32 mm up on four 8 mm square corner posts, over a 3 mm base plate with 1.5 mm deep 20.6 mm seats under each hole, 5 mm outer corner radius
let rows = 4; // [2, 6] Number of rows
let cols = 5; // [2, 8] Number of columns
let hole_d = 20.6; // [16.0, 23.0] Hole diameter (mm)
let pitch = 25.0; // [24.0, 32.0] Hole spacing (mm)
let height = 32.0; // [22.0, 50.0] Top plate height (mm)
const top_t = 4.0;
const base_t = 3.0;
const post = 8.0;
const margin = 6.0;
let lx = cols * pitch + 2.0 * margin;
let ly = rows * pitch + 2.0 * margin;
let plate_top = box_from_corners([0, 0, height - top_t], [lx, ly, height]);
let plate_top = plate_top.fillet(5.0, plate_top.edges("|Z"));
let plate_base = box_from_corners([0, 0, 0], [lx, ly, base_t]);
let plate_base = plate_base.fillet(5.0, plate_base.edges("|Z"));
let parts = [plate_top, plate_base];
for c in [[1.0, 1.0], [lx - 1.0 - post, 1.0], [1.0, ly - 1.0 - post], [lx - 1.0 - post, ly - 1.0 - post]] {
    parts.push(box_from_corners([c[0], c[1], base_t - 0.5], [c[0] + post, c[1] + post, height - top_t + 0.5]));
}
let rack = fuse_all(parts);
let cutters = [];
for i in 0..cols {
    for j in 0..rows {
        let x = margin + pitch / 2.0 + i * pitch;
        let y = margin + pitch / 2.0 + j * pitch;
        cutters.push(cylinder([x, y, height - top_t - 1.0], "Z", hole_d / 2.0, top_t + 2.0));
        cutters.push(cylinder([x, y, base_t - 1.5], "Z", hole_d / 2.0, 2.0));
    }
}
rack - fuse_all(cutters)
