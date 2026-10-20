// Button aid handle: bulb handle 32 mm diameter x 95 mm with a 1.6 mm wire-loop socket 25 mm deep, 6 finger flutes and a 6 mm lanyard hole; one-handed dressing aid
// # Handle
let handle_d = 32.0; // [24.0, 40.0] Handle diameter (mm)
let length = 95.0; // [70.0, 120.0] Handle length (mm)
let flutes = 6; // [0, 10] Number of finger flutes
// # Wire loop
let wire = 1.6; // [1.0, 2.5] Wire diameter (mm)
let socket_depth = 25.0; // [15.0, 40.0] Wire socket depth (mm)
let r = handle_d / 2.0;
let body = sketch("XZ").move_to(0, 0).hline_to(r * 0.85).line_to(r, length * 0.25).line_to(r, length * 0.7).line_to(r * 0.55, length - 6.0).line_to(r * 0.45, length).hline_to(0).close().to_face().revolve("Z", 360);
let cuts = [];
for i in 0..flutes {
    let a = i.to_float() * 360.0 / flutes.to_float();
    cuts.push(cylinder([r + 2.5, 0, length * 0.2], "Z", 4.0, length * 0.5).rotate_z(a));
}
let part = if flutes > 0 { body - fuse_all(cuts) } else { body };
let sock = [cylinder([wire, 0, length - socket_depth], "Z", wire / 2.0 + 0.1, socket_depth + 1.0), cylinder([-wire, 0, length - socket_depth], "Z", wire / 2.0 + 0.1, socket_depth + 1.0)];
let lanyard = cylinder([0, -r - 1.0, 10.0], "Y", 3.0, handle_d + 2.0);
part - compound(sock) - lanyard
