// Motorcycle front sprocket, 520 chain, 15 teeth: 15.875 mm pitch, 10.16 mm rollers, 76.3 mm pitch circle, 7 mm thick, 20 mm splined bore with 16 splines, two M6 retainer holes on 30 mm
let teeth = 15; // [11, 18] Number of teeth
let pitch = 15.875; // [12.7, 19.05] Chain pitch (mm)
let roller_d = 10.16; // [7.75, 11.91] Roller diameter (mm)
let thickness = 7.0; // [5.0, 10.0] Thickness (mm)
let bore_d = 20.0; // [15.0, 30.0] Spline bore (mm)
const splines = 16;
let n = teeth.to_float();
let pcd = pitch / (PI() / n).sin();
let rp = pcd / 2.0;
let r_tip = pitch * (0.6 + 1.0 / (PI() / n).tan()) / 2.0;
// each tooth is the lens between two arcs centred on the neighbouring rollers
const flank = 0.7;
let seats = [];
let lenses = [];
for i in 0..teeth {
    let a = i.to_float() * 2.0 * PI() / n;
    let b = (i.to_float() + 1.0) * 2.0 * PI() / n;
    seats.push(cylinder([rp * a.cos(), rp * a.sin(), -1.0], "Z", roller_d / 2.0 + 0.1, thickness + 2.0));
    lenses.push(cylinder([rp * a.cos(), rp * a.sin(), 0], "Z", flank * pitch, thickness) & cylinder([rp * b.cos(), rp * b.sin(), 0], "Z", flank * pitch, thickness));
}
let blank = fuse_all([cylinder(rp, thickness)] + lenses) & cylinder(r_tip, thickness);
let sprocket = blank - fuse_all(seats);
sprocket = sprocket.chamfer(0.6, sprocket.edges("%CIRCLE").filter(|e| e.radius() > r_tip - 0.1));
let keys = [];
for i in 0..splines { keys.push(box_centered(2.0, 2.4, thickness + 2.0).translate([bore_d / 2.0, 0, thickness / 2.0]).rotate_z(i.to_float() * 360.0 / splines.to_float())); }
sprocket = sprocket - cylinder([0, 0, -1.0], "Z", bore_d / 2.0 - 1.0, thickness + 2.0) - compound(keys);
for s in [-1.0, 1.0] { sprocket = sprocket - cylinder([s * max(15.0, bore_d / 2.0 + 5.0), 0, -1.0], "Z", 3.2, thickness + 2.0); }
sprocket
