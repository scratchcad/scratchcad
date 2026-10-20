// Wooden train track, straight 144 mm (Brio-compatible): 40 x 12 mm section, 2 grooves 6 x 3 mm on 20 mm centres, peg and socket ends
let length = 144.0; // [54.0, 216.0] Track length (mm)
const w = 40.0;
const t = 12.0;
let track = box_from_corners([0, -w / 2.0, 0], [length, w / 2.0, t]);
let grooves = box_from_corners([-1, -13.0, t - 3.0], [length + 1.0, -7.0, t + 1.0]) + box_from_corners([-1, 7.0, t - 3.0], [length + 1.0, 13.0, t + 1.0]);
let peg = cylinder([length + 11.0, 0, 0], "Z", 5.75, t) + box_from_corners([length - 0.01, -3.0, 0], [length + 7.0, 3.0, t]);
let socket = cylinder([11.0, 0, -1], "Z", 6.25, t + 2.0) + box_from_corners([-1, -3.5, -1], [7.0, 3.5, t + 1.0]);
track - grooves + (peg - grooves) - socket
