// Hexagon socket countersunk head screw ISO 10642 M6 x 25: 90 deg head 12 mm across, 3.3 mm tall, 4 mm hex socket 2.2 mm deep, plain 6 mm shank with tip chamfer
let diameter = 6.0; // [3.0, 20.0] Nominal diameter (mm)
let length = 25.0; // [6.0, 100.0] Overall length including head (mm)
let head_diameter = 12.0; // [6.0, 40.0] Head diameter (mm)
let socket = 4.0; // [2.0, 12.0] Hex socket across flats (mm)
let r = diameter / 2.0;
let rk = max(head_diameter / 2.0, r + 1.0);
let k = rk - r;
const flat = 0.2;
let profile = polygon([[0, 0, 0], [r - 0.6, 0, 0], [r, 0, 0.6], [r, 0, length - k - flat], [rk, 0, length - flat], [rk, 0, length], [0, 0, length]]);
let screw = profile.to_face().revolve("Z", 360);
let rc = min(socket, rk) / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = i.to_float() * PI() / 3.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let depth = k * 0.66;
let recess = fuse_all([polygon(hp).to_face().extrude(depth + 1.0).translate([0, 0, length - depth]), cone(0.0, rc, rc * 0.577).translate([0, 0, length - depth - rc * 0.577 + 0.01])]);
screw - recess
