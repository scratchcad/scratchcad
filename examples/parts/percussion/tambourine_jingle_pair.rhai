// Tambourine jingle pair: two 50 mm cupped discs 0.8 mm, 4 mm center hole, 2 mm cup depth (two solids, stacked)
let d = 50.0; // [35.0, 60.0] Jingle diameter (mm)
let t = 0.8; // [0.5, 1.5] Thickness (mm)
let cup = 2.0; // [1.0, 4.0] Cup depth (mm)
let rs = (d * d / 4.0 + cup * cup) / (2.0 * cup);
let j = (sphere([0, 0, rs], rs) - sphere([0, 0, rs], rs - t)) & cylinder([0, 0, -1], "Z", d / 2.0, cup + 2.0);
let jj = j - cylinder([0, 0, -2], "Z", 2.0, cup + 4.0);
compound([jj, jj.mirror([0, 0, 1]).translate([0, 0, 2.0 * cup + 1.0])])
