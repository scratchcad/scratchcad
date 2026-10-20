// Ballpoint pen cap with pocket clip: 9.5 mm OD 52 mm long, 8 mm bore, air vent hole, 40 mm clip 3 mm wide with a ball end
let len = 52.0; // [40.0, 65.0] Cap length (mm)
let cap = cylinder(4.75, len).fillet(2.0, ">Z") - cylinder([0, 0, -1], "Z", 4.0, len - 2.5) - cylinder([0, 0, len - 4.0], "Z", 0.5, 5.0);
let clip = box_from_corners([4.5, -1.5, len - 40.0], [5.7, 1.5, len - 2.0]) + box_from_corners([3.5, -1.5, len - 6.0], [5.7, 1.5, len - 2.0]) + sphere([4.9, 0, len - 40.0], 1.4);
cap + clip
