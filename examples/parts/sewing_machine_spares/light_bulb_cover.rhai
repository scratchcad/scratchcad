// Sewing light bulb cover: 44 x 32 x 24 mm cover with 6 mm rounded vertical corners and 2 mm walls, open underneath, five 2.5 mm vent slots 20 mm long in the top, two side tabs 3 mm thick with 3.4 mm screw holes
let length = 44.0; // [34.0, 60.0] Cover length (mm)
let width = 32.0; // [24.0, 44.0] Cover width (mm)
let height = 24.0; // [16.0, 34.0] Cover height (mm)
let vents = 5; // [2, 7] Number of vent slots
const wall = 2.0;
const vent_w = 2.5;
const vent_l = 20.0;
let outer = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let outer = outer.fillet(6.0, outer.edges("|Z"));
let inner = box_centered(length - 2.0 * wall, width - 2.0 * wall, height).translate([0, 0, height / 2.0 - wall]);
let tabs = box_from_corners([-length / 2.0 - 8.0, -5.0, 0], [length / 2.0 + 8.0, 5.0, 3.0]);
let body = (outer + tabs) - inner;
let pitch = (length - 12.0) / vents.to_float();
let vl = min(vent_l, width - 10.0);
let cuts = [
    cylinder([-length / 2.0 - 4.0, 0, -1.0], "Z", 1.7, 5.0),
    cylinder([length / 2.0 + 4.0, 0, -1.0], "Z", 1.7, 5.0),
];
for i in 0..vents {
    let x = -length / 2.0 + 6.0 + pitch * (i.to_float() + 0.5);
    cuts.push(box_centered(vent_w, vl, 4.0 * wall).translate([x, 0, height]));
}
body - fuse_all(cuts)
