// 3/4 in GHT garden hose female swivel: 26.6 mm 11.5 TPI internal thread, 32 mm knurled nut 15 mm long, 13 mm barb tail
let nut_diameter = 32.0; // [29.0, 40.0] Nut outside diameter (mm)
let nut_length = 15.0; // [12.0, 22.0] Nut length (mm)
let barb_diameter = 13.0; // [10.0, 16.0] Barb diameter (mm)
let barb_length = 22.0; // [15.0, 35.0] Barb length (mm)
const thread_major = 26.6;
const pitch = 25.4 / 11.5;
const lip = 3.0;
let r_maj = thread_major / 2.0;
let r_min = r_maj - 0.6 * pitch;
let tan30 = (30.0 * PI() / 180.0).tan();
let thread_top = nut_length - lip;
// nut
let nut = cylinder(nut_diameter / 2.0, nut_length) - cylinder([0, 0, -1], "Z", r_min, thread_top + 1.0)
    - cylinder([0, 0, thread_top - 1.0], "Z", 8.0, lip + 2.0);
let w = (r_maj - r_min + 0.1) * tan30 + pitch / 16.0;
let section = polygon([[r_min - 1.0, 0, -w], [r_min - 0.05, 0, -w], [r_maj + 0.05, 0, -pitch / 16.0],
                       [r_maj + 0.05, 0, pitch / 16.0], [r_min - 0.05, 0, w], [r_min - 1.0, 0, w]]);
let turns = (thread_top / pitch).ceiling().to_int() + 2;
let sections = [];
for i in 0..=(turns * 12) {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(t * 360.0).translate([0, 0, (t - 1.0) * pitch]));
}
let groove = loft(sections, true) & cylinder([0, 0, -2], "Z", r_maj + 2.0, thread_top + 1.5);
nut -= groove;
let ribs = [];
for i in 0..30 {
    ribs.push(box_centered(1.4, 1.6, nut_length - 2.0).translate([nut_diameter / 2.0, 0, nut_length / 2.0]).rotate_z(i.to_float() * 12.0));
}
nut = fuse_all([nut] + ribs);
// stem with washer flange and barbs
let rb = barb_diameter / 2.0;
let z0 = thread_top - 1.6;
let p = [[4.5, z0], [12.0, z0], [12.0, z0 + 1.4], [7.2, z0 + 1.4], [7.2, nut_length + 5.0]];
let z = nut_length + 5.0;
let step = barb_length / 3.0;
for i in 0..3 {
    p += [[rb - 1.0, z], [rb, z + 0.6]];
    z += step;
}
p += [[rb - 1.0, z]];
p += [[4.5, z]];
let pts = [];
for q in p { pts.push([q[0], 0, q[1]]); }
let stem = polygon(pts).to_face().revolve("Z", 360);
compound([nut, stem])
