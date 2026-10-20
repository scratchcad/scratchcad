// Headphone desk clamp hanger: C-clamp for desks 15 to 40 mm thick with an M8 screw boss, 40 mm wide, 6 mm thick arms and a 60 mm hook with a 25 mm wide padded saddle
let desk = 40.0; // [15.0, 60.0] Max desk thickness (mm)
let reach = 60.0; // [40.0, 90.0] Hook reach (mm)
const t = 6.0;
const w = 40.0;
let c = box_from_corners([0, 0, 0], [50.0, w, t]) + box_from_corners([0, 0, -desk - t], [t, w, 0.01]) + box_from_corners([0, 0, -desk - t], [50.0, w, -desk]);
let boss = cylinder([30.0, w / 2.0, -desk - t - 10.0], "Z", 8.0, 10.01);
let hook = box_from_corners([-reach, w / 2.0 - 12.5, -desk - t], [0.01, w / 2.0 + 12.5, -desk - t + t]) + box_from_corners([-reach, w / 2.0 - 12.5, -desk - t], [-reach + t, w / 2.0 + 12.5, -desk - t + 20.0]);
c + boss + hook - cylinder([30.0, w / 2.0, -desk - t - 11.0], "Z", 3.4, t + 12.0)
