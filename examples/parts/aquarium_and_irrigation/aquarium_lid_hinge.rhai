// Aquarium glass lid hinge: clips two 4 mm glass panes, 50 mm long, 6 mm pin knuckle
let glass = 4.0; // [3.0, 6.0] Glass thickness (mm)
let length = 50.0; // [30.0, 80.0] Hinge length (mm)
let lip = 8.0; // [5.0, 12.0] Grip depth (mm)
let w = glass + 3.0;
let channel = box_from_corners([0, 0, 0], [lip + 4.0, w, length]) - box_from_corners([4.0, 1.5, -1], [lip + 5.0, w - 1.5, length + 1.0]);
let left = channel.translate([3.0, -w / 2.0, 0]);
let right = channel.mirror([1, 0, 0]).translate([-3.0, -w / 2.0, 0]);
let knuckle = cylinder([0, 0, 0], "Z", 3.5, length) - cylinder([0, 0, -1], "Z", 1.0, length + 2.0);
left + right + knuckle - box_from_corners([-0.5, -5, length / 3.0], [0.5, 5, 2.0 * length / 3.0])
