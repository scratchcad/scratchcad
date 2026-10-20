// 100 mm duct spigot plate: 99 mm OD spigot 60 mm long with 2 mm wall and a 3 mm seal groove, 140 mm square flange 4 mm thick with 4 x 5 mm screw holes in the corners
let spigot_d = 99.0; // [60.0, 200.0] Spigot outside diameter (mm)
let length = 60.0; // [30.0, 120.0] Spigot length (mm)
let wall = 2.0; // [1.2, 4.0] Wall thickness (mm)
let margin = 20.5; // [12.0, 40.0] Flange width beyond the spigot (mm)
let flange_t = 4.0; // [2.0, 8.0] Flange thickness (mm)
const hole_d = 5.0;
let r = spigot_d / 2.0;
let half = r + margin;
let flange = box_centered(2.0 * half, 2.0 * half, flange_t).translate([0, 0, flange_t / 2.0]);
flange = flange.fillet(6.0, "|Z");
let tube = cylinder([0, 0, flange_t / 2.0], "Z", r, length + flange_t / 2.0);
let body = flange + tube - cylinder([0, 0, -1], "Z", r - wall, length + flange_t + 2.0);
// seal groove near the tip, 40 % of the wall deep
let gz = flange_t + length - 15.0;
let groove = cylinder([0, 0, gz], "Z", r + 1.0, 3.0) - cylinder([0, 0, gz - 1.0], "Z", r - wall * 0.4, 5.0);
body = body - groove;
let holes = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        holes.push(cylinder([sx * (half - 7.0), sy * (half - 7.0), -1], "Z", hole_d / 2.0, flange_t + 2.0));
    }
}
body - compound(holes)
