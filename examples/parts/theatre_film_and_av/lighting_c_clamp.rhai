// Stage lighting C-clamp: hook clamp for 48.3 mm (1.9 in) pipe, 50 mm wide, 8 mm section, side opening 52 mm, M12 wing bolt pushing up from the lower jaw, 13 mm yoke bolt hole through the base
let pipe = 48.3; // [33.7, 60.3] Pipe diameter (mm)
let width = 50.0; // [30.0, 60.0] Clamp width (mm)
let section = 8.0; // [6.0, 12.0] Section thickness (mm)
let bolt = 12.0; // [8.0, 16.0] Wing bolt diameter (mm)
let r = pipe / 2.0 + 1.0;
let ro = r + section;
let jaw_z = -r - 26.0;
// hook: a ring around the pipe with its lower-right quarter removed
let ring = cylinder([0, -width / 2.0, 0], "Y", ro, width) - cylinder([0, -width, 0], "Y", r, width * 2.0) - box_from_corners([0, -width, -ro - 1.0], [ro + 1.0, width, 0]);
let back = box_from_corners([-ro, -width / 2.0, jaw_z - section], [-r, width / 2.0, 0.01]);
let jaw = box_from_corners([-ro, -width / 2.0, jaw_z - section], [r * 0.5 + bolt / 2.0 + 6.0, width / 2.0, jaw_z]);
let boss = cylinder([r * 0.5, 0, jaw_z - section - 6.0], "Z", bolt / 2.0 + 5.0, section + 6.0);
let body = ring + back + jaw + boss;
let b = body.fillet(2.0, body.edges("|Y").filter(|e| e.center().z < jaw_z - 1.0));
b - cylinder([r * 0.5, 0, jaw_z - 30.0], "Z", bolt / 2.0, 40.0) - cylinder([-ro + 12.0, 0, jaw_z - 30.0], "Z", 6.5, 40.0)
