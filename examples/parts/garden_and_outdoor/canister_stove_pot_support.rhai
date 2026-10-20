// Canister stove pot support: 3 serrated stainless arms 38 mm long, 10 mm tall, 2 mm thick, on a 42 mm ring with a 30 mm burner hole
let arm_length = 38.0; // [25.0, 60.0] Arm length (mm)
let arm_height = 10.0; // [6.0, 16.0] Arm height (mm)
let thickness = 2.0; // [1.2, 3.0] Arm thickness (mm)
let ring_diameter = 42.0; // [34.0, 60.0] Ring diameter (mm)
let hole_diameter = 30.0; // [20.0, 40.0] Burner hole diameter (mm)
let arms = 3; // [3, 4] Number of arms
const teeth = 6;
let r0 = ring_diameter / 2.0 - 3.0;
let hole_r = min(hole_diameter / 2.0, ring_diameter / 2.0 - 3.0);
let ring = cylinder(ring_diameter / 2.0, 2.5) - cylinder([0, 0, -1.0], "Z", hole_r, 4.5);
let pts = [[r0, 0, 0], [r0 + arm_length, 0, 0], [r0 + arm_length, 0, arm_height - 2.0]];
let tw = (arm_length - 6.0) / teeth.to_float();
for i in 0..teeth {
    let x = r0 + arm_length - i.to_float() * tw;
    pts.push([x - tw * 0.5, 0, arm_height]);
    pts.push([x - tw, 0, arm_height - 1.5]);
}
pts.push([r0, 0, arm_height + 4.0]);
let arm = polygon(pts).to_face().extrude([0, thickness, 0]).translate([0, -thickness / 2.0, 0]);
let parts = [ring];
for i in 0..arms {
    parts.push(arm.rotate_z(i.to_float() * 360.0 / arms.to_float()));
}
fuse_all(parts)
