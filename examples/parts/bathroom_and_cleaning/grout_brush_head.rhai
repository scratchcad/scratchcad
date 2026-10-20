// Grout cleaning brush head: 70 x 14 x 10 mm narrow block with a pointed tip, 2 rows of 3 mm tufts at 5 mm pitch, 8 mm handle socket angled 20 degrees
let length = 70.0; // [50.0, 100.0] Head length (mm)
let width = 14.0; // [10.0, 20.0] Head width (mm)
let t = 10.0; // [7.0, 14.0] Head thickness (mm)
let pitch = 5.0; // [4.0, 8.0] Tuft pitch (mm)
let socket_d = 8.0; // [6.0, 12.0] Handle socket bore (mm)
let angle = 20.0; // [0.0, 35.0] Handle angle (degrees)
let w = width / 2.0;
let head = polygon([[0, -w, 0], [length - 12.0, -w, 0], [length, 0, 0], [length - 12.0, w, 0], [0, w, 0]]).to_face().extrude([0, 0, t]);
let h = head.fillet(2.0, head.edges("|Z"));
let tufts = [];
let n = ((length - 14.0) / pitch).floor().to_int();
for i in 0..n { for y in [-w * 0.45, w * 0.45] {
    tufts.push(cylinder([6.0 + i.to_float() * pitch, y, -1], "Z", 1.5, 7.0));
} }
let sr = socket_d / 2.0 + 3.0;
let zs = t * 0.5 + 2.0;
let socket = cylinder([-30.0, 0, zs], "X", sr, 34.0).rotate([0, 0, zs], "Y", angle);
let bore = cylinder([-31.0, 0, zs], "X", socket_d / 2.0, 25.0).rotate([0, 0, zs], "Y", angle);
h + socket - bore - fuse_all(tufts)
