// Hexapod leg femur link joining two SG90-class servos: 60 mm between joint centres, 3 mm plate 14 mm wide with 18 mm round ends, cross-horn pocket and 2 mm horn screw holes at one end, servo-body clamp ring at the other
let length = 60.0; // [40.0, 100.0] Joint centre distance (mm)
let width = 14.0; // [10.0, 20.0] Link width (mm)
let t = 3.0; // [2.0, 5.0] Plate thickness (mm)
let end_d = 18.0; // [14.0, 25.0] End boss diameter (mm)
let re = max(end_d, width) / 2.0;
let link = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]) + cylinder(re, t) + cylinder([length, 0, 0], "Z", re, t);
link -= box_centered(length - 2.0 * re - 6.0, width - 7.0, 10.0).translate([length / 2.0, 0, 0]).fillet(min(3.0, (width - 7.0) / 2.0 - 0.1), "|Z");
link -= cylinder([0, 0, 1.2], "Z", 3.6, t);
for i in 0..4 {
    link -= box_centered(4.0, 15.5, 4.0).translate([0, 0, t]).rotate_z(i.to_float() * 90.0) & box_centered(30, 30, 4.0).translate([0, 0, t + 0.6]);
}
link -= cylinder([0, 0, -1], "Z", 1.2, t + 2.0);
for y in [-5.0, 5.0] { link -= cylinder([0, y, -1], "Z", 0.75, t + 2.0); }
link -= cylinder([length, 0, -1], "Z", 1.6, t + 2.0);
link
