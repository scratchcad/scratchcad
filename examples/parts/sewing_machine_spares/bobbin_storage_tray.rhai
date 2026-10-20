// Bobbin storage tray: 3 x 4 grid of 21.5 mm pockets 10 mm deep on a 26 mm pitch for class 15 / L bobbins, 4 mm floor, 6 mm margin, 5 mm rounded corners and a 1 mm top chamfer, 8 mm thumb holes through the floor of each pocket for pushing bobbins out
let rows = 3; // [1, 5] Number of rows
let cols = 4; // [1, 6] Number of columns
let pocket_d = 21.5; // [18.0, 24.0] Pocket diameter (mm)
let pocket_depth = 10.0; // [6.0, 14.0] Pocket depth (mm)
const floor_t = 4.0;
const margin = 6.0;
let pitch = pocket_d + 4.5;
let lx = cols.to_float() * pitch + 2.0 * margin - 4.5;
let ly = rows.to_float() * pitch + 2.0 * margin - 4.5;
let h = floor_t + pocket_depth;
let tray = box_from_corners([0, 0, 0], [lx, ly, h]);
let tray = tray.fillet(5.0, tray.edges("|Z"));
let tray = tray.chamfer(1.0, tray.edges(">Z"));
let cuts = [];
for i in 0..cols {
    for j in 0..rows {
        let x = margin + pocket_d / 2.0 + i.to_float() * pitch;
        let y = margin + pocket_d / 2.0 + j.to_float() * pitch;
        cuts.push(cylinder([x, y, floor_t], "Z", pocket_d / 2.0, pocket_depth + 1.0));
        cuts.push(cylinder([x, y, -1.0], "Z", 4.0, floor_t + 2.0));
    }
}
tray - fuse_all(cuts)
