// Desk name plate holder: 200 mm long base with a triangular section 40 mm deep and 22 mm tall, 3.2 mm slot 12 mm deep leaning back 15 degrees for a 3 mm acrylic name plate, rounded ends, felt recesses
let length = 200.0; // [120.0, 300.0] Base length (mm)
let depth = 40.0; // [30.0, 60.0] Base depth (mm)
let height = 22.0; // [15.0, 35.0] Base height (mm)
let slot = 3.2; // [2.0, 6.5] Plate slot (mm)
let lean = 15.0; // [0.0, 25.0] Plate lean back (degrees)

const slot_depth = 12.0;
let section = polygon([[0, 0, 0], [0, depth, 0], [0, depth * 0.62, height], [0, depth * 0.38, height]]);
let base = section.to_face().extrude([length, 0, 0]).translate([-length / 2.0, 0, 0]);
let ends = box_from_corners([-length / 2.0, -1.0, -1.0], [length / 2.0, depth + 1.0, height + 1.0]);
base = base & ends.fillet(depth / 2.0, ends.edges("|Z"));
let sd = min(slot_depth, height - 4.0);
let cut = box_from_corners([-length / 2.0 + 8.0, -slot / 2.0, -sd], [length / 2.0 - 8.0, slot / 2.0, 30.0]).rotate_x(-lean).translate([0, depth / 2.0, height]);
base = base - cut;
for x in [-length / 2.0 + 25.0, 0.0, length / 2.0 - 25.0] {
    base = base - box_centered(16.0, depth * 0.6, 2.0).translate([x, depth / 2.0, 0]);
}
base
