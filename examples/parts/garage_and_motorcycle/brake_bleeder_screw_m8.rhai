// Brake caliper bleeder screw M8x1.25: 60 degree seat tip, 10 mm thread, 10 mm hex 5 mm tall, 6.5 mm barbed hose nipple 9 mm long, 2.5 mm bore with a 2 mm cross port
let thread_d = 8.0; // [6.0, 10.0] Thread diameter (mm)
let pitch = 1.25; // [0.75, 1.5] Thread pitch (mm)
let thread_length = 10.0; // [6.0, 16.0] Thread length (mm)
let hex_af = 10.0; // [8.0, 13.0] Hex across flats (mm)
let nipple_d = 6.5; // [5.0, 8.0] Nipple diameter (mm)
let bore_d = 2.5; // [1.5, 3.5] Bore (mm)
const hex_h = 5.0;
const nipple_len = 9.0;
let r_major = thread_d / 2.0;
let r_minor = r_major - 0.613 * pitch;
let tip = r_minor / (30.0 * PI() / 180.0).tan();
let prof = [[0.0, 0.0], [r_minor, tip]];
let turns = ((thread_length - 1.0) / pitch).floor().to_int();
for i in 0..turns {
    prof.push([r_major, tip + 1.0 + (i.to_float() + 0.5) * pitch]);
    prof.push([r_minor, tip + 1.0 + (i.to_float() + 1.0) * pitch]);
}
let z_hex = tip + thread_length + 1.0;
prof.push([r_minor, z_hex + 0.5]);
prof.push([0.0, z_hex + 0.5]);
let body = polygon("XZ", prof).to_face().revolve("Z", 360);
let rc = hex_af / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(pts).to_face().extrude([0, 0, hex_h]).translate([0, 0, z_hex]).chamfer(0.5, ">Z or <Z");
let zn = z_hex + hex_h;
let rn = nipple_d / 2.0;
let nprof = [[0.0, zn - 0.5], [rn, zn - 0.5], [rn, zn + 3.0], [rn + 0.4, zn + 3.0], [rn - 0.6, zn + nipple_len], [0.0, zn + nipple_len]];
let nipple = polygon("XZ", nprof).to_face().revolve("Z", 360);
let screw = fuse_all([body, hex, nipple]);
screw - cylinder([0, 0, tip + 1.5], "Z", bore_d / 2.0, zn + nipple_len) - cylinder([-thread_d, 0, tip + 2.0], "X", 1.0, thread_d * 2.0)
