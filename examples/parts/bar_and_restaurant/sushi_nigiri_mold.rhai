// Nigiri rice mold: 5 cavities 55 x 22 x 15 mm in a 160 x 80 x 20 mm block, matching push plate (two solids)
let n = 5; // [3, 8] Number of cavities
let cav_l = 55.0; // [45.0, 65.0] Cavity length (mm)
let cav_w = 22.0; // [18.0, 28.0] Cavity width (mm)
let depth = 15.0; // [10.0, 20.0] Cavity depth (mm)
let pitch = cav_w + 8.0;
let length = n.to_float() * pitch + 10.0;
let block = box_from_corners([0, 0, 0], [length, cav_l + 20.0, depth + 3.0]);
let cavs = [];
let pushers = [];
for i in 0..n {
    let x = 5.0 + 4.0 + i.to_float() * pitch;
    let c = box_from_corners([x, 10.0, -1], [x + cav_w, 10.0 + cav_l, depth + 4.0]);
    cavs.push(c.fillet(cav_w / 2.0 - 1.0, c.edges("|Z")));
    let p = box_from_corners([x + 0.5, 10.5, depth + 10.0], [x + cav_w - 0.5, 10.0 + cav_l - 0.5, depth + 22.0]);
    pushers.push(p.fillet(cav_w / 2.0 - 1.5, p.edges("|Z")));
}
let plate = box_from_corners([0, 0, depth + 22.0 - 0.01], [length, cav_l + 20.0, depth + 26.0]);
compound([block - fuse_all(cavs), fuse_all(pushers) + plate])
