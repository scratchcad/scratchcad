// M5 flat-head rivet nut (rivnut): 7 mm body, 10 mm flange 1 mm thick, 13.5 mm long, knurled body
let body_d = 7.0; // [5.0, 13.0] Body diameter (mm)
let flange_d = 10.0; // [7.0, 20.0] Flange diameter (mm)
let flange_t = 1.0; // [0.6, 2.0] Flange thickness (mm)
let length = 13.5; // [8.0, 25.0] Overall length (mm)
let thread_d = 4.2; // [2.5, 7.7] Thread minor diameter (mm)
let body = cylinder([0, 0, -length + flange_t], "Z", body_d / 2.0, length - flange_t + 0.01) + cylinder(flange_d / 2.0, flange_t);
let knurl = [];
for i in 0..12 { knurl.push(box_centered(0.6, 0.6, length * 0.4).rotate_z(45).translate([body_d / 2.0, 0, -length * 0.3]).rotate_z(i * 30)); }
(body - fuse_all(knurl)) - cylinder([0, 0, -length], "Z", thread_d / 2.0, length + 2.0) - cylinder([0, 0, -length * 0.45], "Z", body_d / 2.0 - 0.7, length * 0.45 + 2.0)
