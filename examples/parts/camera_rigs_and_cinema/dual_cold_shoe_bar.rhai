// Dual cold shoe extension bar: 80 x 20 x 10 mm bar with 2 mm rounded vertical edges, two cold shoe receivers (18.6 mm wide, 2 mm tall slot under 1.5 mm rails with a 12.5 mm opening, 18 mm deep, open to each end) and a 1/4-20 clearance hole (6.5 mm) countersunk underneath in the middle
let length = 80.0; // [60.0, 140.0] Bar length (mm)
let height = 10.0; // [8.0, 14.0] Bar height (mm)
let shoe_depth = 18.0; // [15.0, 25.0] Shoe slot depth (mm)
const width = 20.0;
let bar = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let bar = bar.fillet(2.0, bar.edges("|Z"));
let sz = height - 3.5;
let cuts = [];
for s in [-1.0, 1.0] {
    let x0 = s * (length / 2.0 + 1.0);
    let x1 = s * (length / 2.0 - shoe_depth);
    cuts.push(box_from_corners([min(x0, x1), -9.3, sz], [max(x0, x1), 9.3, sz + 2.0]));
    cuts.push(box_from_corners([min(x0, x1), -6.25, sz], [max(x0, x1), 6.25, height + 1.0]));
}
cuts.push(cylinder([0, 0, -1.0], "Z", 3.25, height + 2.0));
cuts.push(cone(6.5, 3.25, 3.25).translate([0, 0, -0.01]));
bar - fuse_all(cuts)
