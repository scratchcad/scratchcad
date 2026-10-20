// 3-fin can for BT-50: 24.9 mm sleeve 50 mm, 1 mm wall, clipped delta fins 40 mm root 20 mm tip 30 mm span 2 mm
let tube = 24.8; // [18.0, 66.0] Body tube OD (mm)
let length = 50.0; // [30.0, 100.0] Sleeve length (mm)
let root = 40.0; // [25.0, 80.0] Fin root chord (mm)
let tip = 20.0; // [5.0, 50.0] Fin tip chord (mm)
let span = 30.0; // [15.0, 60.0] Fin span (mm)
let t = 2.0; // [1.0, 4.0] Fin thickness (mm)
let r = tube / 2.0 + 0.1;
let sleeve = cylinder(r + 1.0, length) - cylinder([0, 0, -1], "Z", r, length + 2.0);
let fins = [];
for k in 0..3 {
    let f = polygon([[r + 0.5, 0, 2.0], [r + 0.5, 0, 2.0 + root], [r + 1.0 + span, 0, 2.0 + root - (root - tip) * 0.2 - 0.0], [r + 1.0 + span, 0, 2.0 + root - (root - tip) * 0.2 - tip]]).to_face().extrude([0, t, 0]).translate([0, -t / 2.0, 0]);
    fins.push(f.rotate_z(k.to_float() * 120.0));
}
sleeve + fuse_all(fins)
