// 3-blade outboard propeller 9.9 x 12 in: 251 mm diameter, 305 mm pitch, 70 mm hub 60 mm long with a 25 mm bore and exhaust passage
let dia = 251.0; // [150.0, 400.0] Diameter (mm)
let pitch = 305.0; // [150.0, 500.0] Pitch (mm)
fn section(r, chord, pitch) {
    let angle = (pitch / (2.0 * PI() * r)).atan();
    let c = angle.cos();
    let s = angle.sin();
    let pts = [];
    for i in 0..20 {
        let a = 2.0 * PI() * i.to_float() / 20.0;
        let y = chord / 2.0 * a.cos();
        let z = 0.06 * chord * a.sin() + 0.02 * chord;
        pts.push([r, y * c - z * s, y * s + z * c]);
    }
    wire([spline(pts, true)])
}
let R = dia / 2.0;
let blade = loft([section(30.0, 70.0, pitch), section(R * 0.5, 110.0, pitch), section(R * 0.8, 105.0, pitch), section(R * 0.98, 50.0, pitch)], true);
let hub = cylinder([0, 0, -30.0], "Z", 35.0, 60.0) - cylinder([0, 0, -31.0], "Z", 26.0, 62.0);
let bore = cylinder([0, 0, -30.0], "Z", 17.0, 60.0) - cylinder([0, 0, -31.0], "Z", 12.5, 62.0);
let prop = hub + bore;
for k in 0..3 {
    prop += box_from_corners([12.0, -2.5, -30.0], [27.0, 2.5, 30.0]).rotate("Z", k.to_float() * 120.0 + 60.0);
    prop += blade.rotate("Z", k.to_float() * 120.0);
}
prop
