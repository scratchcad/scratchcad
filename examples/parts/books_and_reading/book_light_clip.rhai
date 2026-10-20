// Clip-on book light clamp: 40 mm jaws opening to 25 mm, 15 mm wide, 3 mm walls, 8 mm gooseneck socket on top
let opening = 25.0; // [15.0, 40.0] Max cover thickness (mm)
let jaw = 40.0; // [25.0, 60.0] Jaw depth (mm)
let width = 15.0; // [10.0, 25.0] Clip width (mm)
let t = 3.0; // [2.0, 5.0] Wall (mm)
let c = box_from_corners([0, 0, 0], [jaw, width, opening + 2.0 * t]) - box_from_corners([t, -1, t], [jaw + 1.0, width + 1.0, opening + t]);
let pads = box_from_corners([jaw - 10.0, 0, t - 0.01], [jaw, width, t + 1.5]) + box_from_corners([jaw - 10.0, 0, opening + t - 1.5], [jaw, width, opening + t + 0.01]);
let socket = cylinder([t + 6.0, width / 2.0, opening + 2.0 * t - 0.01], "Z", 6.0, 15.0) - cylinder([t + 6.0, width / 2.0, opening + 2.0 * t + 3.0], "Z", 4.0, 15.0);
c + pads + socket
