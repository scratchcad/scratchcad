// 40 mm fan finger guard: 40 x 40 x 2 mm frame, 32 mm hole spacing, concentric rings and 4 spokes
let size = 40.0; // [30.0, 140.0] Fan size (mm)
let hole_spacing = 32.0; // [24.0, 125.0] Hole spacing (mm)
let thickness = 2.0; // [1.0, 4.0] Thickness (mm)
let rings = 3; // [1, 8] Rings
let opening = size * 0.47;
let plate = box_centered(size, size, thickness).translate([0, 0, thickness / 2.0]).fillet(2.0, "|Z") - cylinder([0, 0, -1], "Z", opening, thickness + 2.0);
let parts = [plate];
for k in 1..=rings {
    let r = opening * k.to_float() / (rings + 1).to_float();
    parts.push(cylinder(r + 0.6, thickness) - cylinder([0, 0, -1], "Z", r - 0.6, thickness + 2.0));
}
for i in 0..4 { parts.push(box_centered(opening * 2.0 + 1.0, 1.2, thickness).translate([0, 0, thickness / 2.0]).rotate_z(i * 45)); }
let grill = fuse_all(parts);
for sx in [-1, 1] { for sy in [-1, 1] { grill -= cylinder([sx * hole_spacing / 2.0, sy * hole_spacing / 2.0, -1], "Z", 1.75, thickness + 2.0); } }
grill
