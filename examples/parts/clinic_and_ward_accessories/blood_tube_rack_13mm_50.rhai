// Phlebotomy blood tube rack for 13 mm tubes: 5 x 10 grid at 20 mm pitch, 210 x 110 mm top deck 3 mm thick with 13.5 mm holes, 50 mm tall, base plate with 6 mm locating dimples and closed end walls
let rows = 5; // [2, 8] Number of rows
let cols = 10; // [4, 12] Number of columns
let tube_d = 13.0; // [10.0, 17.0] Tube diameter (mm)
let height = 50.0; // [35.0, 70.0] Rack height (mm)
const pitch = 20.0;
const t = 3.0;
let lx = cols.to_float() * pitch + 10.0;
let ly = rows.to_float() * pitch + 10.0;
let r = fuse_all([
    box_from_corners([0, 0, 0], [lx, ly, t]),
    box_from_corners([0, 0, height - t], [lx, ly, height]),
    box_from_corners([0, 0, 0], [t, ly, height]),
    box_from_corners([lx - t, 0, 0], [lx, ly, height]),
]);
let holes = [];
let dimples = [];
for i in 0..cols {
    for j in 0..rows {
        let x = 5.0 + pitch * (i.to_float() + 0.5);
        let y = 5.0 + pitch * (j.to_float() + 0.5);
        holes.push(cylinder([x, y, height - t - 1.0], "Z", tube_d / 2.0 + 0.25, t + 2.0));
        dimples.push(cylinder([x, y, t - 1.5], "Z", 3.0, 2.0));
    }
}
r - compound(holes) - compound(dimples)
