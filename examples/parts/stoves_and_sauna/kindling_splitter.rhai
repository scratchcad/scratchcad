// Kindling splitter: 200 mm base disc 10 mm thick with 4 bolt holes and a 120 mm tall wedge blade 25 mm thick at the root and 1 mm at the edge
let base = 200.0; // [160.0, 260.0] Base diameter (mm)
let blade_h = 120.0; // [80.0, 160.0] Blade height (mm)
const t = 10.0;
let disc = cylinder([0, 0, 0], "Z", base / 2.0, t);
let blade = face(polygon([[-12.5, 0, t - 0.01], [12.5, 0, t - 0.01], [0.5, 0, t + blade_h], [-0.5, 0, t + blade_h]])).extrude([0, 60.0, 0]).translate([0, -30.0, 0]);
let holes = [];
for i in 0..4 { let a = (45.0 + 90.0 * i.to_float()) * PI() / 180.0; holes.push(cylinder([base * 0.4 * cos(a), base * 0.4 * sin(a), -1.0], "Z", 4.5, t + 2.0)); }
disc + blade - fuse_all(holes)
