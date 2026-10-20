// Parallel-jaw gripper finger: 60 mm reach, 20 mm wide, 6 mm plate, thickened jaw tip with a 90 degree V-groove for round parts, 1.5 mm pad recess on the outside, two M3 mounting holes 12 mm apart on the carriage foot
let reach = 60.0; // [30.0, 100.0] Finger reach (mm)
let width = 20.0; // [10.0, 30.0] Finger width (mm)
let t = 6.0; // [4.0, 10.0] Plate thickness (mm)
let jaw_len = 25.0; // [10.0, 40.0] Jaw length (mm)
let groove = 90.0; // [60.0, 120.0] V-groove angle (degrees)
const jaw_t = 6.0;
const foot = 18.0;
let jl = min(jaw_len, reach - 20.0);
let side = polygon("XZ", [[-foot, 0], [t, 0], [t, reach - jl - 10.0], [t + jaw_t, reach - jl], [t + jaw_t, reach], [0, reach], [0, t], [-foot, t]]);
let f = side.to_face().extrude([0, width, 0]);
let half = (groove / 2.0) * PI() / 180.0;
let depth = min(3.0, width / 2.0 / half.tan() - 0.5);
let vg = polygon([[t + jaw_t + 1.0, width / 2.0 - (depth + 1.0) * half.tan(), reach - jl - 1.0], [t + jaw_t + 1.0, width / 2.0 + (depth + 1.0) * half.tan(), reach - jl - 1.0], [t + jaw_t - depth, width / 2.0, reach - jl - 1.0]])
    .to_face().extrude([0, 0, jl + 2.0]);
f -= vg;
f -= box_from_corners([-1.0, 2.0, reach - jl + 2.0], [1.5, width - 2.0, reach - 2.0]);
for x in [-4.0, -16.0] { f -= cylinder([x + 1.0, width / 2.0, -1], "Z", 1.6, t + 2.0); }
f.fillet(1.0, "|Y and >Z")
