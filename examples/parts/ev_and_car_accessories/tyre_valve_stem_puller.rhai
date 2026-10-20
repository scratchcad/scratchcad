// Snap-in tyre valve stem puller: T-handle 75 mm x 10 mm on a 12 mm shank 45 mm long, 14 mm AF hex collar, 7.6 mm bore 11 mm deep to screw onto the Schrader cap thread (0.305-32 UNEF)
let shank_len = 45.0; // [30.0, 70.0] Shank length (mm)
let shank_d = 12.0; // [11.0, 16.0] Shank diameter (mm)
let handle_len = 75.0; // [50.0, 110.0] Handle length (mm)
let handle_d = 10.0; // [8.0, 14.0] Handle diameter (mm)
let bore = 7.6; // [7.2, 8.0] Cap-thread bore (mm)

const hex_h = 10.0;
const bore_depth = 11.0;
let af = shank_d + 2.0;
let pts = [];
for i in 0..6 {
    let a = (i * 60.0 + 30.0) * PI() / 180.0;
    pts.push([af / sqrt(3.0) * cos(a), af / sqrt(3.0) * sin(a), 0]);
}
let hex = polygon(pts).to_face().extrude([0, 0, hex_h]);
hex = hex & cone(af / sqrt(3.0) - 0.4, af / sqrt(3.0) + 3.0, hex_h).translate([0, 0, 0]);
let shank = cylinder([0, 0, hex_h - 1.0], "Z", shank_d / 2.0, shank_len - hex_h + 1.0);
let top = shank_len + handle_d / 2.0 - 1.0;
let handle = cylinder([-handle_len / 2.0, 0, top], "X", handle_d / 2.0, handle_len);
handle = handle.chamfer(1.0, handle.edges("%CIRCLE"));
let boss = sphere([0, 0, top], handle_d / 2.0 + 2.0);
let tool = fuse_all([hex, shank, boss, handle]);
tool - cylinder([0, 0, -1.0], "Z", bore / 2.0, bore_depth + 1.0) - cone(bore / 2.0 + 1.0, bore / 2.0, 1.0).translate([0, 0, -0.2])
