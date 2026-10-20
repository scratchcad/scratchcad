// Glass washer wash arm end plug: push-in plug for a 16 mm bore arm tube, 25 mm long with three 0.6 mm sealing barbs, 22 mm head 4 mm thick and a 6 mm hex key socket
let bore = 16.0; // [12.0, 22.0] Arm tube bore (mm)
let length = 25.0; // [15.0, 35.0] Plug length (mm)
let head_d = 22.0; // [18.0, 30.0] Head diameter (mm)
const head_t = 4.0;
let r = bore / 2.0;
let hd = max(head_d, bore + 4.0);
let pitch = (length - 6.0) / 3.0;
let pts = [[0, 0], [r - 1.0, 0], [r, 1.0]];
for i in 0..3 {
    let z = 3.0 + i.to_float() * pitch;
    pts.push([r, z]);
    pts.push([r + 0.6, z + pitch * 0.7]);
    pts.push([r, z + pitch * 0.7]);
}
pts.push([r, length]);
pts.push([hd / 2.0, length]);
pts.push([hd / 2.0, length + head_t]);
pts.push([0, length + head_t]);
let plug = face(polygon(pts.map(|p| [p[0], 0, p[1]]))).revolve("Z", 360);
let hex = [];
for i in 0..6 {
    let a = i.to_float() * PI() / 3.0;
    hex.push([3.5 * cos(a), 3.5 * sin(a), length + head_t - 4.0]);
}
plug - face(polygon(hex)).extrude([0, 0, 5.0])
