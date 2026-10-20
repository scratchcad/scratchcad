// Humbucker pickup mounting ring: 92 x 46 mm outer with 4 mm corner radii, 70 x 39 mm opening, 4 mm flat (bridge rings are taller), four 2.5 mm corner screw holes on 82 x 38 mm and two 2.5 mm height-screw holes 76 mm apart
let height = 4.0; // [3.0, 9.0] Ring height (mm)
let opening_l = 70.0; // [69.0, 72.0] Opening length (mm)
const outer_l = 92.0;
const outer_w = 46.0;
let r = box_centered(outer_l, outer_w, height).translate([0, 0, height / 2.0]);
let r = r.fillet(4.0, r.edges("|Z"));
let cuts = [box_centered(opening_l, 39.0, height + 2.0).translate([0, 0, height / 2.0])];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { cuts.push(cylinder([sx * 41.0, sy * 19.0, -1.0], "Z", 1.25, height + 2.0)); } }
cuts.push(cylinder([-38.0, 0, -1.0], "Z", 1.25, height + 2.0));
cuts.push(cylinder([38.0, 0, -1.0], "Z", 1.25, height + 2.0));
r - fuse_all(cuts)
