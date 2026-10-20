// Cassette lockring tool for Shimano/SRAM lockrings: 12 splines 2.4 mm wide on a 21 mm root to 23.4 mm over the splines, 7 mm long, 1 in (25.4 mm) hex body 14 mm long for a wrench, 12.4 mm through bore for the quick-release guide pin
let spline_od = 23.4; // [22.0, 25.0] Diameter over splines (mm)
let splines = 12; // [8, 16] Number of splines
let spline_len = 7.0; // [5.0, 10.0] Spline length (mm)
let hex_af = 25.4; // [24.0, 32.0] Hex across flats (mm)
let hex_len = 14.0; // [8.0, 25.0] Hex length (mm)
const root_d = 21.0;
const spline_w = 2.4;
const bore = 12.4;
let r = hex_af / sqrt(3.0);
let pts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    pts.push([r * cos(a), r * sin(a), 0.0]);
}
let hex = polygon(pts).to_face().extrude([0, 0, hex_len]);
let hex = hex.chamfer(1.0, hex.edges(">Z or <Z"));
let parts = [hex, cylinder([0, 0, hex_len - 0.5], "Z", root_d / 2.0, spline_len + 0.5)];
for i in 0..splines {
    let a = i.to_float() * 360.0 / splines.to_float();
    parts.push(box_from_corners([root_d / 2.0 - 0.5, -spline_w / 2.0, hex_len], [spline_od / 2.0, spline_w / 2.0, hex_len + spline_len]).rotate_z(a));
}
fuse_all(parts) - cylinder([0, 0, -1.0], "Z", bore / 2.0, hex_len + spline_len + 2.0)
