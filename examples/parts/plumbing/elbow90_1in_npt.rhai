// 1 in NPT 90 degree threaded elbow: 33.4 mm pipe OD, 40 mm body, 31 mm centre-to-end, 26.6 mm bore, hex-free banded ends
let pipe_od = 33.4; // [21.3, 60.3] Pipe OD (mm)
let center_to_end = 31.0; // [20.0, 60.0] Centre to end (mm)
let wall = 4.0; // [2.5, 8.0] Wall (mm)
let r = pipe_od / 2.0 + wall;
let leg = |axis| cylinder([0, 0, 0], axis, r, center_to_end) - cylinder([0, 0, 0], axis, pipe_od / 2.0 - 0.6, center_to_end + 1.0);
let body = fuse_all([cylinder([0, 0, 0], "X", r, center_to_end), cylinder([0, 0, 0], "Y", r, center_to_end), sphere(r)]);
let bore = fuse_all([cylinder([0, 0, 0], "X", pipe_od / 2.0 - 3.4, center_to_end + 1.0), cylinder([0, 0, 0], "Y", pipe_od / 2.0 - 3.4, center_to_end + 1.0), sphere(pipe_od / 2.0 - 3.4)]);
let sockets = cylinder([center_to_end - 18.0, 0, 0], "X", pipe_od / 2.0, 20.0) + cylinder([0, center_to_end - 18.0, 0], "Y", pipe_od / 2.0, 20.0);
let bands = (cylinder([center_to_end - 6.0, 0, 0], "X", r + 1.0, 6.0) + cylinder([0, center_to_end - 6.0, 0], "Y", r + 1.0, 6.0));
(body + bands) - bore - sockets
