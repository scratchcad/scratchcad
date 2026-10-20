// Opposed-blade volume control damper 300 x 200 mm: 100 mm deep galvanized channel frame 1.5 mm with a 20 mm flange, flat blades about 66 mm wide on 12 mm axles, linkage bar on the drive side
let width = 300.0; // [150.0, 600.0] Frame width (mm)
let height = 200.0; // [150.0, 400.0] Frame height (mm)
let blade_angle = 30.0; // [0.0, 80.0] Blade opening angle (degrees)
const depth = 100.0;
const t = 1.5;
let n = (height / 70.0).floor().to_int();
let pitch = height / n.to_float();
let frame = box_centered(width + 2.0 * t, depth, height + 2.0 * t) - box_centered(width, depth + 2.0, height);
frame += box_centered(width + 2.0 * t + 40.0, t, height + 2.0 * t + 40.0).translate([0, -depth / 2.0 + t / 2.0, 0]) - box_centered(width, depth, height);
let blades = [];
let holes = [];
for i in 0..n {
    let z = -height / 2.0 + pitch * (i.to_float() + 0.5);
    let a = if i % 2 == 0 { blade_angle } else { -blade_angle };
    let bl = box_centered(width - 4.0, 2.0, pitch - 2.0).rotate_x(a) + cylinder([-width / 2.0 - 8.0, 0, 0], "X", 6.0, width + 20.0);
    blades.push(bl.translate([0, 0, z]));
    holes.push(cylinder([-width / 2.0 - 10.0, 0, z], "X", 6.5, width + 20.0));
}
let link = box_from_corners([width / 2.0 + 6.0, -2.0, -height / 2.0 + pitch * 0.3], [width / 2.0 + 9.0, 2.0, height / 2.0 - pitch * 0.3]);
compound([frame - fuse_all(holes), fuse_all(blades + [link])])
