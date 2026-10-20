// Drum drain auger crank handle: 100 mm arm 22 x 10 mm, 24 mm hub with a 10 mm hex socket and M5 cross screw, 24 mm grip 70 mm tall at the end
let arm_l = 100.0; // [60.0, 150.0] Crank radius (mm)
let arm_w = 22.0; // [16.0, 30.0] Arm width (mm)
let arm_t = 10.0; // [6.0, 14.0] Arm thickness (mm)
let hex = 10.0; // [6.0, 14.0] Hex socket across flats (mm)
let grip_d = 24.0; // [18.0, 32.0] Grip diameter (mm)
let grip_l = 70.0; // [50.0, 100.0] Grip length (mm)
let arm = box_from_corners([0, -arm_w / 2.0, 0], [arm_l, arm_w / 2.0, arm_t]) + cylinder([arm_l, 0, 0], "Z", arm_w / 2.0, arm_t);
let hub_r = hex * 0.6 + 6.0;
let hub = cylinder([0, 0, -12.0], "Z", hub_r, arm_t + 12.0);
let grip = cylinder([arm_l, 0, arm_t - 0.5], "Z", grip_d / 2.0, grip_l + 0.5);
let g = grip.fillet(4.0, grip.edges(">Z"));
let rc = hex / 3.0.sqrt();
let pts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    pts.push([rc * a.cos(), rc * a.sin(), -13.0]);
}
let socket = polygon(pts).to_face().extrude([0, 0, 12.0 + arm_t - 3.0]);
arm + hub + g - socket - cylinder([0, -hub_r - 1.0, -6.0], "Y", 2.5, 2.0 * hub_r + 2.0)
