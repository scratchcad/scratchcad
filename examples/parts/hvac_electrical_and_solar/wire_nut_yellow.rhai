// Yellow twist-on wire connector (wire nut) for 2-4 x 14-12 AWG: 15.5 mm skirt, 28 mm long tapered body with 8 grip ribs and two wing tabs, tapered 8 mm spring cavity
let skirt_d = 15.5; // [10.0, 22.0] Skirt diameter (mm)
let length = 28.0; // [18.0, 40.0] Overall length (mm)
let ribs = 8; // [0, 12] Number of grip ribs
let cavity_d = 8.0; // [5.0, 12.0] Cavity entrance diameter (mm)
let rs = skirt_d / 2.0;
let cd = min(cavity_d, skirt_d - 4.0);
let body = sketch("XZ").move_to(0, 0).hline_to(rs).vline_to(6.0).line_to(rs * 0.8, length - 6.0).arc_to(rs * 0.55, length - 0.6, 0, length).close().to_face().revolve("Z", 360);
let rib = [];
for i in 0..ribs {
    rib.push(polygon("XZ", [[rs * 0.95, 6.0], [rs + 0.8, 7.0], [rs * 0.8 + 0.6, length - 7.0], [rs * 0.75, length - 6.0]]).to_face().extrude([0, 1.2, 0]).translate([0, -0.6, 0]).rotate_z(i.to_float() * 360.0 / ribs.to_float()));
}
let wings = [];
for s in [-1.0, 1.0] {
    wings.push(polygon("XZ", [[s * rs * 0.8, 4.0], [s * (rs + 5.0), 6.0], [s * (rs + 4.0), 15.0], [s * rs * 0.8, 19.0]]).to_face().extrude([0, 2.0, 0]).translate([0, -1.0, 0]));
}
let nut = fuse_all([body] + rib + wings);
nut - cone(cd / 2.0, 1.5, length - 4.0).translate([0, 0, -0.01]) - cylinder([0, 0, -1], "Z", cd / 2.0, 3.0)
