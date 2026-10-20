// 14G brass spoke nipple: 12 mm long, 4.5 mm head, 3.9 mm body with 3.23 mm square wrench flats, 2.0 mm bore
let length = 12.0; // [10.0, 16.0] Length (mm)
let profile = sketch("XZ").move_to(1.0, 0).line_to(2.25, 0).line_to(2.25, 1.0).line_to(1.95, 2.2).line_to(1.95, length).line_to(1.0, length).close();
let nip = profile.to_face().revolve("Z", 360);
for a in [0.0, 90.0, 180.0, 270.0] { nip -= box_from_corners([1.615, -3.0, 4.0], [3.0, 3.0, length + 1.0]).rotate("Z", a); }
nip
