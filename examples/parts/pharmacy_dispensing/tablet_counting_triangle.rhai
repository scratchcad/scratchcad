// Tablet counting triangle: equilateral tray whose pocket packs exactly 5 rows (15 tablets) of 10 mm round tablets, pocket side 10 x (4 + 1.732) mm, 6 mm deep with a 2 mm floor and 3 mm walls, and a 60 x 16 x 5 mm handle off the base edge
let tablet_d = 10.0; // [5.0, 14.0] Tablet diameter (mm)
let rows = 5; // [3, 8] Number of rows
let depth = 6.0; // [3.0, 10.0] Pocket depth (mm)
let handle_len = 60.0; // [40.0, 90.0] Handle length (mm)
const wall = 3.0;
const floor_t = 2.0;
let side = tablet_d * (rows - 1 + sqrt(3.0)) + 0.4;
let r_in = side / (2.0 * sqrt(3.0));
let tri = |R, z0, h| {
    let pts = [90.0, 210.0, 330.0].map(|a| [R * cos(a * PI() / 180.0), R * sin(a * PI() / 180.0), z0]);
    polygon(pts).to_face().extrude([0, 0, h])
};
let outer = tri.call(2.0 * (r_in + wall), 0.0, floor_t + depth);
let pocket = tri.call(2.0 * r_in, floor_t, depth + 1.0);
let handle = box_from_corners([-8.0, -r_in - wall - handle_len, 0], [8.0, -r_in - 1.0, 5.0]);
let handle = handle.fillet(5.0, handle.edges("|Z and <Y"));
(outer + handle) - pocket
