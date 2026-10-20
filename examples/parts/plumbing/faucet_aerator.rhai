// M22 x 1 faucet aerator: 24 mm knurled housing 17 mm tall, internal M22 thread zone, honeycomb screen of 3 mm cells
let outer_d = 24.0; // [20.0, 30.0] Housing diameter (mm)
let height = 17.0; // [10.0, 25.0] Height (mm)
let cells = 3.0; // [1.5, 5.0] Screen cell size (mm)
let body = cylinder(outer_d / 2.0, height) - cylinder([0, 0, 2.0], "Z", 11.0, height);
let knurl = [];
for i in 0..30 { knurl.push(box_centered(0.6, 0.6, height - 4.0).rotate_z(45).translate([outer_d / 2.0, 0, height / 2.0]).rotate_z(i * 12)); }
body = body - fuse_all(knurl);
let screen = [];
for ix in -3..=3 { for iy in -3..=3 {
    let x = ix.to_float() * cells * 1.15 + (iy % 2).to_float().abs() * cells * 0.575;
    let y = iy.to_float() * cells;
    if x * x + y * y < 7.5 * 7.5 { screen.push(cylinder([x, y, -1], "Z", cells * 0.4, 4.0)); }
} }
body - fuse_all(screen)
