// Flush wall box extension ring for 68 mm boxes: 68 mm OD, 60 mm ID, 15 mm deep, 2 screw lugs on 60 mm centres
let od = 68.0; // [64.0, 75.0] Ring OD (mm)
let id = 60.0; // [52.0, 62.0] Ring ID (mm)
let depth = 15.0; // [5.0, 30.0] Extension depth (mm)
let ring = cylinder(od / 2.0, depth) - cylinder([0, 0, -1], "Z", id / 2.0, depth + 2.0);
let lugs = [];
for s in [-1.0, 1.0] { lugs.push(cylinder([s * 30.0, 0, 0], "Z", 4.0, depth) - cylinder([s * 30.0, 0, -1], "Z", 1.75, depth + 2.0)); }
ring + fuse_all(lugs)
