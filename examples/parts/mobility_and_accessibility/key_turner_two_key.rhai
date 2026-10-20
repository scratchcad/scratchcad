// Two-key turner: 95 x 30 mm paddle handle 12 mm thick with two 3 mm key slots open at the ends for key heads up to 25 mm, M4 pivot bolt holes and a 9 mm finger hole; enlarged grip for arthritic hands
// # Handle
let length = 95.0; // [70.0, 130.0] Handle length (mm)
let width = 30.0; // [22.0, 40.0] Handle width (mm)
let thickness = 12.0; // [8.0, 16.0] Handle thickness (mm)
// # Keys
let key_slot = 3.0; // [2.0, 4.0] Key slot width (mm)
let key_head = 25.0; // [18.0, 30.0] Key head width (mm)
let body = box_centered(length, width, thickness).fillet(width / 2.0 - 0.5, "|Z").fillet(2.0);
let k1 = box_centered(key_head * 0.9, key_slot, thickness + 2.0).translate([length / 2.0 - key_head * 0.45 + 1.0, 0, 0]);
let k2 = box_centered(key_head * 0.9, key_slot, thickness + 2.0).translate([-length / 2.0 + key_head * 0.45 - 1.0, 0, 0]);
let pivots = [cylinder([length / 2.0 - key_head * 0.6, -width, 0], "Y", 2.1, width * 2.0), cylinder([-length / 2.0 + key_head * 0.6, -width, 0], "Y", 2.1, width * 2.0)];
let finger = cylinder([0, 0, -thickness], "Z", 4.5, thickness * 2.0);
body - compound([k1, k2]) - compound(pivots) - finger
