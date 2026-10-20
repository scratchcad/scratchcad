// Oral syringe tip cap: 9 mm cap 11 mm tall with a closed 1.5 mm top and a bore tapering from 4.6 mm at the mouth to 4.2 mm to grip the oral tip, and 6 grip fins 1 mm thick standing 1.5 mm proud along the lower 8 mm
let cap_d = 9.0; // [7.0, 12.0] Cap diameter (mm)
let cap_h = 11.0; // [8.0, 16.0] Cap height (mm)
let tip_d = 4.6; // [3.5, 5.5] Bore at mouth (mm)
let fins = 6; // [3, 10] Number of grip fins
const top_t = 1.5;
const fin_proud = 1.5;
let ro = cap_d / 2.0;
let rm = min(tip_d / 2.0, ro - 1.0);
let depth = cap_h - top_t;
let bore = polygon([[0, 0, -1.0], [rm, 0, -1.0], [rm, 0, 0], [rm - 0.2, 0, depth], [0, 0, depth]]).to_face().revolve("Z", 360.0);
let parts = [cylinder(ro, cap_h)];
let fin_h = min(8.0, cap_h - 1.0);
for i in 0..fins {
    parts.push(box_from_corners([ro - 0.5, -0.5, 0], [ro + fin_proud, 0.5, fin_h]).rotate_z((i + 0.5) * 360.0 / fins));
}
fuse_all(parts) - bore
