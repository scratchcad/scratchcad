// Motorcycle clutch lever: 180 mm long curved blade 8 mm thick tapering 17 to 11 mm wide, 14 mm pivot boss with 6.2 mm bolt hole, 8 mm cable nipple hole, 16 mm ball end
let length = 180.0; // [140.0, 220.0] Blade length (mm)
let thickness = 8.0; // [6.0, 12.0] Blade thickness (mm)
let root_width = 17.0; // [12.0, 22.0] Blade width at the pivot (mm)
let tip_width = 11.0; // [8.0, 16.0] Blade width at the tip (mm)
let sweep_back = 14.0; // [0.0, 25.0] Blade curve (mm)
let pivot_d = 6.2; // [5.0, 8.5] Pivot bolt hole (mm)
const boss_h = 14.0;
const steps = 16;
let lower = [];
let upper = [];
for i in 0..=steps {
    let t = i.to_float() / steps.to_float();
    let x = 10.0 + t * (length - 10.0);
    let y = -sweep_back * (t * PI()).sin() * 0.5 - sweep_back * t * 0.5;
    let w = root_width + (tip_width - root_width) * t;
    lower.push([x, y - w / 2.0]);
    upper.insert(0, [x, y + w / 2.0]);
}
let outline = lower + upper;
let z0 = (boss_h - thickness) / 2.0;
let blade = polygon(outline).to_face().extrude([0, 0, thickness]).translate([0, 0, z0]);
let tip_y = -sweep_back;
let ball = cylinder([length, tip_y, z0], "Z", 8.0, thickness).fillet(2.0, "%CIRCLE");
let head = box_from_corners([-12.0, -12.0, 0], [16.0, 26.0, boss_h]).fillet(8.0, "|Z");
let lever = fuse_all([head, blade, ball]);
lever = lever - cylinder([0, 0, -1.0], "Z", pivot_d / 2.0, boss_h + 2.0);
lever = lever - cylinder([2.0, 17.0, -1.0], "Z", 4.0, boss_h + 2.0) - box_from_corners([-13.0, 15.5, 3.0], [2.0, 18.5, boss_h - 3.0]);
lever
