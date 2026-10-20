// Bench holder for 4 x 50 ml conical tubes (29 mm OD): 2 x 2 block 80 x 80 x 40 mm, 29.6 mm holes 35 mm deep ending in a cone seat, 100 mm round anti-tip base 4 mm, finger grip cut-outs
let tube_d = 29.6; // [16.0, 31.0] Tube hole diameter (mm)
let pitch = 38.0; // [32.0, 50.0] Tube pitch (mm)
let height = 40.0; // [30.0, 60.0] Block height (mm)
let base_d = 100.0; // [80.0, 160.0] Base diameter (mm)
const base_t = 4.0;
let td = min(tube_d, pitch - 5.0);
let blk = pitch + td + 8.0;
let block = box_centered(blk, blk, height).translate([0, 0, height / 2.0]);
block = block.fillet(8.0, "|Z");
let base = cylinder(max(base_d / 2.0, blk * 0.72), base_t).chamfer(1.5, ">Z");
let holder = block + base;
let depth = min(35.0, height - 8.0);
let cone_h = min(td / 2.0 * 1.2, depth - 10.0);
let cuts = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        let x = sx * pitch / 2.0;
        let y = sy * pitch / 2.0;
        cuts.push(cylinder([x, y, height - depth + cone_h], "Z", td / 2.0, depth + 1.0 - cone_h) + cone(1.0, td / 2.0, cone_h).translate([x, y, height - depth]));
    }
}
holder = holder - fuse_all(cuts);
// grip cut-outs between the tubes on all four sides
let grips = [];
for k in 0..4 {
    grips.push(cylinder([blk / 2.0 - 15.0, 0, height], "X", 8.0, 20.0).rotate_z(k.to_float() * 90.0));
}
holder - fuse_all(grips)
