// RC boat display stand cradle: 120 mm wide V-cradle 10 mm thick for a 90 mm beam hull, 30 mm deep vee, 20 mm foot height and a 60 x 10 mm relief under the vee
let beam = 90.0; // [60.0, 200.0] Hull beam (mm)
let vee = 30.0; // [15.0, 50.0] Vee depth (mm)
const t = 10.0;
let w = beam + 30.0;
let prof = polygon([[-w / 2.0, 0, 0], [w / 2.0, 0, 0], [w / 2.0, 0, 20.0 + vee], [beam / 2.0, 0, 20.0 + vee], [0, 0, 20.0], [-beam / 2.0, 0, 20.0 + vee], [-w / 2.0, 0, 20.0 + vee]]);
let c = face(prof).extrude([0, t, 0]);
c - box_from_corners([-w / 4.0, -1.0, -1.0], [w / 4.0, t + 1.0, 10.0])
