// Split cotter pin ISO 1234 3.2 x 20: two half-round 2.9 mm legs, 20 mm long with the extended prong 3 mm longer, 5.6 mm wide eye
let wire_diameter = 2.9; // [0.6, 12.0] Pin diameter (mm)
let length = 20.0; // [4.0, 120.0] Length under the eye (mm)
let eye_width = 5.6; // [1.2, 25.0] Eye width (mm)
let prong = 3.0; // [0.0, 8.0] Extra length of the long prong (mm)
let r = wire_diameter / 2.0;
let ro = max(eye_width / 2.0, r * 1.5);
let ri = max(ro - r, 0.2);
let legs = cylinder([0, 0, -length], "Z", r, length + 0.5) - box_from_corners([-0.05, -r - 1.0, -length - 1.0], [0.05, r + 1.0, ro * 0.5]);
legs = legs - box_from_corners([-r - 1.0, -r - 1.0, -length - 1.0], [0.0, r + 1.0, -length + prong]);
let eye = cylinder([0, -r, ro - 0.3], "Y", ro, wire_diameter) - cylinder([0, -r - 1.0, ro - 0.3], "Y", ri, wire_diameter + 2.0);
legs + eye
