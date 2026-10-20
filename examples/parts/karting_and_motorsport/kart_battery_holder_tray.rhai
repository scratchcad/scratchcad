// Kart battery holder tray for a 151 x 65 x 94 mm 12 V battery: open tray with 3 mm walls 30 mm high and a 4 mm floor, 1 mm clearance all round, two 25 x 4 mm strap slots across the floor, four M6 holes (6.4 mm) in 12 mm corner tabs and 2 mm rounded outer corners
let batt_l = 151.0; // [100.0, 200.0] Battery length (mm)
let batt_w = 65.0; // [45.0, 100.0] Battery width (mm)
let wall_h = 30.0; // [15.0, 60.0] Wall height (mm)
const wall = 3.0;
const floor_t = 4.0;
let il = batt_l + 2.0;
let iw = batt_w + 2.0;
let ol = il + 2.0 * wall;
let ow = iw + 2.0 * wall;
let outer = box_centered(ol, ow, wall_h + floor_t).translate([0, 0, (wall_h + floor_t) / 2.0]);
let outer = outer.fillet(2.0, outer.edges("|Z"));
let tabs = box_centered(ol + 24.0, ow - 20.0, floor_t).translate([0, 0, floor_t / 2.0]);
let tabs = tabs.fillet(4.0, tabs.edges("|Z"));
let body = outer + tabs;
let cuts = [box_centered(il, iw, wall_h + 1.0).translate([0, 0, floor_t + (wall_h + 1.0) / 2.0])];
for s in [-1.0, 1.0] {
    cuts.push(box_centered(4.0, 25.0, floor_t + 2.0).translate([s * il / 4.0, 0, floor_t / 2.0]));
    for t in [-1.0, 1.0] {
        cuts.push(cylinder([s * (ol / 2.0 + 6.0), t * (ow / 2.0 - 18.0), -1.0], "Z", 3.2, floor_t + 2.0));
    }
}
body - fuse_all(cuts)
