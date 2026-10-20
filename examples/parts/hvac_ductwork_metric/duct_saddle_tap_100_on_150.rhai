// Saddle branch tap 100 mm on a 150 mm duct: curved saddle 2 mm thick, 150 mm long, wrapping 120 degrees of the 150 mm duct, 99 mm OD spigot 50 mm high with 1.5 mm wall, 4 x 4 mm rivet holes in the saddle corners
let main_d = 150.0; // [125.0, 315.0] Main duct diameter (mm)
let branch_d = 99.0; // [60.0, 110.0] Branch spigot diameter (mm)
let spigot_h = 50.0; // [30.0, 100.0] Spigot height above the duct (mm)
let wrap = 120.0; // [100.0, 160.0] Saddle wrap angle (degrees)
const t = 2.0;
const wall = 1.5;
let rm = main_d / 2.0;
let rb = min(branch_d, main_d * 0.75) / 2.0;
let len = 2.0 * rb + 50.0;
let half = wrap / 2.0 * PI() / 180.0;
let shell = cylinder([-len / 2.0, 0, 0], "X", rm + t, len) - cylinder([-len / 2.0 - 1.0, 0, 0], "X", rm, len + 2.0);
// keep the part of the shell inside the wrap angle (a wedge above the axis)
let span = (rm + t + 5.0) * half.sin();
let low = (rm + t + 5.0) * half.cos();
let wedge = polygon([[-len, 0, 0], [-len, span, low], [-len, span, rm + t + 10.0], [-len, -span, rm + t + 10.0], [-len, -span, low]]).to_face().extrude([2.0 * len, 0, 0]);
let saddle = shell & wedge;
let spigot = cylinder([0, 0, 0], "Z", rb, rm + spigot_h) - cylinder([-len / 2.0 - 1.0, 0, 0], "X", rm, len + 2.0);
let tap = saddle + spigot - cylinder([0, 0, 0], "Z", rb - wall, rm + spigot_h + 1.0);
let holes = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        let a = sy * half * 0.75;
        holes.push(cylinder([sx * (len / 2.0 - 8.0), 0, 0], "Z", 2.0, rm + 10.0).rotate_x(a * 180.0 / PI()));
    }
}
tap - fuse_all(holes)
