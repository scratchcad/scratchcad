// Tilt bracket for an SG90 pan-tilt head: 2 mm U yoke 36 mm wide between arms, 25 mm arms with a micro-horn pocket (cross horn 7 mm hub) on one side and a 3 mm pivot pin on the other, camera plate 32 x 32 mm on top
let inner_w = 36.0; // [28.0, 50.0] Width between arms (mm)
let arm_h = 25.0; // [18.0, 40.0] Arm height (mm)
let plate = 32.0; // [20.0, 45.0] Camera plate size (mm)
let depth = 14.0; // [10.0, 20.0] Yoke depth (mm)
const t = 2.0;
let hw = inner_w / 2.0;
let base = box_from_corners([-hw - t, -depth / 2.0, arm_h], [hw + t, depth / 2.0, arm_h + t]);
let arms = box_from_corners([-hw - t, -depth / 2.0, 0], [-hw, depth / 2.0, arm_h + 0.01]) + box_from_corners([hw, -depth / 2.0, 0], [hw + t, depth / 2.0, arm_h + 0.01]);
let ends = cylinder([-hw - t, 0, 0], "X", depth / 2.0, t) + cylinder([hw, 0, 0], "X", depth / 2.0, t);
let top = box_from_corners([-plate / 2.0, -plate / 2.0, arm_h + t - 0.01], [plate / 2.0, plate / 2.0, arm_h + 2.0 * t]).fillet(3.0, "|Z");
let y = fuse_all([base, arms, ends, top]);
y -= cylinder([-hw - t - 1.0, 0, 0], "X", 3.6, t + 0.6 + 1.0);
y -= box_centered(t, 3.4, 18.0).translate([-hw - t / 2.0 + 0.3, 0, 0]) & box_from_corners([-hw - t - 1.0, -2.0, -10.0], [-hw - t + 1.2, 2.0, 10.0]);
y += cylinder([hw + t - 0.01, 0, 0], "X", 1.5, 4.0);
for x in [-1.0, 1.0] { for yy in [-1.0, 1.0] { y -= cylinder([x * (plate / 2.0 - 4.0), yy * (plate / 2.0 - 4.0), arm_h], "Z", 1.1, 3.0 * t); } }
y
