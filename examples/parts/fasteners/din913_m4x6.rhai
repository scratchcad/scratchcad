// DIN 913 M4 x 6 flat point set screw with 2 mm hex socket
let diameter = 4.0; // [2.0, 12.0] Thread diameter (mm)
let length = 6.0; // [3.0, 30.0] Length (mm)
let socket = 2.0; // [0.9, 6.0] Hex key size (mm)
let screw = cylinder(diameter / 2.0, length).chamfer(diameter * 0.12);
let rc = socket / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
screw - polygon(pts).to_face().extrude(length * 0.5 + 1.0).translate([0, 0, length * 0.5])
