// Outboard steering cable transom bracket: 6 mm plate 120 x 50 mm with four 8.5 mm holes for 5/16 in transom bolts, carrying a 40 mm boss 30 mm long with a 22.4 mm bore for the 7/8 in cable tilt tube, a 1.5 mm clamp split and an M6 pinch screw hole (6.4 mm) across a 14 mm lug
let tube_d = 22.4; // [16.0, 26.0] Tilt tube bore (mm)
let plate_w = 120.0; // [90.0, 160.0] Plate width (mm)
let boss_len = 30.0; // [20.0, 45.0] Boss length (mm)
let standoff = 30.0; // [26.0, 60.0] Tube centre from transom (mm)
const plate_t = 6.0;
const plate_h = 50.0;
let rb = tube_d / 2.0 + 8.0;
let plate = box_from_corners([-plate_w / 2.0, 0, 0], [plate_w / 2.0, plate_t, plate_h]);
let plate = plate.fillet(5.0, plate.edges("|Y"));
let zc = plate_h / 2.0;
let boss = cylinder([-boss_len / 2.0, standoff, zc], "X", rb, boss_len);
let web = box_from_corners([-boss_len / 2.0, plate_t - 1.0, zc - rb * 0.8], [boss_len / 2.0, standoff, zc + rb * 0.8]);
let lug = box_from_corners([-boss_len / 2.0, standoff - 7.0, zc], [boss_len / 2.0, standoff + 7.0, zc + rb + 10.0]);
let body = fuse_all([plate, boss, web, lug]);
let cuts = [
    cylinder([-boss_len / 2.0 - 1.0, standoff, zc], "X", tube_d / 2.0, boss_len + 2.0),
    box_from_corners([-boss_len / 2.0 - 1.0, standoff - 0.75, zc], [boss_len / 2.0 + 1.0, standoff + 0.75, zc + rb + 11.0]),
    cylinder([0, standoff - 8.0, zc + rb + 4.5], "Y", 3.2, 16.0)
];
for s in [-1.0, 1.0] {
    for t in [-1.0, 1.0] {
        cuts.push(cylinder([s * (plate_w / 2.0 - 12.0), -1.0, zc + t * 15.0], "Y", 4.25, plate_t + 2.0));
    }
}
body - fuse_all(cuts)
