// Rod riser block for 15 mm rods on 60 mm centres: lifts the rods 30 mm, 86 x 20 mm footprint, 1/4-20 clearance hole (6.5 mm) counterbored 11 mm through the middle, split rod clamps on top with 1.5 mm slots and M4 pinch holes (4.4 mm)
let rise = 30.0; // [25.0, 60.0] Rod centre height (mm)
let spacing = 60.0; // [50.0, 70.0] Rod spacing (mm)
let depth = 20.0; // [15.0, 40.0] Block depth (mm)
const rod_d = 15.0;
let length = spacing + rod_d + 11.0;
let top = rise + rod_d / 2.0 + 8.0;
let block = box_from_corners([-length / 2.0, -depth / 2.0, 0], [length / 2.0, depth / 2.0, top]);
let block = block.fillet(3.0, block.edges("|Y and >Z"));
let pocket = box_from_corners([-spacing / 2.0 + rod_d / 2.0 + 6.0, -depth, -1.0], [spacing / 2.0 - rod_d / 2.0 - 6.0, depth, rise - rod_d / 2.0 - 4.0]);
let cuts = [pocket];
for s in [-1.0, 1.0] {
    let x = s * spacing / 2.0;
    cuts.push(cylinder([x, -depth, rise], "Y", rod_d / 2.0 + 0.05, depth * 2.0));
    cuts.push(box_from_corners([x - 0.75, -depth, rise], [x + 0.75, depth, top + 1.0]));
    cuts.push(cylinder([x - 10.0, 0, rise + rod_d / 2.0 + 4.0], "X", 2.2, 20.0));
}
let mid = rise - rod_d / 2.0 - 4.0;
let hole = cylinder([0, 0, mid - 1.0], "Z", 3.25, top);
let cbore = cylinder([0, 0, mid + 4.0], "Z", 5.5, top);
block - fuse_all(cuts) - hole - cbore
