// Marine engine oil dipstick tube cap for a 12 mm tube: 10 mm plug 18 mm long with two 1.5 mm O-ring grooves, 16 mm collar 4 mm thick, and a 30 x 14 x 5 mm flat finger tab on top with 3 mm rounded corners and a 4 mm hole for the dipstick ring
let tube_id = 10.0; // [6.0, 16.0] Tube inside diameter (mm)
let plug_len = 18.0; // [10.0, 30.0] Plug length (mm)
let tab_w = 30.0; // [20.0, 40.0] Finger tab width (mm)
const collar_t = 4.0;
let r = tube_id / 2.0 - 0.1;
let rc = r + 3.0;
let pts = [[0, 0, -plug_len], [r - 0.5, 0, -plug_len], [r, 0, -plug_len + 0.5]];
for z in [-plug_len * 0.65, -plug_len * 0.3] {
    pts.push([r, 0, z - 0.75]);
    pts.push([r - 1.2, 0, z - 0.75]);
    pts.push([r - 1.2, 0, z + 0.75]);
    pts.push([r, 0, z + 0.75]);
}
pts.push([r, 0, 0]);
pts.push([rc, 0, 0]);
pts.push([rc, 0, collar_t]);
pts.push([0, 0, collar_t]);
let plug = face(polygon(pts)).revolve("Z", 360.0);
let tab = box_from_corners([-tab_w / 2.0, -2.5, collar_t - 0.5], [tab_w / 2.0, 2.5, collar_t + 14.0]);
let tab = tab.fillet(3.0, tab.edges("|Y and >Z"));
(plug + tab) - cylinder([tab_w / 2.0 - 6.0, -5.0, collar_t + 8.0], "Y", 2.0, 10.0)
