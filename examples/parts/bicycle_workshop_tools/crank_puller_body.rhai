// Crank puller body for M22 x 1 crank threads: 22 mm thread section 14 mm long (plain cylinder), 27 mm across flats hex 12 mm long, M14 x 1.25 forcing-screw bore tapped size 12.8 mm through, 1 mm chamfers and a 1.5 mm thread lead-in chamfer
let thread_d = 22.0; // [20.0, 24.0] Crank thread diameter (mm)
let thread_len = 14.0; // [10.0, 18.0] Thread length (mm)
let hex_af = 27.0; // [26.0, 32.0] Hex across flats (mm)
let hex_len = 12.0; // [8.0, 18.0] Hex length (mm)
const bore = 12.8;
let r = hex_af / sqrt(3.0);
let pts = [];
for i in 0..6 {
    let a = i.to_float() * 60.0 * PI() / 180.0;
    pts.push([r * cos(a), r * sin(a), 0.0]);
}
let hex = polygon(pts).to_face().extrude([0, 0, hex_len]);
let hex = hex & cylinder(r, hex_len).chamfer(r - hex_af / 2.0 + 1.0, ">Z or <Z");
let nose = cylinder([0, 0, hex_len - 0.5], "Z", thread_d / 2.0, thread_len + 0.5);
let nose = nose.chamfer(1.5, nose.edges(">Z"));
(hex + nose) - cylinder([0, 0, -1.0], "Z", bore / 2.0, hex_len + thread_len + 2.0)
