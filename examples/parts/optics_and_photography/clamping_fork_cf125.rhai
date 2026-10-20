// Thorlabs CF125-style clamping fork: 80 x 32 mm, 9.5 mm thick, 6.6 mm open slot for a 1/4-20 cap screw with an 11 mm counterbore, 3 mm locating step
let length = 80.0; // [50.0, 120.0] Fork length (mm)
let width = 32.0; // [25.0, 40.0] Fork width (mm)
let thickness = 9.5; // [6.0, 15.0] Fork thickness (mm)
let slot_width = 6.6; // [5.0, 8.5] Slot width (mm)
let slot_length = 45.0; // [20.0, 70.0] Slot length (mm)
let counterbore = 11.0; // [9.0, 14.0] Counterbore width (mm)
let counterbore_depth = 4.0; // [2.0, 6.0] Counterbore depth (mm)
let step = 3.0; // [1.0, 5.0] Locating step height (mm)
let fork = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, thickness]).fillet(4.0, "|Z and >X").chamfer(0.5, ">Z");
// the open end: a slot from x = 0, with a counterbore around it from the top
let slot_end = slot_length;
let slot = box_from_corners([-1, -slot_width / 2.0, -1], [slot_end, slot_width / 2.0, thickness + 1.0]) + cylinder([slot_end, 0, -1], "Z", slot_width / 2.0, thickness + 2.0);
let cb_top = thickness - counterbore_depth;
let cb = box_from_corners([-1, -counterbore / 2.0, cb_top], [slot_end, counterbore / 2.0, thickness + 1.0]) + cylinder([slot_end, 0, cb_top], "Z", counterbore / 2.0, counterbore_depth + 1.0);
// the clamping end is relieved underneath, leaving a step that bears on the base
let relief = box_from_corners([-1, -width, -1], [length - 12.0, width, step]);
fork = fork - (slot + cb);
fork = fork - relief;
fork.translate([0, 0, -step])
