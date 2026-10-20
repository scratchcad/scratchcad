// Dustpan broom-comb strip: 200 x 20 x 3 mm clip-on strip, 25 comb teeth 3 mm wide 15 mm tall, 2 snap hooks for a 2 mm dustpan lip
let length = 200.0; // [120.0, 280.0] Strip length (mm)
let teeth = 25; // [10, 40] Number of teeth
let tooth_h = 15.0; // [8.0, 25.0] Tooth height (mm)
let tooth_w = 3.0; // [2.0, 5.0] Tooth width (mm)
let t = 3.0; // [2.0, 5.0] Strip thickness (mm)
let lip = 2.0; // [1.0, 4.0] Dustpan lip thickness (mm)
let strip = box_from_corners([-length / 2.0, 0, 0], [length / 2.0, 20.0, t]);
let pitch = (length - 10.0) / (teeth - 1).to_float();
let ts = [];
for i in 0..teeth {
    let x = -(length - 10.0) / 2.0 + i.to_float() * pitch;
    ts.push(polygon([[x - tooth_w / 2.0, 14.0, t - 0.5], [x + tooth_w / 2.0, 14.0, t - 0.5], [x + tooth_w * 0.25, 14.0, t + tooth_h], [x - tooth_w * 0.25, 14.0, t + tooth_h]]).to_face().extrude([0, 4.0, 0]));
}
let hooks = [];
for x in [-length * 0.3, length * 0.3] {
    hooks.push(box_from_corners([x - 8.0, -t, -lip - t], [x + 8.0, 0.01, t]));
    hooks.push(box_from_corners([x - 8.0, -t + 0.01, -lip - t], [x + 8.0, 8.0, -lip]));
}
strip + fuse_all(ts) + fuse_all(hooks)
