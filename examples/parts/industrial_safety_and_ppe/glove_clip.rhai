// Glove guard belt clip: 60 x 30 mm belt plate 3 mm with a 50 x 6 mm belt slot, 25 mm toothed jaw gripping gloves against a 3 mm spring tongue
let plate_height = 60.0; // [45.0, 80.0] Plate height (mm)
let width = 30.0; // [22.0, 40.0] Width (mm)
let thickness = 3.0; // [2.5, 4.0] Thickness (mm)
let gap = 1.0; // [0.5, 3.0] Jaw gap (mm)
let plate = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, thickness, plate_height]);
let p = plate.fillet(4.0, plate.edges("|Y and >Z"));
let belt_slot = box_from_corners([-width / 2.0 + 4.0, -1, plate_height - 14.0], [width / 2.0 - 4.0, thickness + 1.0, plate_height - 8.0]);
// U-bend at the bottom joining the plate to the tongue
let bend = cylinder([-width / 2.0, thickness + gap / 2.0, 0], "X", thickness + gap / 2.0, width) - cylinder([-width / 2.0 - 1.0, thickness + gap / 2.0, 0], "X", gap / 2.0, width + 2.0) - box_from_corners([-width, -10, 0], [width, 10, 10]);
let tongue = box_from_corners([-width / 2.0, thickness + gap, 0], [width / 2.0, 2.0 * thickness + gap, 30.0]);
let teeth = [];
for i in 0..5 {
    teeth.push(polygon("YZ", [[thickness + gap + 0.01, 8.0 + i.to_float() * 4.0], [thickness + gap - 0.8, 10.0 + i.to_float() * 4.0], [thickness + gap + 0.01, 12.0 + i.to_float() * 4.0]]).to_face().extrude([width - 4.0, 0, 0]).translate([-width / 2.0 + 2.0, 0, 0]));
}
p - belt_slot + bend + tongue + fuse_all(teeth)
