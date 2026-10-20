// 40 mm axial fan rotor: 22 mm hub cup 10 mm tall, seven twisted 1 mm blades (45 to 28 deg), 2 mm shaft
let tip = 19.5; // [15.0, 40.0] Tip radius (mm)
let n = 7; // [5, 11] Blades
fn sec(r, c, t, deg) {
    let a = deg * PI() / 180.0;
    let pts = [];
    for p in [[-c / 2.0, -t / 2.0], [c / 2.0, -t / 2.0], [c / 2.0, t / 2.0], [-c / 2.0, t / 2.0]] {
        pts.push([r, p[0] * a.cos() - p[1] * a.sin(), 5.0 + p[0] * a.sin() + p[1] * a.cos()]);
    }
    polygon(pts)
}
let blade = loft([sec(10.0, 9.0, 1.0, 45.0), sec((10.0 + tip) / 2.0, 10.0, 1.0, 35.0), sec(tip, 10.0, 1.0, 28.0)], true);
let rotor = cylinder(11.0, 10.0) - cylinder([0, 0, -1], "Z", 9.5, 9.0);
for k in 0..n { rotor += blade.rotate("Z", k.to_float() * 360.0 / n.to_float()); }
rotor + cylinder([0, 0, -8.0], "Z", 1.0, 17.0)
