// DIN rail mount for a 50 x 30 mm PCB: 3 mm tray 8 mm larger than the board, four 6 mm standoffs 5 mm tall at the board's corner holes (2.5 mm in, 2.2 mm pilot holes for M2.5 screws), clip that hooks over the TS35 rail's 35 mm flanges
let pcb_length = 50.0; // [30.0, 100.0] Board length (mm)
let pcb_width = 30.0; // [20.0, 70.0] Board width (mm)
let standoff_h = 5.0; // [3.0, 12.0] Standoff height (mm)
let hole_inset = 2.5; // [2.0, 4.0] Hole distance from board edge (mm)
const t = 3.0;
const lip = 2.3;
let L = pcb_length + 8.0;
let W = pcb_width + 8.0;
let tray = box_centered(L, W, t).translate([0, 0, t / 2.0]);
let tray = tray.fillet(2.0, tray.edges("|Z"));
let posts = [];
let holes = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        let x = sx * (pcb_length / 2.0 - hole_inset);
        let y = sy * (pcb_width / 2.0 - hole_inset);
        posts.push(cylinder([x, y, t - 0.5], "Z", 3.0, standoff_h + 0.5));
        holes.push(cylinder([x, y, 1.0], "Z", 1.1, t + standoff_h));
    }
}
// rail runs along X under the tray; the clip spans the rail flanges in Y
let clip = face(polygon([
    [0, -19.5, -4.0 - lip], [0, -15.5, -4.0 - lip], [0, -15.5, -5.2], [0, -17.7, -5.2], [0, -17.7, -4.0],
    [0, 17.7, -4.0], [0, 17.7, -5.2], [0, 15.5, -5.2], [0, 15.5, -4.0 - lip], [0, 19.5, -4.0 - lip],
    [0, 19.5, 0.5], [0, -19.5, 0.5]])).extrude([20.0, 0, 0]).translate([-10.0, 0, 0]);
tray + fuse_all(posts) + clip - fuse_all(holes)
