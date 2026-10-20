// Drill jig for TS35 x 7.5 DIN rail: 60 mm long block 50 mm wide 16 mm tall with a 35.5 x 7.7 mm channel underneath for the rail, two 5.2 mm drill guide holes on a 25 mm pitch down the rail centreline, and a 3 mm end stop lip
let pitch = 25.0; // [12.5, 30.0] Hole pitch (mm)
let hole_d = 5.2; // [3.3, 6.6] Drill size (mm)
let length = 60.0; // [50.0, 90.0] Jig length (mm)
const width = 50.0;
const height = 16.0;
let block = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, height]);
let block = block.fillet(2.0, block.edges("|Z"));
let channel = box_from_corners([3.0, -17.75, -1.0], [length + 1.0, 17.75, 7.7]);
let x0 = 3.0 + 10.0;
let holes = [];
for k in 0..2 {
    holes.push(cylinder([x0 + k.to_float() * pitch, 0, -1.0], "Z", hole_d / 2.0, height + 2.0));
}
block - channel - fuse_all(holes)
