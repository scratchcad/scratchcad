// 22 mm copper pipe pressure test plug (push-in): 19.6 mm body (22 x 0.9 pipe bore 20.2 mm) 35 mm long, two O-ring grooves 2.4 mm wide 1.6 mm deep, 26 mm stop collar 4 mm, 22 mm lifting T-bar with 8 mm hole
let pipe_bore = 20.2; // [10.0, 40.0] Pipe bore (mm)
let length = 35.0; // [20.0, 60.0] Plug length (mm)
let groove_w = 2.4; // [1.8, 3.6] O-ring groove width (mm)
let groove_d = 1.6; // [1.0, 2.5] O-ring groove depth (mm)
let collar_d = 26.0; // [14.0, 48.0] Stop collar diameter (mm)
let r = pipe_bore / 2.0 - 0.3;
let rg = r - min(groove_d, r * 0.3);
let rc = max(collar_d / 2.0, r + 2.0);
const nose = 2.0;
let g1 = length * 0.35;
let g2 = length * 0.65;
let pts = [[0, 0, 0], [r - nose * 0.5, 0, 0], [r, 0, nose], [r, 0, g1], [rg, 0, g1], [rg, 0, g1 + groove_w], [r, 0, g1 + groove_w], [r, 0, g2], [rg, 0, g2], [rg, 0, g2 + groove_w], [r, 0, g2 + groove_w], [r, 0, length], [rc, 0, length], [rc, 0, length + 4.0], [0, 0, length + 4.0]];
let plug = polygon(pts).to_face().revolve("Z", 360);
let tee = box_centered(rc * 1.6, 8.0, 14.0).translate([0, 0, length + 4.0 + 7.0 - 0.5]);
let tee = tee.fillet(3.5, tee.edges("|Y and >Z"));
plug + tee - cylinder([0, -5.0, length + 4.0 + 7.0], "Y", 4.0, 10.0)
