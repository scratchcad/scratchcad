// Wall rack for a punch and chisel set: 150 x 30 x 30 mm block, 8 stepped holes 4 to 13 mm 22 mm deep, 50 mm back plate with 2 x 4.5 mm screw holes
let length = 150.0; // [100.0, 220.0] Rack length (mm)
let depth = 30.0; // [20.0, 45.0] Block depth (mm)
let height = 30.0; // [20.0, 45.0] Block height (mm)
let hole_depth = 22.0; // [10.0, 35.0] Hole depth (mm)
let blk = box_from_corners([0, 0, 0], [length, depth, height]);
let back = box_from_corners([0, depth - 0.01, -10.0], [length, depth + 5.0, height + 20.0]);
let p = blk + back;
let pitch = (length - 20.0) / 7.0;
let holes = [];
for i in 0..8 {
    let d = 4.0 + i.to_float() * 9.0 / 7.0;
    holes.push(cylinder([10.0 + i.to_float() * pitch, depth * 0.45, height - min(hole_depth, height - 3.0)], "Z", d / 2.0 + 0.3, hole_depth + 1.0));
}
let screws = [cylinder([length * 0.15, depth - 1.0, height + 10.0], "Y", 2.25, 8.0), cylinder([length * 0.85, depth - 1.0, height + 10.0], "Y", 2.25, 8.0)];
p.fillet(3.0, p.edges("|Y and >Z")) - compound(holes) - compound(screws)
