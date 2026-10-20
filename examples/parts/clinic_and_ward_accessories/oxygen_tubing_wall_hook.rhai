// Oxygen tubing wall hook: 40 x 70 mm back plate 4 mm thick with two 4.5 mm screw holes, a 30 mm wide arm reaching 60 mm with a 25 mm radius saddle that stops the coiled tubing kinking, and a 15 mm up-turned tip
let reach = 60.0; // [40.0, 90.0] Hook reach (mm)
let width = 30.0; // [20.0, 45.0] Hook width (mm)
let tip = 15.0; // [8.0, 25.0] Tip height (mm)
const t = 4.0;
const arm_t = 8.0;
let plate = box_from_corners([-20.0, -t, 0], [20.0, 0.01, 70.0]);
plate = plate.fillet(5.0, plate.edges("|Y"));
let arm = box_from_corners([-width / 2.0, 0, 20.0], [width / 2.0, reach, 20.0 + arm_t]);
let up = box_from_corners([-width / 2.0, reach - arm_t, 20.0], [width / 2.0, reach, 20.0 + arm_t + tip]);
let gusset = face(polygon([[0, 0, 20.0 + arm_t - 0.01], [0, 0, 55.0], [0, 20.0, 20.0 + arm_t - 0.01]])).extrude([6.0, 0, 0]).translate([-3.0, -0.01, 0]);
let h = plate + arm + up + gusset;
h - cylinder([0, -t - 1.0, 10.0], "Y", 2.25, t + 2.0) - cylinder([0, -t - 1.0, 62.0], "Y", 2.25, t + 2.0)
