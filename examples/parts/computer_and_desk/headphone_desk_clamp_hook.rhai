// Under-desk headphone hook with clamp: 45 mm deep cradle 25 mm wide, C-clamp for desks up to 40 mm
let desk = 40.0; // [15.0, 60.0] Max desk thickness (mm)
let cradle = 45.0; // [30.0, 60.0] Cradle depth (mm)
let width = 25.0; // [15.0, 40.0] Width (mm)
let t = 5.0; // [3.0, 8.0] Wall (mm)
let clamp = box_from_corners([0, 0, 0], [50.0, width, desk + 2.0 * t]) - box_from_corners([t, -1, t], [51.0, width + 1.0, desk + t]);
let arm = box_from_corners([-cradle, 0, 0], [0.01, width, t]);
let lip = box_from_corners([-cradle, 0, -15.0], [-cradle + t, width, 0.01]);
let screw = cylinder([35.0, width / 2.0, -1], "Z", 4.2, t + 2.0);
let c = clamp + arm + lip - screw;
c.fillet(1.5, c.edges("|Y"))
