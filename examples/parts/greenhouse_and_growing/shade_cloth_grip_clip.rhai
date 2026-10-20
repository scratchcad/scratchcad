// Shade cloth grip clip: two-jaw clip that pinches shade netting and gives a 10 mm tie-down eyelet, 40 x 30 mm body, 8 mm thick, 2 mm cloth gap with 6 interlocking teeth and a sliding lock wedge slot
// # Body
let length = 40.0; // [30.0, 55.0] Clip length (mm)
let width = 30.0; // [22.0, 40.0] Clip width (mm)
let thickness = 8.0; // [6.0, 12.0] Clip thickness (mm)
// # Grip
let cloth_gap = 2.0; // [1.0, 4.0] Cloth gap (mm)
let teeth = 6; // [3, 10] Number of teeth
let eyelet = 10.0; // [6.0, 14.0] Eyelet diameter (mm)
let body = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, thickness]).fillet(5.0, "|Z");
let jaw = box_from_corners([-1.0, -width / 2.0 + 4.0, thickness / 2.0 - cloth_gap / 2.0], [length * 0.65, width / 2.0 - 4.0, thickness / 2.0 + cloth_gap / 2.0]);
let mouth = box_from_corners([-1.0, -width / 2.0 - 1.0, thickness / 2.0 - cloth_gap / 2.0], [length * 0.65, width / 2.0 + 1.0, thickness / 2.0 + cloth_gap / 2.0]);
let pitch = length * 0.55 / teeth.to_float();
let ts = [];
for i in 0..teeth {
    let x = 3.0 + i.to_float() * pitch;
    let zt = if i % 2 == 0 { thickness / 2.0 - cloth_gap / 2.0 - 0.01 } else { thickness / 2.0 + cloth_gap / 2.0 - 1.0 + 0.01 };
    ts.push(box_from_corners([x, -width / 2.0 + 1.0, zt], [x + pitch * 0.5, width / 2.0 - 1.0, zt + 1.0]));
}
let eye = cylinder([length - eyelet / 2.0 - 3.0, 0, -1.0], "Z", eyelet / 2.0, thickness + 2.0);
body - mouth + fuse_all(ts) - eye
