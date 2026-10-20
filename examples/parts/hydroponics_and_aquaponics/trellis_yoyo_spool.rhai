// Tomato trellis yo-yo spool: 45 mm flanges 3 mm thick on an 18 mm drum 20 mm wide, a 6.5 mm axle hole, a 2 mm string tie hole across the drum, and 12 ratchet teeth 1.5 mm tall on the outer face of one flange
let flange_d = 45.0; // [30.0, 70.0] Flange diameter (mm)
let drum_d = 18.0; // [10.0, 30.0] Drum diameter (mm)
let drum_w = 20.0; // [10.0, 35.0] Drum width (mm)
let teeth = 12; // [6, 24] Number of ratchet teeth
const ft = 3.0;
const axle = 6.5;
let rf = flange_d / 2.0;
let rd = min(drum_d / 2.0, rf - 5.0);
let top = 2.0 * ft + drum_w;
let pts = [[axle / 2.0, 0, 0], [rf, 0, 0], [rf, 0, ft], [rd, 0, ft], [rd, 0, ft + drum_w], [rf, 0, ft + drum_w], [rf, 0, top], [axle / 2.0, 0, top]];
let spool = face(polygon(pts)).revolve("Z", 360.0);
let r0 = max(axle / 2.0 + 2.0, rd - 4.0);
let r1 = rf - 1.5;
let tw = min(4.0, 0.6 * 2.0 * PI() * r0 / teeth.to_float());
let parts = [spool];
for i in 0..teeth {
    let tooth = face(polygon([[r0, -tw / 2.0, top - 0.3], [r0, tw / 2.0, top - 0.3], [r0, tw / 2.0, top + 1.5]])).extrude([r1 - r0, 0, 0]);
    parts.push(tooth.rotate_z(i.to_float() * 360.0 / teeth.to_float()));
}
let body = fuse_all(parts);
body - cylinder([-rf, 0, ft + drum_w / 2.0], "X", 1.0, 2.0 * rf).rotate_z(90.0)
