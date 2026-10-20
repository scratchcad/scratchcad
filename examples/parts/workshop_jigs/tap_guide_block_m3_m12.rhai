// Tapping guide block M3 to M12: 110 x 25 x 30 mm, 7 guide holes 3.1, 4.1, 5.1, 6.1, 8.1, 10.1 and 12.1 mm with 1 mm lead-in countersinks, sight notch under each hole
let length = 110.0; // [90.0, 160.0] Block length (mm)
let width = 25.0; // [20.0, 40.0] Block width (mm)
let height = 30.0; // [20.0, 50.0] Block height (mm)
let clearance = 0.1; // [0.05, 0.3] Hole clearance over the tap size (mm)
let sizes = [3.0, 4.0, 5.0, 6.0, 8.0, 10.0, 12.0];
let blk = box_from_corners([0, 0, 0], [length, width, height]);
let b = blk.chamfer(1.0);
let cuts = [];
let gap = (length - 16.0 - 48.0) / 6.0;
for i in 0..7 {
    let r = sizes[i] / 2.0 + clearance;
    let xc = 8.0 + i.to_float() * gap + sizes[i] / 2.0;
    for j in 0..i { xc += sizes[j]; }
    cuts.push(cylinder([xc, width / 2.0, -1], "Z", r, height + 2.0));
    cuts.push(cone(r, r + 1.0, 1.0).translate([xc, width / 2.0, height - 0.99]));
    cuts.push(box_from_corners([xc - 1.0, -1, -1], [xc + 1.0, width / 2.0, 3.0]));
}
b - fuse_all(cuts)
