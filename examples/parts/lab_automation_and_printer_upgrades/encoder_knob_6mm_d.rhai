// Rotary encoder knob for a 6 mm D-shaft (4.5 mm across the flat): 25 mm knob 15 mm tall, 24 knurl flutes, 12 mm deep shaft socket, 1 mm skirt step at the base, 1.5 mm pointer groove on top
let knob_d = 25.0; // [14.0, 40.0] Knob diameter (mm)
let height = 15.0; // [10.0, 25.0] Knob height (mm)
let flutes = 24; // [0, 40] Number of knurl flutes
let shaft = 6.0; // [3.0, 6.4] Shaft diameter (mm)
let flat = 4.5; // [2.5, 6.0] Shaft across the flat (mm)
const socket = 12.0;
let r = knob_d / 2.0;
let knob = cylinder(r - 1.0, height).chamfer(1.0, ">Z") + cylinder(r, 2.0);
if flutes > 0 {
    let fl = [];
    let fr = min(0.8, PI() * r / flutes.to_float() * 0.3);
    for k in 0..flutes {
        let a = k.to_float() * 2.0 * PI() / flutes.to_float();
        fl.push(cylinder([(r - 1.0) * a.cos(), (r - 1.0) * a.sin(), 3.0], "Z", fr, height));
    }
    knob = knob - compound(fl);
}
let sock_depth = min(socket, height - 3.0);
let ff = min(flat, shaft - 0.5);
let d_shape = cylinder([0, 0, -1], "Z", shaft / 2.0, sock_depth + 1.0) & box_from_corners([-shaft, -shaft / 2.0 - 1.0, -2.0], [shaft, -shaft / 2.0 + ff, sock_depth + 1.0]);
let pointer = box_from_corners([-0.75, r * 0.3, height - 1.0], [0.75, r - 2.0, height + 1.0]);
knob - d_shape - pointer
