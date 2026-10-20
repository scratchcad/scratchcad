// Skateboard truck riser pad, 1/4 in: 6.35 mm thick, 64 x 92 mm with 10 mm corner radius, slotted holes for both new-school (41.3 x 54 mm) and old-school (41.3 x 63.5 mm) patterns, 5.5 mm bolt slots
let thickness = 6.35; // [3.0, 12.7] Thickness (mm)
let width = 64.0; // [55.0, 75.0] Width (mm)
let length = 92.0; // [80.0, 110.0] Length (mm)
let hole_across = 41.3; // [38.0, 45.0] Hole spacing across (mm)
let new_school = 54.0; // [50.0, 58.0] New-school hole spacing (mm)
let old_school = 63.5; // [58.0, 70.0] Old-school hole spacing (mm)
const bolt = 5.5;
let pad = box_centered(width, length, thickness).translate([0, 0, thickness / 2.0]).fillet(10.0, "|Z");
pad = pad.chamfer(0.8, ">Z");
let ha = hole_across / 2.0;
let y1 = new_school / 2.0;
let y2 = max(old_school, new_school + 0.5) / 2.0;
let slots = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        slots.push(cylinder([sx * ha, sy * y1, -1.0], "Z", bolt / 2.0, thickness + 2.0) + cylinder([sx * ha, sy * y2, -1.0], "Z", bolt / 2.0, thickness + 2.0)
            + box_from_corners([sx * ha - bolt / 2.0, sy * y1, -1.0], [sx * ha + bolt / 2.0, sy * y2, thickness + 1.0]));
    }
}
pad = pad - compound(slots);
pad - box_centered(width * 0.35, length * 0.3, thickness + 2.0).translate([0, 0, thickness / 2.0]).fillet(6.0, "|Z")
