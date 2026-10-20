// Glazing setting block: 100 x 28 mm packer 3 mm thick for a 28 mm double-glazed unit, with a 2 mm locating rib underneath and 5 tear-off grooves on 15 mm centres
let length = 100.0; // [60.0, 150.0] Block length (mm)
let unit = 28.0; // [20.0, 44.0] Glazing unit thickness (mm)
let t = 3.0; // [1.0, 6.0] Packer thickness (mm)
let b = box_from_corners([0, 0, 0], [length, unit, t]);
let rib = box_from_corners([0, unit / 2.0 - 1.0, -2.0], [length, unit / 2.0 + 1.0, 0.01]);
let grooves = [];
for i in 1..6 { grooves.push(box_from_corners([i.to_float() * 15.0 - 0.4, -1.0, t * 0.5], [i.to_float() * 15.0 + 0.4, unit + 1.0, t + 1.0])); }
b + rib - fuse_all(grooves)
