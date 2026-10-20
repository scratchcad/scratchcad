// Shoulder pad bracket for a 15 mm rod rig: 100 x 40 mm curved-down saddle plate 5 mm thick (bent 20 degrees each side of a 40 mm flat), two 15 mm rod clamps on 60 mm centres hanging 20 mm under the flat with 1.5 mm split slots and M5 pinch holes (5.3 mm), four 4.5 mm holes to screw the foam pad on
let spacing = 60.0; // [50.0, 70.0] Rod spacing (mm)
let rod_d = 15.0; // [12.0, 19.0] Rod diameter (mm)
let bend = 20.0; // [0.0, 35.0] Wing angle (degrees)
let wing = 30.0; // [20.0, 45.0] Wing length (mm)
const t = 5.0;
const depth = 40.0;
const flat = 40.0;
let centre = box_from_corners([-flat / 2.0, -depth / 2.0, 0], [flat / 2.0, depth / 2.0, t]);
let rw = box_from_corners([0, -depth / 2.0, 0], [wing, depth / 2.0, t]).rotate([0, 0, t], "Y", bend).translate([flat / 2.0, 0, 0]);
let lw = box_from_corners([-wing, -depth / 2.0, 0], [0, depth / 2.0, t]).rotate([0, 0, t], "Y", -bend).translate([-flat / 2.0, 0, 0]);
let hinge_r = cylinder([flat / 2.0, -depth / 2.0, t], "Y", t, depth) & box_from_corners([flat / 2.0, -depth / 2.0, 0], [flat / 2.0 + t, depth / 2.0, t]);
let hinge_l = cylinder([-flat / 2.0, -depth / 2.0, t], "Y", t, depth) & box_from_corners([-flat / 2.0 - t, -depth / 2.0, 0], [-flat / 2.0, depth / 2.0, t]);
let plate = centre + rw + lw + hinge_r + hinge_l;
const zc = -20.0;
let ro = rod_d / 2.0 + 8.0;
let clamps = [];
let cuts = [];
for s in [-1.0, 1.0] {
    let x = s * spacing / 2.0;
    clamps.push(cylinder([x, -depth / 2.0, zc], "Y", ro, depth) + box_from_corners([x - ro, -depth / 2.0, zc], [x + ro, depth / 2.0, 0.5]));
    cuts.push(cylinder([x, -depth, zc], "Y", rod_d / 2.0 + 0.05, depth * 2.0));
    cuts.push(box_from_corners([x - 0.75, -depth, zc - ro - 1.0], [x + 0.75, depth, zc]));
    cuts.push(cylinder([x - ro - 1.0, 0, zc - rod_d / 2.0 - 4.0], "X", 2.65, 2.0 * ro + 2.0));
}
let holes = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        holes.push(cylinder([sx * 10.0, sy * 12.0, -1.0], "Z", 2.25, t + 2.0));
    }
}
plate + fuse_all(clamps) - fuse_all(cuts) - fuse_all(holes)
