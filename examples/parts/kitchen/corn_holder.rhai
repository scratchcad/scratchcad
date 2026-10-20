// Corn-on-the-cob holder: 22 mm round grip 50 mm long with finger ridges, 30 mm guard disc, two 2.5 mm stainless prongs 18 mm long 12 mm apart
let grip_length = 50.0; // [35.0, 70.0] Grip length (mm)
let grip_diameter = 22.0; // [16.0, 30.0] Grip diameter (mm)
let guard_diameter = 30.0; // [22.0, 40.0] Guard diameter (mm)
let prong_length = 18.0; // [10.0, 30.0] Prong length (mm)
let prong_spacing = 12.0; // [6.0, 20.0] Prong spacing (mm)
let rg = grip_diameter / 2.0;
let grip = sketch("XZ").move_to(0, 0).hline_to(guard_diameter / 2.0).vline(3.0).line_to(rg, 5.0).vline_to(grip_length - 6.0).arc_to(rg * 0.8, grip_length - 1.0, 0, grip_length).close().to_face().revolve("Z", 360);
for i in 0..3 {
    grip -= torus(rg + 1.2, 2.0).translate([0, 0, 13.0 + i.to_float() * 11.0]);
}
let prongs = [];
for s in [-1.0, 1.0] {
    prongs.push(cylinder([s * prong_spacing / 2.0, 0, -prong_length + 1.0], "Z", 1.25, prong_length + 8.0) + cone(0.01, 1.25, 3.0).translate([s * prong_spacing / 2.0, 0, -prong_length - 2.0 + 0.01]));
}
fuse_all([grip] + prongs)
