// ISO 7380 M4 x 10 button head socket screw: 7.6 mm head dia, 2.2 mm head height, 2.5 mm hex socket
let diameter = 4.0; // [3.0, 10.0] Thread diameter (mm)
let length = 10.0; // [5.0, 40.0] Length (mm)
let head_d = 7.6; // [5.7, 17.5] Head diameter (mm)
let head_h = 2.2; // [1.65, 5.5] Head height (mm)
let socket = 2.5; // [2.0, 6.0] Hex key size (mm)
let dome = sketch("XZ").move_to(0, 0).hline_to(head_d / 2.0).vline_to(head_h * 0.25)
    .arc_to(head_d * 0.32, head_h * 0.85, 0, head_h).close().to_face().revolve("Z", 360);
let rc = socket / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(pts).to_face().extrude(head_h).translate([0, 0, head_h * 0.45]);
dome - hex + cylinder([0, 0, -length], "Z", diameter / 2.0, length + 0.1)
