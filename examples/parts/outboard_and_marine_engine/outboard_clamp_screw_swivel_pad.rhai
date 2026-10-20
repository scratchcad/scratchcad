// Outboard transom clamp screw swivel pad: 50 mm disc 10 mm thick with three 1 mm deep concentric grip rings on the face, 1 mm chamfer on the back edge, and a 12.5 mm ball socket 7 mm deep in the back for the clamp screw's ball end, with a 9 mm neck opening
let pad_d = 50.0; // [35.0, 70.0] Pad diameter (mm)
let thickness = 10.0; // [8.0, 16.0] Pad thickness (mm)
let ball_d = 12.5; // [10.0, 16.0] Ball end diameter (mm)
let r = pad_d / 2.0;
let pts = [[0, 0, 0]];
for i in 0..3 {
    let rr = r * (0.3 + i.to_float() * 0.22);
    pts.push([rr, 0, 0]);
    pts.push([rr, 0, 1.0]);
    pts.push([rr + 2.0, 0, 1.0]);
    pts.push([rr + 2.0, 0, 0]);
}
pts.push([r, 0, 0]);
pts.push([r, 0, thickness - 1.0]);
pts.push([r - 1.0, 0, thickness]);
pts.push([0, 0, thickness]);
let pad = face(polygon(pts)).revolve("Z", 360.0);
let zc = thickness - 7.0 + ball_d / 2.0;
let socket = sphere([0, 0, zc], ball_d / 2.0 + 0.1) + cylinder([0, 0, zc], "Z", ball_d * 0.36, thickness);
pad - socket
