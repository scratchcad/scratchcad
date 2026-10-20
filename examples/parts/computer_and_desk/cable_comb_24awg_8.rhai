// Cable comb for 8 sleeved 18 AWG wires: 3.4 mm slots, 3.8 mm pitch, 35 x 8 x 4 mm with snap opening
let n = 8; // [4, 24] Wire count
let wire = 3.4; // [2.5, 4.5] Wire diameter (mm)
let pitch = 3.8; // [3.0, 5.0] Pitch (mm)
let thickness = 4.0; // [3.0, 6.0] Thickness (mm)
let length = n.to_float() * pitch + 4.0;
let body = box_centered(length, 8.0, thickness);
let b = body.fillet(1.5, body.edges("|Z"));
let holes = [];
for i in 0..n {
    let x = -length / 2.0 + 2.0 + pitch / 2.0 + i.to_float() * pitch;
    holes.push(cylinder([x, 0, -thickness], "Z", wire / 2.0, thickness * 2.0) + box_centered(wire * 0.75, 5.0, thickness * 2.0).translate([x, 2.5, 0]));
}
b - fuse_all(holes)
