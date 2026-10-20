// 5 x 4.5 in tri-blade FPV propeller: 127 mm diameter, 114 mm pitch, 13 mm hub 7 mm thick with a 5 mm bore, twisted cambered blades
let dia = 127.0; // [76.0, 178.0] Diameter (mm)
let pitch = 114.3; // [60.0, 160.0] Pitch (mm)
let blades = 3; // [2, 4] Blades
fn section(r, chord, pitch) {
    let angle = (pitch / (2.0 * PI() * r)).atan();
    let c = angle.cos();
    let s = angle.sin();
    let pts = [];
    for i in 0..24 {
        let a = 2.0 * PI() * i.to_float() / 24.0;
        let y = chord / 2.0 * a.cos();
        let z = 0.04 * chord * a.sin() + 0.03 * chord * (1.0 - a.cos() * a.cos());
        pts.push([r, y * c - z * s, y * s + z * c]);
    }
    wire([spline(pts, true)])
}
let R = dia / 2.0;
let secs = [];
for st in [[5.5, 9.0], [0.24 * R, 14.0], [0.47 * R, 15.0], [0.71 * R, 12.0], [0.91 * R, 8.0], [0.99 * R, 4.0]] { secs.push(section(st[0], st[1] * dia / 127.0, pitch)); }
let blade = loft(secs, true);
let prop = cylinder([0, 0, -3.5], "Z", 6.5, 7.0);
for k in 0..blades { prop += blade.rotate("Z", k.to_float() * 360.0 / blades.to_float()); }
prop - cylinder([0, 0, -5], "Z", 2.5, 10.0)
