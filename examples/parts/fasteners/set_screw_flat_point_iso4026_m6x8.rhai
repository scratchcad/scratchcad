// Hexagon socket set screw ISO 4026 M6 x 8, flat point: 3 mm hex socket 3 mm deep, 4 mm flat point diameter with 45 deg chamfer, chamfered top
let diameter = 6.0; // [2.0, 24.0] Nominal diameter (mm)
let length = 8.0; // [2.0, 60.0] Length (mm)
let socket = 3.0; // [0.9, 12.0] Hex socket across flats (mm)
let socket_depth = 3.0; // [0.8, 10.0] Socket depth (mm)
let point_diameter = 4.0; // [1.0, 18.0] Flat point diameter (mm)
let r = diameter / 2.0;
let rp = min(point_diameter / 2.0, r - 0.3);
let top_ch = min(r * 0.25, length * 0.2);
let profile = polygon([[0, 0, 0], [rp, 0, 0], [r, 0, r - rp], [r, 0, length - top_ch], [r - top_ch, 0, length], [0, 0, length]]);
let screw = profile.to_face().revolve("Z", 360);
let rc = min(socket, diameter * 0.7) / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = i.to_float() * PI() / 3.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let depth = min(socket_depth, length * 0.6);
screw - fuse_all([polygon(hp).to_face().extrude(depth + 1.0).translate([0, 0, length - depth]), cone(0.0, rc, rc * 0.577).translate([0, 0, length - depth - rc * 0.577 + 0.01])])
