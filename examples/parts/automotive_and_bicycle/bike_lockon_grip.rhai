// Lock-on MTB grip: 130 mm long, 32 mm OD over a 22.2 mm bar, closed outer end, grip rings, alloy collar with M4 pinch bolt
let len = 130.0; // [100.0, 145.0] Length (mm)
let od = 32.0; // [28.0, 36.0] Outer diameter (mm)
const bar = 22.2;
let collar = cylinder(od / 2.0 + 1.0, 9.0) + box_from_corners([12.0, -6.0, 0], [20.0, 6.0, 9.0]);
let grip = collar + cylinder([0, 0, 9.0], "Z", od / 2.0, len - 9.0);
grip -= cylinder([0, 0, -1], "Z", bar / 2.0, len - 2.0);
grip -= box_from_corners([10.0, -0.6, -1], [21.0, 0.6, 9.0]);
grip -= cylinder([16.0, -7.0, 4.5], "Y", 2.1, 14.0);
let ring = cylinder(od / 2.0 + 1.0, 2.0) - cylinder([0, 0, -1], "Z", od / 2.0 - 1.0, 4.0);
let count = ((len - 30.0) / 8.0).to_int();
for k in 0..count { grip -= ring.translate([0, 0, 15.0 + k.to_float() * 8.0]); }
grip
