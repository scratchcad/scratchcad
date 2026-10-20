// Letter tray stacking riser: corner post 60 mm tall that clips over a 3 mm tray wall corner, 22 mm L-section 4 mm thick, 6 mm locating peg on top for the tray above, 10 mm deep wall slots
let height = 60.0; // [30.0, 100.0] Riser height (mm)
let arm = 22.0; // [16.0, 32.0] L arm length (mm)
let t = 4.0; // [3.0, 6.0] Post thickness (mm)
let tray_wall = 3.0; // [1.5, 5.0] Tray wall thickness (mm)
let slot_d = 10.0; // [6.0, 16.0] Slot depth (mm)

const peg_d = 6.0;
const peg_h = 6.0;
let block = 2.0 * t + tray_wall + 0.4;
let arm_l = max(arm, block + 6.0);
// the L of the post, as a solid block in the corner, with grip slots for the tray walls at the bottom
let post = box_from_corners([0, 0, 0], [arm_l, block, height]) + box_from_corners([0, 0, 0], [block, arm_l, height]);
post = post.fillet(2.0, post.edges("|Z").filter(|e| e.center().x < 0.01 && e.center().y < 0.01));
let sd = min(slot_d, height / 2.0);
let slots = box_from_corners([t, t, -1.0], [arm_l + 1.0, t + tray_wall + 0.4, sd]) + box_from_corners([t, t, -1.0], [t + tray_wall + 0.4, arm_l + 1.0, sd]);
post = post - slots;
let pc = block / 2.0;
post + cylinder([pc, pc, height - 0.5], "Z", peg_d / 2.0, peg_h + 0.5).chamfer(0.6, ">Z")
