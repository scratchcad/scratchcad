// Dual pH and EC probe mount for a reservoir lid: 60 x 25 x 20 mm block with a 12.5 mm bore for a 12 mm pH probe and a 16.5 mm bore for a 16 mm EC probe, an M4 thumb screw hole (3.3 mm tapping) into each from the front, and a 4 mm flange 25 mm out each end with a 4.5 mm screw hole
let ph_bore = 12.5; // [8.0, 14.0] pH probe bore (mm)
let ec_bore = 16.5; // [12.0, 20.0] EC probe bore (mm)
let block_h = 20.0; // [12.0, 35.0] Block height (mm)
let flange_len = 25.0; // [15.0, 35.0] Flange length each side (mm)
const len = 60.0;
const depth = 25.0;
const ft = 4.0;
let block = box_centered(len, depth, block_h).translate([0, 0, block_h / 2.0]);
let block = block.fillet(2.0, block.edges("|Z"));
let flange = box_centered(len + 2.0 * flange_len, depth, ft).translate([0, 0, ft / 2.0]);
let flange = flange.fillet(4.0, flange.edges("|Z"));
let body = block + flange;
let cuts = [];
let px = -len / 4.0;
let ex = len / 4.0 - 1.0;
cuts.push(cylinder([px, 0, -1.0], "Z", ph_bore / 2.0, block_h + 2.0));
cuts.push(cylinder([ex, 0, -1.0], "Z", ec_bore / 2.0, block_h + 2.0));
for x in [px, ex] {
    cuts.push(cylinder([x, -depth, block_h / 2.0 + 1.0], "Y", 1.65, depth));
}
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * (len / 2.0 + flange_len / 2.0), 0, -1.0], "Z", 2.25, ft + 2.0));
}
body - fuse_all(cuts)
