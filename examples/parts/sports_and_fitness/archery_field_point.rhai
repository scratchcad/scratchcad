// Glue-in archery field point for 5/16 in (7.9 mm) carbon shafts: 7.9 mm bullet head 20 mm long with a 30 degree shoulder, 6.2 mm glue shank 18 mm long with two glue grooves, 2.5 mm weight-relief bore
let head_d = 7.9; // [6.0, 9.5] Head diameter (mm)
let head_length = 20.0; // [12.0, 30.0] Head length (mm)
let shank_d = 6.2; // [4.0, 8.0] Shank diameter (mm)
let shank_length = 18.0; // [10.0, 25.0] Shank length (mm)
let relief_d = 2.5; // [0.0, 4.0] Relief bore (mm)
let rh = head_d / 2.0;
let rs = min(shank_d, head_d - 0.6) / 2.0;
let ogive = head_length * 0.5;
// tangent ogive: an arc centred level with its start, through the tip on the axis
let og_r = (rh * rh + ogive * ogive) / (2.0 * rh);
let mid_z = ogive * 0.6;
let mid_x = rh - og_r + sqrt(og_r * og_r - mid_z * mid_z);
let prof = sketch("XZ").move_to(0, 0).hline_to(rs - 0.4).line_to(rs, 0.4).vline_to(shank_length).hline_to(rh - 0.5).line_to(rh, shank_length + 0.5)
    .vline_to(shank_length + head_length - ogive).arc_to(mid_x, shank_length + head_length - ogive + mid_z, 0, shank_length + head_length).close();
let point = prof.to_face().revolve("Z", 360);
for z in [shank_length * 0.3, shank_length * 0.65] {
    point = point - (cylinder([0, 0, z], "Z", rs + 1.0, 1.0) - cylinder([0, 0, z - 1.0], "Z", rs - 0.4, 3.0));
}
if relief_d > 0.1 { point = point - cylinder([0, 0, -1.0], "Z", min(relief_d, rs) / 2.0, shank_length); }
point
