// Pharmaceutical blister tray for ten 8 mm round tablets (2 x 5): 80 x 40 mm forming web, 0.4 mm PVC, 9.2 mm cavities 4 mm deep with rounded crowns on a 15 mm x 18 mm pitch
let tablet_diameter = 8.0; // [4.0, 14.0] Tablet diameter (mm)
let cavity_depth = 4.0; // [2.0, 8.0] Cavity depth (mm)
let film = 0.4; // [0.25, 0.8] Film thickness (mm)
let columns = 5; // [2, 8] Number of columns
let rows = 2; // [1, 4] Number of rows
let pitch_x = 15.0; // [10.0, 25.0] Column pitch (mm)
let pitch_y = 18.0; // [10.0, 25.0] Row pitch (mm)
let rc = tablet_diameter / 2.0 + 0.6;
let px = max(pitch_x, 2.0 * rc + 2.0);
let py = max(pitch_y, 2.0 * rc + 2.0);
let w = columns.to_float() * px + 5.0;
let d = rows.to_float() * py + 4.0;
let crown = min(1.5, cavity_depth / 2.0);
let outers = [box_from_corners([-w / 2.0, -d / 2.0, 0], [w / 2.0, d / 2.0, film]).fillet(3.0, "|Z")];
let inners = [];
for i in 0..columns {
    for j in 0..rows {
        let x = (i.to_float() - (columns.to_float() - 1.0) / 2.0) * px;
        let y = (j.to_float() - (rows.to_float() - 1.0) / 2.0) * py;
        outers.push(cylinder([x, y, 0.1], "Z", rc + film, cavity_depth + film - 0.1).fillet(crown + film, ">Z"));
        inners.push(cylinder([x, y, -1.0], "Z", rc, cavity_depth + 1.0).fillet(crown, ">Z"));
    }
}
// bubbles open from below, where the lidding foil goes
fuse_all(outers) - fuse_all(inners)
