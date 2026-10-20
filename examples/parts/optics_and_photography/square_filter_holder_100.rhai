// 100 mm square filter holder (Lee / NiSi style): 116 x 116 x 4 mm frame plate with an 82 mm aperture, two guide rails 9 mm deep with three 2.2 mm filter slots each, 86 mm adapter-ring recess behind
let plate_size = 116.0; // [106.0, 130.0] Plate width (mm)
let plate_thickness = 4.0; // [3.0, 6.0] Plate thickness (mm)
let aperture = 82.0; // [60.0, 95.0] Aperture diameter (mm)
let filter_width = 100.0; // [100.0, 101.0] Filter width (mm)
let slot_count = 3; // [1, 4] Filter slots per rail
let slot_width = 2.2; // [1.8, 2.6] Slot width (mm)
let half = plate_size / 2.0;
let plate = box_centered(plate_size, plate_size, plate_thickness).translate([0, 0, plate_thickness / 2.0]).fillet(6.0, "|Z");
let rail_w = (plate_size - filter_width) / 2.0 + 2.5;
let rail_depth = 2.0 + slot_count.to_float() * (slot_width + 1.4);
let rails = [];
for s in [-1.0, 1.0] {
    rails.push(box_from_corners([s * (half - rail_w), -half + 8.0, plate_thickness - 0.1], [s * half, half - 8.0, plate_thickness + rail_depth]).fillet(1.0, "|Y"));
}
let holder = fuse_all([plate] + rails);
// slots across the rails, open at the top and bottom, cut 2.5 mm into each rail
let slots = [];
for i in 0..slot_count {
    let z = plate_thickness + 1.5 + i.to_float() * (slot_width + 1.4);
    slots.push(box_centered(filter_width + 1.0, plate_size, slot_width).translate([0, 0, z + slot_width / 2.0]));
}
holder = holder - compound(slots);
holder -= cylinder([0, 0, -1.0], "Z", aperture / 2.0, plate_thickness + 2.0);
holder - cylinder([0, 0, -1.0], "Z", 43.0, 2.5)
