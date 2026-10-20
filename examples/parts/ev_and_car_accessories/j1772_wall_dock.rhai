// SAE J1772 connector wall dock: 47.5 mm socket 32 mm deep in a 60 mm boss, latch catch ridge 3 mm high on top for the plug's latch hook, 75 x 130 x 5 mm wall plate with 3 screw holes, drain slot
let bore = 47.5; // [45.0, 52.0] Socket bore (mm)
let depth = 32.0; // [24.0, 45.0] Socket depth (mm)
let boss_d = 60.0; // [56.0, 70.0] Boss diameter (mm)
let catch_h = 3.0; // [2.0, 5.0] Latch catch height (mm)
let catch_at = 10.0; // [6.0, 16.0] Catch set-back from the socket mouth (mm)

const plate_w = 75.0;
const plate_h = 130.0;
const plate_t = 5.0;
const zc = 70.0;
let bd = max(boss_d, bore + 6.0);
let plate = box_from_corners([-plate_w / 2.0, 0, 0], [plate_w / 2.0, plate_t, plate_h]);
plate = plate.fillet(10.0, plate.edges("|Y"));
let boss = cylinder([0, plate_t - 1.0, zc], "Y", bd / 2.0, depth + 1.0);
let gusset = box_from_corners([-3.0, plate_t - 1.0, 8.0], [3.0, plate_t + depth * 0.7, zc]);
let catch_ridge = box_from_corners([-8.0, plate_t + depth - catch_at - 4.0, zc + bd / 2.0 - 1.0], [8.0, plate_t + depth - catch_at, zc + bd / 2.0 + catch_h]);
catch_ridge = catch_ridge.chamfer(min(catch_h - 0.5, 3.5), catch_ridge.edges(">Z and >Y"));
let dock = fuse_all([plate, boss, gusset, catch_ridge]);
dock = dock - cylinder([0, plate_t, zc], "Y", bore / 2.0, depth + 1.0);
dock = dock.chamfer(1.5, dock.edges("%CIRCLE and >Y"));
dock = dock - box_from_corners([-5.0, plate_t + 4.0, zc - bd / 2.0 - 1.0], [5.0, plate_t + depth - 6.0, zc - bore / 2.0 + 0.5]);
for p in [[0.0, plate_h - 10.0], [-plate_w / 2.0 + 10.0, 12.0], [plate_w / 2.0 - 10.0, 12.0]] {
    dock = dock - cylinder([p[0], -1.0, p[1]], "Y", 2.5, plate_t + 2.0) - cone(2.5, 5.2, 2.8).rotate_x(-90.0).translate([p[0], plate_t - 2.7, p[1]]);
}
dock
