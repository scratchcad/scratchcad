// Staunton chess queen: 36 mm base 85 mm tall, flared crown with eight ball points and a centre finial
let h = 85.0; // [60.0, 110.0] Height (mm)
let s = h / 85.0;
let q = sketch("XZ").move_to(0, 0).line_to(18.0 * s, 0).line_to(18.0 * s, 4.0 * s).arc_to(17.0 * s, 8.0 * s, 12.0 * s, 9.0 * s).line_to(6.5 * s, 52.0 * s).line_to(11.0 * s, 55.0 * s).line_to(11.0 * s, 57.0 * s).line_to(7.0 * s, 58.0 * s).line_to(12.0 * s, 74.0 * s).line_to(6.0 * s, 76.0 * s).line_to(0, 76.0 * s).close().to_face().revolve("Z", 360);
let parts = [q, sphere([0, 0, 80.0 * s], 5.0 * s)];
for k in 0..8 { parts.push(sphere([11.0 * s, 0, 74.5 * s], 2.2 * s).rotate("Z", k.to_float() * 45.0)); }
fuse_all(parts) - cylinder([0, 0, -1.0], "Z", 15.0 * s, 1.8)
