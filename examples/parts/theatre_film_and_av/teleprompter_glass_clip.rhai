// Teleprompter beam-splitter glass clip: corner clip for 3 mm glass, 30 x 30 mm L with a 3.3 mm slot 8 mm deep, 15 mm tall, 10 mm rod clamp bore with a 1 mm split and M4 pinch hole
let glass = 3.3; // [2.0, 6.5] Glass slot width (mm)
let slot_depth = 8.0; // [5.0, 12.0] Slot depth (mm)
let leg = 30.0; // [20.0, 45.0] Leg length (mm)
let height = 15.0; // [10.0, 25.0] Clip height (mm)
let rod = 10.0; // [8.0, 15.0] Rod diameter (mm)
let t = glass + 6.0;
let body = box_from_corners([0, 0, 0], [leg, t, height]) + box_from_corners([0, 0, 0], [t, leg, height]);
let slots = box_from_corners([t - slot_depth + 1.5, (t - glass) / 2.0, 2.0], [leg + 1.0, (t + glass) / 2.0, height + 1.0]) + box_from_corners([(t - glass) / 2.0, t - slot_depth + 1.5, 2.0], [(t + glass) / 2.0, leg + 1.0, height + 1.0]);
let clamp = cylinder([-rod / 2.0 - 3.0, -rod / 2.0 - 3.0, 0], "Z", rod / 2.0 + 3.0, height);
let c = -rod / 2.0 - 3.0;
let lug = box_from_corners([c - rod / 2.0 - 9.0, c - 5.0, 0], [c, c + 5.0, height]);
let body2 = body + clamp + lug + box_from_corners([c, c, 0], [2.0, 2.0, height]);
let bore = cylinder([c, c, -1.0], "Z", rod / 2.0, height + 2.0);
let split = box_from_corners([c - rod / 2.0 - 10.0, c - 0.5, -1.0], [c, c + 0.5, height + 1.0]);
let pinch = cylinder([c - rod / 2.0 - 5.0, c - 6.0, height / 2.0], "Y", 2.0, 12.0);
body2 - slots - bore - split - pinch
