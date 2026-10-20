// Mop bucket wringer roller: 40 mm roller 120 mm long with twelve 2 mm deep, 4 mm wide water grooves along it, 2 mm chamfered ends, a 10.2 mm axle bore and 14 mm hubs 3 mm proud at each end
let roller_d = 40.0; // [25.0, 60.0] Roller diameter (mm)
let length = 120.0; // [60.0, 200.0] Roller length (mm)
let grooves = 12; // [0, 24] Number of water grooves
let axle_d = 10.2; // [6.0, 14.0] Axle bore (mm)
const hub_d = 14.0;
let r = roller_d / 2.0;
let ar = min(axle_d / 2.0, r - 5.0);
let hr = max(hub_d / 2.0, ar + 2.0);
let roller = cylinder([0, 0, 0], "Z", r, length);
let roller = roller.chamfer(2.0, roller.edges("%CIRCLE"));
let gw = min(4.0, 0.5 * 2.0 * PI() * r / max(grooves, 1).to_float());
let cuts = [];
for i in 0..grooves {
    cuts.push(box_from_corners([r - 2.0, -gw / 2.0, 4.0], [r + 1.0, gw / 2.0, length - 4.0]).rotate_z(i.to_float() * 360.0 / grooves.to_float()));
}
let body = if grooves > 0 { roller - fuse_all(cuts) } else { roller };
let body = fuse_all([body, cylinder([0, 0, -3.0], "Z", hr, 3.5), cylinder([0, 0, length - 0.5], "Z", hr, 3.5)]);
body - cylinder([0, 0, -4.0], "Z", ar, length + 8.0)
