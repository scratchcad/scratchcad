// Flat mop frame swivel fork: a 28.4 mm handle socket 35 mm long with a 22.4 mm bore for a 22 mm handle and a 4 mm cross pin hole, on a fork with two 6 mm cheeks 30 mm tall, 14 mm apart, with 6.5 mm pivot holes for the frame knuckle
let handle_d = 22.0; // [19.0, 28.0] Handle diameter (mm)
let socket_len = 35.0; // [20.0, 50.0] Socket length (mm)
let fork_gap = 14.0; // [8.0, 24.0] Fork gap (mm)
let pivot_d = 6.5; // [4.0, 10.0] Pivot hole diameter (mm)
const cheek_t = 6.0;
const cheek_h = 30.0;
let rb = handle_d / 2.0 + 0.2;
let ro = rb + 3.0;
let fw = fork_gap + 2.0 * cheek_t;
let socket = cylinder([0, 0, cheek_h - 2.0], "Z", ro, socket_len + 2.0);
let bridge = box_centered(fw, 2.0 * ro, 8.0).translate([0, 0, cheek_h - 2.0]);
let cheeks = [];
for s in [-1.0, 1.0] {
    let c = box_from_corners([s * (fork_gap / 2.0 + cheek_t / 2.0) - cheek_t / 2.0, -10.0, 0], [s * (fork_gap / 2.0 + cheek_t / 2.0) + cheek_t / 2.0, 10.0, cheek_h]);
    cheeks.push(c.fillet(9.0, c.edges("|X and <Z")));
}
let body = fuse_all([socket, bridge] + cheeks);
let cuts = [
    cylinder([0, 0, cheek_h + 2.0], "Z", rb, socket_len + 1.0),
    cylinder([0, -ro - 1.0, cheek_h + socket_len * 0.6], "Y", 2.0, 2.0 * ro + 2.0),
    cylinder([-fw, 0, 10.0], "X", pivot_d / 2.0, 2.0 * fw)
];
body - fuse_all(cuts)
