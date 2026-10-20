// Drop-in T-nut for 2020 aluminium extrusion (6 mm slot): 10 mm long, 11 mm wide wings with 45 degree faces, 6 mm neck, M5 threaded hole, sloped body that turns into the slot
let length = 10.0; // [8.0, 20.0] Nut length (mm)
let wing_w = 11.0; // [9.5, 12.0] Wing width (mm)
let neck_w = 5.8; // [5.0, 6.0] Neck width (mm)
let thread_d = 5.0; // [3.0, 6.0] Thread size (mm)
const wing_h = 2.5;
const neck_h = 1.8;
let hw = wing_w / 2.0;
let nw = neck_w / 2.0;
let prof = polygon("YZ", [[-hw, 0], [hw, 0], [hw, wing_h - 1.0], [nw + 1.5, wing_h + 1.0], [nw, wing_h + 1.0], [nw, wing_h + 1.0 + neck_h], [-nw, wing_h + 1.0 + neck_h], [-nw, wing_h + 1.0], [-nw - 1.5, wing_h + 1.0], [-hw, wing_h - 1.0]]);
let n = prof.to_face().extrude([length, 0, 0]).translate([-length / 2.0, 0, 0]);
n -= box_centered(length + 2.0, wing_w + 2.0, 6.0).rotate_x(25.0).translate([0, -hw - 1.5, -2.6]);
n -= cylinder([0, 0, -1], "Z", thread_d * 0.42, 10.0);
n.chamfer(0.4, "|Y")
