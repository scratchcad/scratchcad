// Snap-on cable clip for a 15 mm rod: 10 mm wide C-ring with 2 mm walls that grips 260 degrees of the rod, with two side-by-side 6.5 mm cable cradles (also C-shaped, 2 mm walls) on the outside for power and SDI cables
let rod_d = 15.0; // [12.0, 19.0] Rod diameter (mm)
let cable_d = 6.5; // [3.0, 10.0] Cable diameter (mm)
let width = 10.0; // [6.0, 16.0] Clip width (mm)
const wall = 2.0;
let rr = rod_d / 2.0;
let rc = cable_d / 2.0 + 0.2;
let ring = cylinder([0, 0, 0], "Z", rr + wall, width) - cylinder([0, 0, -1.0], "Z", rr, width + 2.0);
let open_w = 2.0 * rr * sin(50.0 * PI() / 180.0);
let ring = ring - box_from_corners([-open_w / 2.0, -rr - wall - 1.0, -1.0], [open_w / 2.0, -rr * 0.6, width + 1.0]);
let cy = rr + wall + rc - 0.5;
let cradles = [];
for s in [-1.0, 1.0] {
    let cx = s * (rc + wall / 2.0 + 0.5);
    let c = cylinder([cx, cy, 0], "Z", rc + wall, width) - cylinder([cx, cy, -1.0], "Z", rc, width + 2.0)
        - box_from_corners([cx - rc * 0.7, cy, -1.0], [cx + rc * 0.7, cy + rc + wall + 1.0, width + 1.0]);
    cradles.push(c);
}
ring + fuse_all(cradles)
