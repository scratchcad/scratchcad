// Programmable thermostat wall sub-base: 90 x 90 mm, 8 mm deep, 6 mm corner radius, 30 x 18 mm wire opening, two 6 x 12 mm level-adjust screw slots 60 mm apart, row of six terminal screw bosses
let size = 90.0; // [70.0, 130.0] Base size (mm)
let depth = 8.0; // [5.0, 15.0] Depth (mm)
let wire_w = 30.0; // [15.0, 50.0] Wire opening width (mm)
let terminals = 6; // [2, 10] Number of terminals
const t = 2.0;
let b = box_centered(size, size, depth).translate([0, 0, depth / 2.0]).fillet(6.0, "|Z").fillet(1.5, ">Z");
b -= box_centered(size - 2.0 * t, size - 2.0 * t, depth).translate([0, 0, depth / 2.0 + t]).fillet(4.0, "|Z");
let ww = min(wire_w, size * 0.5);
b -= box_centered(ww, 18.0, 10.0).fillet(4.0, "|Z");
for s in [-1.0, 1.0] {
    b -= (box_centered(6.0, 6.0, 10.0) + cylinder([0, -3.0, -5], "Z", 3.0, 10.0) + cylinder([0, 3.0, -5], "Z", 3.0, 10.0)).rotate_z(90.0).translate([s * 30.0, 0, 0]);
}
let pitch = (size - 20.0) / terminals.to_float();
let bosses = [];
for i in 0..terminals {
    let x = -size / 2.0 + 10.0 + pitch * (i.to_float() + 0.5);
    bosses.push(box_centered(pitch * 0.8, 7.0, depth - 1.0).translate([x, -size / 4.0 - 6.0, (depth - 1.0) / 2.0 + 0.5]) - cylinder([x, -size / 4.0 - 6.0, 1.0], "Z", 1.2, depth));
}
b + fuse_all(bosses)
