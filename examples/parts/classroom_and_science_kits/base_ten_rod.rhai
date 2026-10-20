// Base-ten rod (ten): 100 x 10 x 10 mm with 9 grooves 0.8 mm marking the ones
let unit = 10.0; // [8.0, 20.0] Unit cube size (mm)
let n = 10; // [2, 10] Units per rod
let rod = box_from_corners([0, 0, 0], [unit * n.to_float(), unit, unit]);
let grooves = [];
for i in 1..n { grooves.push(box_from_corners([i.to_float() * unit - 0.4, -1, unit - 0.6], [i.to_float() * unit + 0.4, unit + 1.0, unit + 1.0]) + box_from_corners([i.to_float() * unit - 0.4, -1, -1], [i.to_float() * unit + 0.4, 0.6, unit + 1.0])); }
rod - fuse_all(grooves)
