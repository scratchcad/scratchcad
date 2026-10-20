// Spur gear, module 1, 20 teeth, 20 degree pressure angle
let gear_module = 1.0; // [0.5, 3.0] Module (mm)
let teeth = 20; // [8, 42] Number of teeth
let pressure_angle = 20.0; // [14.5, 25.0] Pressure angle (degrees)
let face_width = 10.0; // [3.0, 30.0] Face width (mm)
let bore = 5.0; // [2.0, 12.0] Bore (mm)
let hub_d = 12.0; // [8.0, 30.0] Hub diameter (mm)
let hub_length = 8.0; // [0.0, 20.0] Hub length (mm)
let rp = gear_module * teeth.to_float() / 2.0;
let rb = rp * (pressure_angle * PI() / 180.0).cos();
let ra = rp + gear_module;
let rf = rp - 1.25 * gear_module;
// involute point at roll angle t
fn inv(rb, t) { [rb * (t.cos() + t * t.sin()), rb * (t.sin() - t * t.cos())] }
let t_max = ((ra * ra - rb * rb).sqrt()) / rb;
let t_p = ((rp * rp - rb * rb).sqrt()) / rb;
let phi_p = t_p - t_p.atan(); // polar angle of the involute at the pitch circle
let half_tooth = PI() / (2.0 * teeth.to_float()); // half the tooth's angular thickness at the pitch circle
let rot = half_tooth + phi_p;
// one tooth: the involute on each flank, mirrored about the X axis
let flank = [];
const steps = 10;
for i in 0..=steps {
    let p = inv(rb, t_max * i.to_float() / steps.to_float());
    let a = p[1].atan(p[0]) - rot;
    let r = (p[0] * p[0] + p[1] * p[1]).sqrt();
    flank.push([r * a.cos(), r * a.sin()]);
}
let pts = [];
let root_r = max(rf, 0.1);
let a0 = flank[0][1].atan(flank[0][0]);
pts.push([root_r * a0.cos(), root_r * a0.sin()]);
for p in flank { pts.push(p); }
let upper = [];
for p in flank { upper.push([p[0], -p[1]]); }
upper.reverse();
for p in upper { pts.push(p); }
pts.push([root_r * a0.cos(), -root_r * a0.sin()]);
let tooth = polygon(pts).to_face().extrude(face_width);
let blank = cylinder(root_r + 0.01, face_width);
let all = [blank];
for i in 0..teeth { all.push(tooth.rotate_z(i.to_float() * 360.0 / teeth.to_float())); }
let gear = fuse_all(all).clean();
if hub_length > 0.0 { gear = gear + cylinder([0, 0, face_width - 0.01], "Z", hub_d / 2.0, hub_length + 0.01); }
let key = box_from_corners([-1.0, 0, -1], [1.0, bore / 2.0 + 1.0, face_width + hub_length + 1]);
gear - cylinder([0, 0, -1], "Z", bore / 2.0, face_width + hub_length + 2) - key
