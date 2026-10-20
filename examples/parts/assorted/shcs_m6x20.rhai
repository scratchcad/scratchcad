// ISO 4762 M6 x 20 socket head cap screw
// # Head
let head_d = 10.0; // [5.5, 16.0] Head diameter (mm)
let head_h = 6.0; // [5.0, 10.0] Head height (mm)
let socket = 5.0; // [2.5, 8.0] Hex socket size (mm)
let socket_depth = 3.0; // [1.5, 3.5] Socket depth (mm)
// # Shank
let diameter = 6.0; // [3.0, 10.0] Thread diameter (mm)
let length = 20.0; // [8.0, 60.0] Length under the head (mm)
let thread_pitch = 1.0; // [0.5, 1.5] Thread pitch (mm)
let tan30 = (30.0 * PI() / 180.0).tan();
let r_major = diameter / 2.0;
let depth = 0.6134 * thread_pitch;
let r_minor = r_major - depth;
fn helical(section, pitch, turns) {
    let per_turn = 12;
    let sections = [];
    for i in 0..=(turns * per_turn) {
        let t = i.to_float() / per_turn.to_float();
        sections.push(section.rotate_z(t * 360.0).translate([0, 0, t * pitch]));
    }
    loft(sections, true)
}
// head: knurl-free cylinder, top edge rounded, hex socket
let head = cylinder([0, 0, -head_h], "Z", head_d / 2.0, head_h).chamfer(0.5, "%CIRCLE and <Z").fillet(0.6, "%CIRCLE and <Z");
let hex_r = socket / sqrt(3.0);
let hex_pts = [];
for i in 0..6 { let a = (i * 60).to_float() * PI() / 180.0; hex_pts.push([hex_r * a.cos(), hex_r * a.sin()]); }
let hex = polygon(hex_pts).to_face().extrude(socket_depth + 1.0).translate([0, 0, -head_h - 1.0]);
let cone_tip = cone(hex_r, 0.01, hex_r * 0.6).translate([0, 0, -head_h + socket_depth - 0.01]);
head = head - hex - cone_tip;
// shank: core at the minor diameter, thread lofted on it (its root sunk 0.05 mm into the
// core: a root exactly on the core surface makes the fuse fail), chamfered tip
let w = 0.125 * thread_pitch / 2.0 + depth * tan30;
let section = polygon([[r_minor - 0.3, 0, -w], [r_minor - 0.05, 0, -w], [r_major, 0, -0.0625 * thread_pitch],
                       [r_major, 0, 0.0625 * thread_pitch], [r_minor - 0.05, 0, w], [r_minor - 0.3, 0, w]]);
let turns = (length / thread_pitch).to_int() + 1;
let threads = helical(section, thread_pitch, turns).translate([0, 0, -thread_pitch]);
let core = cylinder([0, 0, -0.5], "Z", r_minor, length + 0.5);
let tip = sketch("XZ").move_to(0, length).hline_to(r_minor - 0.2).line_to(r_major + 1.0, length - (r_major + 1.2 - r_minor)).vline_to(-2).hline_to(0).close().to_face().revolve("Z", 360);
let shank = (core + threads) & cylinder([0, 0, 0], "Z", r_major + 1, length) & tip;
(head + shank).rotate_x(180).translate([0, 0, length])
