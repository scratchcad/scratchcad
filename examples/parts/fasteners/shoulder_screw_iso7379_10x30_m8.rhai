// Hexagon socket shoulder screw ISO 7379 10 x 30, M8 thread: 10 mm h8 shoulder 30 mm long, 16 mm head 10 mm tall, 5 mm socket, 13 mm M8 thread with 7 mm undercut next to the shoulder
let shoulder_diameter = 10.0; // [5.0, 25.0] Shoulder diameter (mm)
let shoulder_length = 30.0; // [6.0, 120.0] Shoulder length (mm)
let thread_diameter = 8.0; // [3.0, 20.0] Thread diameter (mm)
let thread_length = 13.0; // [5.0, 40.0] Thread length (mm)
let head_diameter = 16.0; // [8.0, 40.0] Head diameter (mm)
let head_height = 10.0; // [4.0, 25.0] Head height (mm)
const socket = 5.0;
let rs = shoulder_diameter / 2.0;
let rt = min(thread_diameter / 2.0, rs - 0.5);
let ru = rt * 0.85;
let rk = max(head_diameter / 2.0, rs + 1.5);
let tl = thread_length;
let profile = polygon([[0, 0, 0], [rt - 0.6, 0, 0], [rt, 0, 0.6], [rt, 0, tl - 1.5], [ru, 0, tl - 1.0], [ru, 0, tl], [rs - 0.4, 0, tl], [rs, 0, tl + 0.4], [rs, 0, tl + shoulder_length], [rk, 0, tl + shoulder_length], [rk, 0, tl + shoulder_length + head_height], [0, 0, tl + shoulder_length + head_height]]);
let screw = profile.to_face().revolve("Z", 360);
screw = screw.fillet(min(0.8, head_height * 0.08), ">Z");
let rc = min(socket, rk * 1.4) / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = i.to_float() * PI() / 3.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let ztop = tl + shoulder_length + head_height;
let depth = head_height * 0.6;
screw - fuse_all([polygon(hp).to_face().extrude(depth + 1.0).translate([0, 0, ztop - depth]), cone(0.0, rc, rc * 0.577).translate([0, 0, ztop - depth - rc * 0.577 + 0.01])])
