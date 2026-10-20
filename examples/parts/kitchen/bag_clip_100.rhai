// Spring bag clip: 100 mm jaws 10 mm wide, 3 mm arms with gripping teeth, a U-shaped spring loop at one end and a snap latch hook at the other
let length = 100.0; // [50.0, 160.0] Jaw length (mm)
let width = 10.0; // [6.0, 16.0] Clip width (mm)
let arm = 3.0; // [2.0, 5.0] Arm thickness (mm)
let gap = 1.0; // [0.5, 3.0] Gap between the jaws (mm)
let tooth_count = 12; // [0, 30] Teeth along each jaw
let z1 = arm + gap;
let lower = box_from_corners([0, 0, 0], [length, width, arm]);
let upper = box_from_corners([0, 0, z1], [length + 3.0, width, z1 + arm]);
// spring loop at x < 0: a half ring joining the arms
let rl = (z1 + arm) / 2.0;
let loop_ring = (cylinder([0, 0, rl], "Y", rl, width) - cylinder([0, -1, rl], "Y", rl - arm, width + 2.0)) & box_from_corners([-rl - 1.0, -1.0, -1.0], [0.01, width + 1.0, 2.0 * rl + 1.0]);
// latch: a hook on the lower arm that snaps over the upper arm's end
let hook = box_from_corners([length, 0, 0], [length + 6.0, width, arm]) + box_from_corners([length + 3.5, 0, 0], [length + 6.0, width, z1 + arm + 1.5])
    + polygon("XZ", [[length + 6.0, z1 + arm + 1.5], [length + 2.2, z1 + arm + 1.5], [length + 3.5, z1 + arm - 0.2]]).to_face().extrude([0, width, 0]);
let clip = fuse_all([lower, upper, loop_ring, hook]);
let teeth = [];
for i in 0..tooth_count {
    let x = 10.0 + i.to_float() * (length - 20.0) / (tooth_count - 1).max(1).to_float();
    teeth.push(polygon("XZ", [[x - 1.0, arm - 0.01], [x + 1.0, arm - 0.01], [x, arm + 0.6]]).to_face().extrude([0, width, 0]));
}
if tooth_count > 0 { clip = clip + compound(teeth); }
clip
