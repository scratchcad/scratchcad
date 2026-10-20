// Hanging bird bath dish: 300 mm across, 40 mm deep, 4 mm wall, three 6 mm hanging lugs at 120 degrees
let diameter = 300.0; // [240.0, 450.0] Dish diameter (mm)
let depth = 40.0; // [25.0, 50.8] Dish depth (mm)
let wall = 4.0; // [3.0, 8.0] Wall thickness (mm)
let lug_hole = 6.0; // [3.0, 10.0] Hanging hole diameter (mm)
let R = diameter / 2.0;
let flat = R * 0.53;
let outer = sketch("XZ").move_to(0, 0).hline_to(flat).arc_to(R * 0.9, depth * 0.3, R, depth).hline_to(0).close().to_face().revolve("Z", 360);
let inner = sketch("XZ").move_to(0, wall).hline_to(flat - wall * 0.5).arc_to(R * 0.9 - wall * 0.9, depth * 0.3 + wall * 0.6, R - wall, depth)
    .vline_to(depth + 10.0).hline_to(0).close().to_face().revolve("Z", 360);
let dish = outer - inner;
let parts = [dish];
let holes = [];
for i in 0..3 {
    let a = i.to_float() * 120.0;
    parts.push(box_centered(20.0, 18.0, wall).translate([R + 6.0, 0, depth - wall / 2.0]).fillet(4.0, "|Z and >X").rotate_z(a));
    holes.push(cylinder([R + 9.0, 0, depth - wall - 5.0], "Z", lug_hole / 2.0, wall + 10.0).rotate_z(a));
}
fuse_all(parts) - compound(holes)
