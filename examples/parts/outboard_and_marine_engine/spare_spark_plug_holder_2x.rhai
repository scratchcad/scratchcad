// Outboard spare spark plug holder for two 14 mm plugs: 68 x 30 x 24 mm block with two 14.2 mm thread pockets 20 mm deep and 21 mm hex counterbores 4 mm deep, 1.5 mm chamfered top edges, and M5 screw holes (5.3 mm) through from the front between and beside the pockets for mounting under the cowl
let plug_thread = 14.2; // [10.2, 18.2] Plug thread diameter (mm)
let pocket_depth = 20.0; // [12.0, 22.0] Pocket depth (mm)
let plugs = 2; // [1, 4] Number of plugs
const pitch = 28.0;
const height = 24.0;
let length = plugs.to_float() * pitch + 12.0;
let block = box_centered(length, 30.0, height).translate([0, 0, height / 2.0]);
let block = block.chamfer(1.5, block.edges(">Z"));
let cuts = [];
for i in 0..plugs {
    let x = (i.to_float() - (plugs.to_float() - 1.0) / 2.0) * pitch;
    cuts.push(cylinder([x, 0, height - pocket_depth], "Z", plug_thread / 2.0, pocket_depth + 1.0));
    cuts.push(cylinder([x, 0, height - 4.0], "Z", plug_thread / 2.0 + 3.5, 5.0));
}
for i in 0..(plugs + 1) {
    let x = (i.to_float() - plugs.to_float() / 2.0) * pitch;
    let xc = if i == 0 { -length / 2.0 + 5.0 } else if i == plugs { length / 2.0 - 5.0 } else { x };
    cuts.push(cylinder([xc, -16.0, 8.0], "Y", 2.65, 32.0));
}
block - fuse_all(cuts)
