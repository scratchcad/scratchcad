// Seamless follow focus gear ring, 0.8 module, 90 teeth: 72 mm pitch diameter, 73.6 mm over the teeth, 8 mm wide, 58 mm bore for the lens barrel (kept 3 mm inside the tooth roots) with a 1 mm lead-in chamfer and an M3 set screw hole (2.5 mm)
let teeth = 90; // [60, 120] Number of teeth
let bore = 58.0; // [40.0, 64.0] Lens barrel diameter (mm)
let width = 8.0; // [5.0, 14.0] Gear width (mm)
const m = 0.8;
let rp = m * teeth.to_float() / 2.0;
let ra = rp + m;
let rf = rp - 1.25 * m;
let b = min(bore, 2.0 * rf - 6.0);
let step = 360.0 / teeth.to_float();
let pts = [];
for i in 0..teeth {
    let a0 = i.to_float() * step;
    for f in [[0.0, rf], [0.18, rf], [0.33, ra], [0.67, ra], [0.82, rf]] {
        let a = (a0 + f[0] * step) * PI() / 180.0;
        pts.push([f[1] * cos(a), f[1] * sin(a), 0.0]);
    }
}
let gear = face(polygon(pts)).extrude([0, 0, width]);
let hole = cylinder([0, 0, -1.0], "Z", b / 2.0, width + 2.0);
let lead = cone(b / 2.0 + 1.0, b / 2.0, 1.0).translate([0, 0, -0.01]);
let screw = cylinder([0, 0, width / 2.0], "X", 1.25, ra + 2.0);
gear - hole - lead - screw
