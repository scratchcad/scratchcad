// Holder for 4 standard 12.5 x 12.5 mm cuvettes: 80 x 22 x 30 mm block, 12.8 mm square pockets 25 mm deep at 18 mm pitch, 3 mm light-path slots through the pockets 15 mm above the floor, chamfered pocket mouths
let count = 4; // [1, 8] Number of cuvettes
let pocket = 12.8; // [12.6, 13.5] Pocket size (mm)
let pitch = 18.0; // [16.0, 25.0] Pocket pitch (mm)
let depth = 25.0; // [15.0, 40.0] Pocket depth (mm)
let path_h = 15.0; // [8.5, 20.0] Light path height above the pocket floor (mm)
const slot_w = 3.0;
let length = count.to_float() * pitch + 8.0;
let width = pocket + 9.0;
let height = depth + 5.0;
let ph = min(path_h, depth - 4.0);
let block = box_centered(length, width, height).translate([0, 0, height / 2.0]);
block = block.fillet(2.0, "|Z");
let cuts = [];
for i in 0..count {
    let x = (i.to_float() - (count.to_float() - 1.0) / 2.0) * pitch;
    let p = box_centered(pocket, pocket, depth + 1.0).translate([x, 0, height - depth + (depth + 1.0) / 2.0]);
    let mouth = loft([rect(plane([x, 0, height - 1.5], [0, 0, 1]), pocket, pocket), rect(plane([x, 0, height + 0.01], [0, 0, 1]), pocket + 3.0, pocket + 3.0)], true);
    cuts.push(p + mouth);
    cuts.push(box_centered(slot_w, width + 2.0, 6.0).translate([x, 0, height - depth + ph]));
}
block - fuse_all(cuts)
