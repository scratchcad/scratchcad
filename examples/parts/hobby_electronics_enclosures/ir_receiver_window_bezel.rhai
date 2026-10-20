// IR receiver (TSOP38238, 5 x 6 x 7.5 mm body, 5.6 mm lens bump) panel bezel for a 9 mm hole: 13 mm flange 1.5 mm, 6.5 mm front window, 8.9 mm snap barrel 6 mm long with a 0.4 mm snap ridge and two slits, 6.2 x 5.4 mm rear pocket for the receiver body
let panel_hole = 9.0; // [9.0, 14.0] Panel hole diameter (mm)
let flange_d = 13.0; // [11.0, 20.0] Flange diameter (mm)
let panel_t = 2.0; // [0.8, 3.0] Panel thickness (mm)
let barrel = 6.0; // [5.0, 10.0] Barrel length (mm)
let window = 6.5; // [5.0, 8.0] Window diameter (mm)
const ft = 1.5;
let rb = panel_hole / 2.0 - 0.05;
let rf = max(flange_d / 2.0, rb + 1.5);
let total = ft + barrel;
let rz = ft + panel_t + 0.1;
let pts = [[0, 0, 0], [rf - 0.4, 0, 0], [rf, 0, 0.4], [rf, 0, ft], [rb, 0, ft], [rb, 0, rz], [rb + 0.4, 0, rz + 0.3], [rb, 0, min(rz + 1.4, total - 0.2)], [rb, 0, total], [0, 0, total]];
let body = polygon(pts).to_face().revolve("Z", 360);
let win = cylinder([0, 0, -1], "Z", min(window / 2.0, rb - 1.3), ft + 2.0);
let pocket = box_from_corners([-3.1, -2.7, ft * 0.6], [3.1, 2.7, total + 1.0]);
let slits = box_centered(0.8, rb * 2.0 + 2.0, barrel).translate([0, 0, total - barrel / 2.0 + 1.0]);
body - win - pocket - slits
