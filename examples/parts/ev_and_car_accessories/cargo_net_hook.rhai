// Boot cargo net hook: screw-down J hook for 5 mm bungee net cord, 44 x 26 x 4 mm base with 2 x 4 mm countersunk holes beside the hook, 22 mm tall, 7 mm cord gap, downturned tip
let base_len = 44.0; // [36.0, 60.0] Base length (mm)
let width = 14.0; // [10.0, 18.0] Hook width (mm)
let height = 22.0; // [18.0, 32.0] Hook height (mm)
let reach = 16.0; // [12.0, 22.0] Hook reach from the post centre (mm)
let gap = 7.0; // [4.0, 9.0] Cord gap under the tip (mm)

const base_t = 4.0;
const arm_t = 6.0;
const post = 4.0;
let tip_bottom = base_t + min(gap, height - arm_t - base_t - 3.0);
let tip_x = reach - 4.0;
let profile = polygon([
    [-post, 0, 0], [reach, 0, 0], [reach, 0, base_t], [post, 0, base_t],
    [post, 0, height - arm_t], [tip_x, 0, height - arm_t], [tip_x, 0, tip_bottom], [reach, 0, tip_bottom],
    [reach, 0, height], [-post, 0, height]
]);
let hook = profile.to_face().extrude([0, width, 0]).translate([0, -width / 2.0, 0]);
hook = hook.fillet(1.0, hook.edges("|Y").filter(|e| e.center().z > 0.1));
let base = box_from_corners([-post - 6.0, -base_len / 2.0, 0], [reach, base_len / 2.0, base_t]);
base = base.fillet(5.0, base.edges("|Z"));
let part = hook + base;
for s in [-1.0, 1.0] {
    let y = s * (base_len / 2.0 - 5.5);
    part = part - cylinder([0, y, -1.0], "Z", 2.1, base_t + 2.0) - cone(2.1, 4.3, 2.3).translate([0, y, base_t - 2.1]);
}
part
