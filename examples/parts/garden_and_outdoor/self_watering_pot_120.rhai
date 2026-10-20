// Self-watering plant pot, 120 mm: tapered pot 120 mm at the top, 90 mm at the base, 110 mm tall, 2 mm wall, wicking holes, on a 25 mm deep reservoir saucer
let top_diameter = 120.0; // [96.0, 200.0] Pot top diameter (mm)
let base_diameter = 90.0; // [60.0, 115.2] Pot base diameter (mm)
let height = 110.0; // [60.0, 200.0] Pot height (mm)
let wall = 2.0; // [1.5, 4.0] Wall thickness (mm)
let reservoir = 25.0; // [10.0, 50.0] Reservoir depth (mm)
let rt = top_diameter / 2.0;
let rb = min(base_diameter / 2.0, rt);
let z0 = reservoir - 6.0;
let pot = cone(rb, rt, height).translate([0, 0, z0]);
let k = (rt - rb) / height;
pot -= cone(rb - wall, rt - wall + k, height + 1.0).translate([0, 0, z0 + wall]);
pot += torus(rt - wall / 2.0, wall).translate([0, 0, z0 + height - 0.5]);
let holes = [];
for i in 0..6 {
    holes.push(cylinder([rb * 0.6, 0, z0 - 1.0], "Z", 3.0, wall + 2.0).rotate_z(i.to_float() * 60.0));
}
holes.push(cylinder([0, 0, z0 - 1.0], "Z", 6.0, wall + 2.0));
pot = pot - compound(holes);
let rs = rb + 8.0;
let saucer = cylinder(rs, reservoir) - cylinder([0, 0, wall], "Z", rs - wall, reservoir);
saucer += cylinder([0, 0, wall - 0.1], "Z", rb * 0.85, z0 - wall - 0.1) - cylinder([0, 0, 1.0], "Z", rb * 0.85 - wall, z0);
saucer -= box_centered(6.0, 2.0 * rs, 8.0).translate([0, 0, wall + 4.0]);
compound([pot, saucer])
