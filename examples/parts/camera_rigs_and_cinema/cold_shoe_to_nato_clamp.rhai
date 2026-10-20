// Cold shoe on a NATO clamp: 40 mm long clamp body 30 mm wide, 21.4 mm dovetail channel (45 degree, 15.8 mm neck) underneath, cold shoe on top 18.6 mm wide 2 mm slot 12.5 mm open between 1.5 mm rails, M4 locking screw (3.3 mm) in the side
let length = 40.0; // [25.0, 80.0] Clamp length (mm)
let width = 30.0; // [28.0, 40.0] Clamp width (mm)
let shoe_len = 22.0; // [18.0, 30.0] Cold shoe length (mm)
const h = 14.0;
let body = box_centered(length, width, h).translate([0, 0, h / 2.0]);
let body = body.fillet(1.5, body.edges("|X and >Z"));
// NATO dovetail channel under the body, open at both ends
let channel = face(polygon([
    [0, -7.9, -1.0], [0, 7.9, -1.0], [0, 7.9, 3.2], [0, 10.7, 6.0], [0, 10.7, 7.5], [0, -10.7, 7.5],
    [0, -10.7, 6.0], [0, -7.9, 3.2]])).extrude([length + 2.0, 0, 0]).translate([-length / 2.0 - 1.0, 0, 0]);
let screw = cylinder([0, width / 2.0 + 1.0, 4.5], "-Y", 1.65, width / 2.0 - 6.0);
// cold shoe: 18.6 mm slot 2 mm tall under 1.5 mm rails, opening 12.5 mm, open at one end
let sz = h - 3.5;
let shoe_slot = box_from_corners([-shoe_len / 2.0, -9.3, sz], [length / 2.0 + 1.0, 9.3, sz + 2.0]);
let shoe_open = box_from_corners([-shoe_len / 2.0, -6.25, sz], [length / 2.0 + 1.0, 6.25, h + 1.0]);
body - channel - screw - shoe_slot - shoe_open
