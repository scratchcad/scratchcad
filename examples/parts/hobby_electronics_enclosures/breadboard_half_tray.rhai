// Half-size solderless breadboard tray (400 tie points, 82.5 x 55 x 8.5 mm): 1.6 mm walls 6 mm tall, 2 mm floor, 0.4 mm clearance, finger notches on the long sides, 4 x M3 countersunk floor holes, adhesive-pad recess
let board_l = 82.5; // [45.0, 165.0] Breadboard length (mm)
let board_w = 55.0; // [35.0, 65.0] Breadboard width (mm)
let wall = 1.6; // [1.2, 3.0] Wall thickness (mm)
let wall_h = 6.0; // [3.0, 9.0] Wall height (mm)
let floor_t = 2.0; // [1.5, 3.0] Floor thickness (mm)
let clearance = 0.4; // [0.2, 1.0] Fit clearance (mm)
let il = board_l + 2.0 * clearance;
let iw = board_w + 2.0 * clearance;
let ol = il + 2.0 * wall;
let ow = iw + 2.0 * wall;
let tray = box_centered(ol, ow, floor_t + wall_h).translate([0, 0, (floor_t + wall_h) / 2.0]);
let tray = tray.fillet(2.0, tray.edges("|Z"));
let tray = tray - box_centered(il, iw, wall_h * 2.0).translate([0, 0, floor_t + wall_h]);
let cuts = [];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([0, s * ow / 2.0 - 2.0, floor_t + wall_h + 9.0 - wall_h * 0.7], "Y", 9.0, 4.0));
}
let recess = box_centered(il - 16.0, iw - 16.0, 1.0).translate([0, 0, floor_t]);
for x in [-il / 2.0 + 8.0, il / 2.0 - 8.0] {
    for y in [-iw / 2.0 + 8.0, iw / 2.0 - 8.0] {
        cuts.push(cylinder([x, y, -1], "Z", 1.7, floor_t + 2.0) + cone(1.7, 3.6, 1.9).translate([x, y, floor_t - 1.6]));
    }
}
tray - recess - compound(cuts)
