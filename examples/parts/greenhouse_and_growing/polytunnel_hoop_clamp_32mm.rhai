// Polytunnel cross clamp: one-piece clamp joining a 32 mm hoop to a 25 mm crop bar at 90 degrees, 40 mm wide, 5 mm wall, 3 mm web between the bores, each bore split with a 2 mm slit and pinched by an M6 bolt
// # Tubes
let hoop = 32.0; // [25.0, 42.0] Hoop tube diameter (mm)
let bar = 25.0; // [19.0, 35.0] Cross bar diameter (mm)
let width = 40.0; // [30.0, 55.0] Clamp width (mm)
let wall = 5.0; // [3.0, 8.0] Wall thickness (mm)
// # Bolts
let bolt = 6.0; // [5.0, 8.0] Bolt diameter (mm)
const web = 3.0;
let zh = hoop / 2.0 + web / 2.0;
let zb = -bar / 2.0 - web / 2.0;
let rh = hoop / 2.0 + wall;
let rb = bar / 2.0 + wall;
let hoop_body = cylinder([0, -width / 2.0, zh], "Y", rh, width);
let bar_body = cylinder([-width / 2.0, 0, zb], "X", rb, width);
let core = box_from_corners([-width / 2.0, -width / 2.0, zb], [width / 2.0, width / 2.0, zh]);
let ear_h = box_from_corners([-wall - 1.0, -width / 2.0, zh + hoop / 2.0 - 2.0], [wall + 1.0, width / 2.0, zh + rh + bolt + 4.0]);
let ear_b = box_from_corners([-width / 2.0, -wall - 1.0, zb - rb - bolt - 4.0], [width / 2.0, wall + 1.0, zb - bar / 2.0 + 2.0]);
let body = fuse_all([hoop_body, bar_body, core, ear_h, ear_b]);
let bores = [cylinder([0, -width, zh], "Y", hoop / 2.0, width * 2.0), cylinder([-width, 0, zb], "X", bar / 2.0, width * 2.0)];
let slits = [box_from_corners([-1.0, -width, zh], [1.0, width, zh + rh + bolt + 5.0]), box_from_corners([-width, -1.0, zb - rb - bolt - 5.0], [width, 1.0, zb])];
let holes = [cylinder([-wall * 2.0, 0, zh + rh + bolt / 2.0 + 1.0], "X", bolt / 2.0 + 0.3, wall * 4.0), cylinder([0, -wall * 2.0, zb - rb - bolt / 2.0 - 1.0], "Y", bolt / 2.0 + 0.3, wall * 4.0)];
body - fuse_all(bores) - compound(slits) - compound(holes)
