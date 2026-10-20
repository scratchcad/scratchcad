// Freewheel remover for four-notch freewheels: 1 in (25.4 mm) hex shank 16 mm long, 30 mm neck 10 mm long, four 3.6 mm wide prongs 4 mm tall on a 25 to 30 mm ring, 12.4 mm axle bore through
let hex_af = 25.4; // [24.0, 32.0] Hex across flats (mm)
let prong_w = 3.6; // [3.0, 4.5] Prong width (mm)
let prong_h = 4.0; // [3.0, 6.0] Prong height (mm)
let neck_len = 10.0; // [6.0, 20.0] Neck length (mm)
const hex_len = 16.0;
const neck_d = 30.0;
const bore = 12.4;
let r = hex_af / sqrt(3.0);
let pts = [];
for i in 0..6 {
    let a = i.to_float() * 60.0 * PI() / 180.0;
    pts.push([r * cos(a), r * sin(a), 0.0]);
}
let hex = polygon(pts).to_face().extrude([0, 0, hex_len]);
let hex = hex & cylinder(r, hex_len).chamfer(r - hex_af / 2.0 + 0.8, "<Z");
let parts = [hex, cylinder([0, 0, hex_len - 0.5], "Z", neck_d / 2.0, neck_len + 0.5)];
let z0 = hex_len + neck_len;
for i in 0..4 {
    parts.push(box_from_corners([12.5, -prong_w / 2.0, z0 - 0.5], [neck_d / 2.0, prong_w / 2.0, z0 + prong_h]).rotate_z(i.to_float() * 90.0));
}
fuse_all(parts) - cylinder([0, 0, -1.0], "Z", bore / 2.0, z0 + prong_h + 2.0)
