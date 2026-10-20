// Intercom beltpack belt clip: 70 mm spring clip 30 mm wide, 3 mm thick, 50 mm back plate with two M3 holes on 20 mm centres, 2 mm gap opening to a 5 mm lead-in flare
let length = 70.0; // [50.0, 90.0] Clip length (mm)
let width = 30.0; // [20.0, 45.0] Clip width (mm)
let thickness = 3.0; // [2.0, 4.0] Thickness (mm)
let gap = 2.0; // [1.0, 4.0] Clip gap (mm)
let back = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, thickness, 50.0]);
let tongue = box_from_corners([-width / 2.0, thickness + gap, 0], [width / 2.0, 2.0 * thickness + gap, length - 8.0]);
let flare = polygon("YZ", [[thickness + gap, length - 8.01], [2.0 * thickness + gap, length - 8.01], [2.0 * thickness + gap + 3.0, length], [thickness + gap + 3.0, length]]).to_face().extrude([width, 0, 0]).translate([-width / 2.0, 0, 0]);
let bridge = box_from_corners([-width / 2.0, 0, -thickness], [width / 2.0, 2.0 * thickness + gap, 0.01]);
let holes = cylinder([-10.0, -1.0, 25.0], "Y", 1.6, thickness + 2.0) + cylinder([10.0, -1.0, 25.0], "Y", 1.6, thickness + 2.0);
let b = back + tongue + flare + bridge - holes;
b.fillet(1.0, b.edges("|Y and <Z"))
