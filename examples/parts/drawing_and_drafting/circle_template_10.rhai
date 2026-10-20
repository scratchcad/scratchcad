// Circle template: 10 holes 3 to 30 mm, 180 x 60 x 1.5 mm, centre-line notches on each hole
let length = 180.0; // [120.0, 250.0] Length (mm)
let width = 60.0; // [40.0, 80.0] Width (mm)
let thickness = 1.5; // [1.0, 3.0] Thickness (mm)
let plate = box(length, width, thickness);
let p = plate.fillet(6.0, plate.edges("|Z"));
let sizes = [3.0, 5.0, 8.0, 10.0, 12.0, 15.0, 18.0, 20.0, 25.0, 30.0];
let cuts = [];
let lefts = [6.0];
for d in sizes { lefts.push(lefts[-1] + d + 2.5); }
for i in 0..sizes.len() {
    let d = sizes[i];
    let x = lefts[i] + d / 2.0 + 2.5;
    let y = width / 2.0 + 5.0;
    cuts.push(cylinder([x, y, -1], "Z", d / 2.0, thickness + 2.0));
    cuts.push(box_from_corners([x - 0.3, y - d / 2.0 - 2.0, -1], [x + 0.3, y + d / 2.0 + 2.0, thickness + 2.0]));
}
p - fuse_all(cuts)
