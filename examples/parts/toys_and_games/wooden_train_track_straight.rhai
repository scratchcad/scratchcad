// Wooden train track, straight 144 mm: 40 x 12 mm profile with two 6 mm wide 3 mm deep grooves 25 mm apart, peg on one end and socket on the other
let len = 144.0; // [54.0, 216.0] Length (mm)
let t = box_from_corners([0, -20.0, 0], [len, 20.0, 12.0]).chamfer(1.0, ">Z");
for y in [-12.5, 12.5] { t -= box_from_corners([-1, y - 3.0, 9.0], [len + 1.0, y + 3.0, 13.0]); }
let peg = cylinder([len + 11.0, 0, 0], "Z", 5.75, 12.0) + box_from_corners([len - 1.0, -3.0, 0], [len + 7.0, 3.0, 12.0]);
let socket = cylinder([11.0, 0, -1], "Z", 6.25, 14.0) + box_from_corners([-1.0, -3.4, -1], [7.0, 3.4, 13.0]);
t + peg - socket
