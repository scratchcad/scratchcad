// ISO 10642 M5 x 16 countersunk socket screw: 10 mm head, 90 degree countersink, 3 mm hex
let diameter = 5.0; // [3.0, 9.2] Thread diameter (mm)
let length = 16.0; // [8.0, 50.0] Overall length (mm)
let head_d = 10.0; // [6.0, 24.0] Head diameter (mm)
let socket = 3.0; // [2.0, 4.8] Hex key size (mm)
let head_h = (head_d - diameter) / 2.0;
let body = sketch("XZ").move_to(0, 0).hline_to(diameter / 2.0).vline_to(length - head_h)
    .line_to(head_d / 2.0, length).hline_to(0).close().to_face().revolve("Z", 360);
let rc = socket / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
body - polygon(pts).to_face().extrude(head_h + 1.0).translate([0, 0, length - head_h * 0.9])
