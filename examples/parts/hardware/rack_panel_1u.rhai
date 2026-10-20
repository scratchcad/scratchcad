// 19 inch 1U blank rack panel: 482.6 x 44.45 x 3 mm with four 6.5 x 10 mm slotted holes on 465 mm centres
let width = 482.6; // [482.6, 482.6] Panel width (mm)
let units = 1; // [1, 4] Rack units
let thickness = 3.0; // [2.0, 6.0] Thickness (mm)
let h = units.to_float() * 44.45 - 0.8;
let panel = box_centered(width, thickness, h).fillet(1.0, "|Y");
for sx in [-1, 1] { for k in 0..units {
    let z = -h / 2.0 + 6.35 + k.to_float() * 44.45;
    for dz in [0.0, 31.75] {
        if z + dz < h / 2.0 - 3.0 {
            panel -= (box_centered(3.5, thickness + 2.0, 6.5) + cylinder([-1.75, -thickness, 0], "Y", 3.25, thickness * 2.0) + cylinder([1.75, -thickness, 0], "Y", 3.25, thickness * 2.0)).translate([sx * 232.5, 0, z + dz]);
        }
    }
} }
panel
