// DIN 914 M5 x 8 cone point set screw, 2.5 mm hex socket
let diameter = 5.0; // [3.0, 9.2] Thread diameter (mm)
let length = 8.0; // [5.6, 30.0] Length (mm)
let socket = 2.5; // [1.5, 6.0] Hex key size (mm)
let point = diameter / 2.0;
let body = sketch("XZ").move_to(0, 0).hline_to(0.2).line_to(diameter / 2.0, point).vline_to(length - 0.4)
    .line_to(diameter / 2.0 - 0.4, length).hline_to(0).close().to_face().revolve("Z", 360);
let rc = socket / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
body - polygon(pts).to_face().extrude(diameter).translate([0, 0, length - diameter * 0.6])
