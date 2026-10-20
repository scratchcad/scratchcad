// Outboard cowling latch hook: 4 mm thick J hook 16 mm wide, 36 mm flange with two M5 countersunk holes (5.5 mm, 10 mm heads) 18 mm apart, rising 25 mm to a hook arm that turns down 10 mm with a 6 mm throat for the latch bar
let hook_h = 25.0; // [18.0, 40.0] Hook height (mm)
let throat = 6.0; // [4.0, 10.0] Hook throat (mm)
let width = 16.0; // [12.0, 25.0] Hook width (mm)
const t = 4.0;
const base_len = 36.0;
let depth = min(10.0, hook_h - 2.0 * t - 4.0);
let profile = polygon([
    [0, 0, 0], [base_len, 0, 0], [base_len, 0, t], [t, 0, t], [t, 0, hook_h - t], [t + throat, 0, hook_h - t],
    [t + throat, 0, hook_h - t - depth], [2.0 * t + throat, 0, hook_h - t - depth], [2.0 * t + throat, 0, hook_h], [0, 0, hook_h]]);
let hook = face(profile).extrude([0, width, 0]).translate([0, -width / 2.0, 0]);
let cuts = [];
for x in [base_len - 6.0, base_len - 24.0] {
    cuts.push(cylinder([x, 0, -1.0], "Z", 2.75, t + 2.0));
    cuts.push(cone(2.75, 5.0, 2.25).translate([x, 0, t - 2.24]));
}
hook - fuse_all(cuts)
