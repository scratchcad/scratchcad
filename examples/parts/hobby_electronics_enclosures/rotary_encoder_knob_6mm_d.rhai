// Rotary encoder knob for EC11 6 mm D shaft (4.5 mm across the flat): 25 mm knob 16 mm tall, 30 grip ridges, 28 mm skirt 2 mm, D bore 12 mm deep, pointer groove on top
let diameter = 25.0; // [15.0, 40.0] Knob diameter (mm)
let height = 16.0; // [10.0, 25.0] Knob height (mm)
let ridges = 30; // [12, 48] Number of grip ridges
let bore_depth = 12.0; // [8.0, 18.0] Shaft bore depth (mm)
let shaft = 6.0; // [4.0, 6.35] Shaft diameter (mm)
let flat = 4.5; // [3.0, 5.5] Across the flat (mm)
let skirt = 1.5; // [0.0, 4.0] Skirt overhang (mm)
let r = diameter / 2.0;
let body = cylinder([0, 0, 1.9], "Z", r, height - 1.9) + cylinder(r + skirt, 2.0);
let body = body.chamfer(1.0, body.edges(">Z"));
let cuts = [];
for k in 0..ridges {
    let a = k.to_float() * 360.0 / ridges.to_float();
    cuts.push(box_centered(0.9, 0.9, height).rotate_z(45.0).translate([r, 0, height / 2.0 + 3.0]).rotate_z(a));
}
let rs = shaft / 2.0 + 0.05;
let fl = min(flat, shaft - 0.3);
let d_bore = cylinder([0, 0, -1], "Z", rs, bore_depth + 1.0) & box_from_corners([-rs - 1.0, -rs - 1.0, -2], [fl - rs + 0.05, rs + 1.0, bore_depth + 1.0]);
let pointer = box_from_corners([r * 0.35, -0.6, height - 0.8], [r + 1.0, 0.6, height + 1.0]);
body - fuse_all(cuts) - d_bore - pointer
