// Broom handle thread adapter: 3/4 in-5 TPI male broom thread (19 mm, 5.08 mm pitch, 5 turns) to a 22 mm tube socket 35 mm deep, 29 mm body, 4 mm cross pin
let tube_d = 22.2; // [19.0, 28.0] Tube socket bore (mm)
let socket_depth = 35.0; // [20.0, 45.0] Socket depth (mm)
let turns = 5; // [3, 8] Thread turns
let body_d = 29.0; // [26.0, 36.0] Body diameter (mm)
const pitch = 5.08;
const major = 9.5;
const minor = 8.0;
let pts = [[0, 0, 0], [minor - 0.5, 0, 0], [minor, 0, 0.5]];
for i in 0..turns {
    let z0 = i.to_float() * pitch;
    pts.push([major, 0, z0 + 0.3 * pitch]);
    pts.push([major, 0, z0 + 0.5 * pitch]);
    pts.push([minor, 0, z0 + 0.8 * pitch]);
}
let zt = turns.to_float() * pitch + 1.0;
let top = zt + socket_depth + 4.0;
let rb = body_d / 2.0;
pts.push([minor, 0, zt]);
pts.push([rb, 0, zt]);
pts.push([rb, 0, top - 1.5]);
pts.push([rb - 1.5, 0, top]);
pts.push([0, 0, top]);
let body = polygon(pts).to_face().revolve("Z", 360);
body - cylinder([0, 0, top - socket_depth], "Z", tube_d / 2.0, socket_depth + 1.0) - cylinder([0, -rb - 1.0, top - socket_depth / 2.0], "Y", 2.0, body_d + 2.0)
