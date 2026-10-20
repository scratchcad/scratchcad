// 2-way 5.08 mm screw terminal block: 10.16 x 7.6 x 10 mm, wire entries 3.5 x 3.5 mm, M2.5 screw heads on top
let ways = 2; // [2, 12] Ways
let pitch = 5.08; // [3.5, 7.62] Pitch (mm)
let depth = 7.6; // [6.0, 10.0] Depth (mm)
let height = 10.0; // [7.0, 14.0] Height (mm)
let length = ways.to_float() * pitch;
let block = box_centered(length, depth, height).translate([0, 0, height / 2.0]);
for i in 0..ways {
    let x = -length / 2.0 + pitch / 2.0 + i.to_float() * pitch;
    block -= box_centered(3.5, depth, 3.5).translate([x, -depth / 2.0, 3.5]);
    block -= cylinder([x, 1.0, height - 3.0], "Z", 1.6, 4.0);
    block = block + (cylinder([x, 1.0, height - 3.0], "Z", 1.5, 2.5) - box_centered(0.5, 3.5, 1.0).translate([x, 1.0, height - 0.5]));
    block = block + cylinder([x, 0, -3.5], "Z", 0.5, 3.51);
}
block
