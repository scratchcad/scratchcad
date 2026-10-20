// Plug-in jumper comb for 5.2 mm pitch terminal blocks, 10 poles: 2.5 mm thick insulated bar 6 mm tall with 1 mm rounded top edges, ten 2.2 x 0.8 mm contact blades 9 mm long, and a 1.5 mm grip ridge
let poles = 10; // [2, 20] Number of poles
let pitch = 5.2; // [3.5, 8.2] Terminal pitch (mm)
let blade_len = 9.0; // [6.0, 14.0] Contact blade length (mm)
const bar_t = 2.5;
const bar_h = 6.0;
let length = poles.to_float() * pitch;
let bar = box_from_corners([0, -bar_t / 2.0, 0], [length, bar_t / 2.0, bar_h]);
let bar = bar.fillet(0.8, bar.edges("|X and >Z"));
let ridge = box_from_corners([1.0, -bar_t / 2.0 - 0.75, bar_h - 3.0], [length - 1.0, bar_t / 2.0 + 0.75, bar_h - 1.8]);
let blades = [];
for i in 0..poles {
    let x = pitch * (i.to_float() + 0.5);
    blades.push(box_from_corners([x - 1.1, -0.4, -blade_len], [x + 1.1, 0.4, 0.5]));
}
bar + ridge + fuse_all(blades)
