// Brake caliper guide pin bolt: 10 mm pin 50 mm long with a boot groove, M8x1.25 thread 15 mm, 12 mm hex head 7 mm with an 18 mm flange
let pin_d = 10.0; // [8.0, 14.0] Pin diameter (mm)
let pin_length = 50.0; // [30.0, 80.0] Pin length (mm)
let thread_d = 8.0; // [6.0, 12.0] Thread diameter (mm)
let pitch = 1.25; // [1.0, 1.75] Thread pitch (mm)
let thread_length = 15.0; // [8.0, 25.0] Thread length (mm)
let hex_af = 12.0; // [10.0, 17.0] Hex across flats (mm)
const head_h = 7.0;
const flange_t = 2.0;
let rc = hex_af / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let head = polygon(pts).to_face().extrude([0, 0, head_h]).chamfer(0.6, "<Z") + cylinder([0, 0, head_h], "Z", hex_af * 0.75, flange_t);
let z0 = head_h + flange_t;
let rp = max(pin_d, thread_d + 1.0) / 2.0;
let r_major = thread_d / 2.0;
let r_minor = r_major - 0.613 * pitch;
let zp = z0 + pin_length;
let prof = [[0.0, z0 - 0.5], [rp, z0 - 0.5], [rp, z0 + 3.0], [rp - 0.8, z0 + 3.5], [rp - 0.8, z0 + 5.5], [rp, z0 + 6.0], [rp, zp - 0.5], [rp - 0.5, zp], [r_minor, zp]];
let turns = ((thread_length - 1.0) / pitch).floor().to_int();
for i in 0..turns {
    prof.push([r_major, zp + (i.to_float() + 0.5) * pitch]);
    prof.push([r_minor, zp + (i.to_float() + 1.0) * pitch]);
}
prof.push([r_minor, zp + thread_length - 0.5]);
prof.push([r_minor - 0.5, zp + thread_length]);
prof.push([0.0, zp + thread_length]);
head + polygon("XZ", prof).to_face().revolve("Z", 360)
