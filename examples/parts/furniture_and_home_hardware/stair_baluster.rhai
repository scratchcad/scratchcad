// Turned stair baluster: 40 mm square blocks 150 mm at the foot and 150 mm at the top, 600 mm turned vase-and-ring profile, 900 mm tall
let sq = 40.0; // [32.0, 55.0] Square size (mm)
let h = 900.0; // [700.0, 1000.0] Overall height (mm)
let s = sq / 40.0;
const z0 = 150.0;
let z1 = h - 150.0;
let L = z1 - z0;
let prof = [[0, 0, z0], [17.0 * s, 0, z0], [17.0 * s, 0, z0 + 15.0], [14.0 * s, 0, z0 + 25.0], [19.0 * s, 0, z0 + 0.08 * L], [12.0 * s, 0, z0 + 0.18 * L], [9.0 * s, 0, z0 + 0.25 * L], [14.0 * s, 0, z0 + 0.3 * L], [9.0 * s, 0, z0 + 0.35 * L], [8.0 * s, 0, z0 + 0.75 * L], [13.0 * s, 0, z0 + 0.82 * L], [9.0 * s, 0, z0 + 0.92 * L], [17.0 * s, 0, z1 - 15.0], [17.0 * s, 0, z1], [0, 0, z1]];
let turned = polygon(prof).to_face().revolve("Z", 360);
let foot = box_centered(sq, sq, z0).translate([0, 0, z0 / 2.0]).chamfer(3.0, ">Z");
let head = box_centered(sq, sq, h - z1).translate([0, 0, (z1 + h) / 2.0]).chamfer(3.0, "<Z");
fuse_all([foot, turned, head])
