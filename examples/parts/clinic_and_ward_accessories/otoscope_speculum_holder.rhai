// Otoscope speculum stack holder: 80 x 40 x 30 mm block with two tapered pockets for 2.5 mm and 4 mm disposable speculum stacks (12 mm open ends, 25 mm deep) and an 8 mm slot for the otoscope head between them
let length = 80.0; // [60.0, 120.0] Block length (mm)
let depth = 25.0; // [15.0, 27.0] Pocket depth (mm)
let mouth = 12.0; // [9.0, 16.0] Pocket mouth diameter (mm)
const height = 30.0;
const width = 40.0;
let b = box_from_corners([-length / 2.0, -width / 2.0, 0], [length / 2.0, width / 2.0, height]);
b = b.fillet(4.0, b.edges("|Z"));
let pockets = [];
let tips = [2.5, 4.0];
for i in 0..2 {
    let x = (i.to_float() * 2.0 - 1.0) * length / 4.0;
    let rt = tips[i] / 2.0 + 0.5;
    let slope = (mouth / 2.0 - rt) / depth;
    pockets.push(cone(rt, mouth / 2.0 + slope * 2.0, depth + 2.0).translate([x, 0, height - depth]));
}
b - compound(pockets) - box_from_corners([-4.0, -width / 2.0 - 1.0, height - 15.0], [4.0, width / 2.0 + 1.0, height + 1.0])
