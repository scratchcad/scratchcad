// Right-angle tube clamp for 48.3 mm tube: two 52 mm saddles 6 mm thick crossed at 90 degrees, joined by a 20 mm hub, each saddle 50 mm wide
let tube = 48.3; // [33.7, 60.3] Tube OD (mm)
let width = 50.0; // [35.0, 65.0] Saddle width (mm)
const t = 6.0;
let r = tube / 2.0;
let s1 = (cylinder([-width / 2.0, 0, r + t], "X", r + t, width) - cylinder([-width, 0, r + t], "X", r + 0.3, 2.0 * width)) & box_from_corners([-width, -r - t - 1.0, 0], [width, r + t + 1.0, r + t]);
let s2 = s1.rotate_z(90.0).rotate_x(180.0).translate([0, 0, -10.0]);
let hub = box_centered(width * 0.6, width * 0.6, 10.02).translate([0, 0, -5.0]);
s1 + s2 + hub
