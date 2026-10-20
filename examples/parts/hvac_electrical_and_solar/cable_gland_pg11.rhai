// PG11 nylon cable gland: 18.6 mm thread, 1.41 mm pitch, 8 mm thread length, 22 mm hex body and dome cap nut, 10 mm cable bore (5-10 mm clamping range)
let thread_d = 18.6; // [12.0, 30.0] Thread outer diameter (mm)
let thread_len = 8.0; // [5.0, 15.0] Thread length (mm)
let hex_af = 22.0; // [16.0, 36.0] Hex across flats (mm)
let bore = 10.0; // [4.0, 14.0] Cable bore (mm)
const pitch = 1.41;
let ro = thread_d / 2.0;
let ri = ro - 0.85 * pitch;
let bd = min(bore, thread_d - 6.0);
let p = [[bd / 2.0, 0, 0], [ri, 0, 0]];
let n = (thread_len / pitch).floor().to_int();
for i in 0..n {
    let z = i.to_float() * pitch;
    p += [[ro, 0, z + pitch * 0.35], [ro, 0, z + pitch * 0.5], [ri, 0, z + pitch * 0.85]];
}
p += [[ri, 0, thread_len], [bd / 2.0, 0, thread_len]];
let threads = polygon(p).to_face().revolve("Z", 360);
fn hex_prism(af, h, z0, cham) {
    let rc = af / sqrt(3.0);
    let pts = [];
    for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
    let prism = polygon(pts).to_face().extrude([0, 0, h]);
    let c = cone(rc + cham, af / 2.0 - 0.3, cham + 1.0).translate([0, 0, h - cham - 1.0]) + cylinder(rc + cham, h - cham - 1.0);
    (prism & c).translate([0, 0, z0])
}
let body = hex_prism(hex_af, 5.0, thread_len, 1.0);
let washer = cylinder([0, 0, thread_len - 0.5], "Z", hex_af / 2.0 + 0.5, 0.6);
let neck = cylinder([0, 0, thread_len + 4.9], "Z", ro - 0.5, 3.0);
let cap = hex_prism(hex_af, 9.0, thread_len + 6.0, 1.5);
let dome = sphere([0, 0, thread_len + 12.0], hex_af / 2.0 - 0.6) & box_centered(hex_af, hex_af, 8.0).translate([0, 0, thread_len + 19.0]);
let g = fuse_all([threads, body, washer, neck, cap, dome]);
g - cylinder([0, 0, -1], "Z", bd / 2.0, thread_len + 40.0)
