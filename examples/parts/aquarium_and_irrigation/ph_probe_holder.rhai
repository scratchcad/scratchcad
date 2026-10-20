// pH probe holder for 12 mm probes: tank-rim clip for 6 to 10 mm glass, 12.3 mm bore 30 mm deep
let probe = 12.3; // [8.0, 20.0] Probe bore (mm)
let glass = 10.0; // [5.0, 15.0] Max glass thickness (mm)
let clip = box_from_corners([0, 0, 0], [glass + 6.0, 20.0, 40.0]) - box_from_corners([3.0, -1.0, -1.0], [glass + 3.0, 21.0, 37.0]);
let holder = cylinder([-probe / 2.0 - 2.0, 10.0, 10.0], "Z", probe / 2.0 + 2.5, 30.0) + box_from_corners([-probe / 2.0 - 2.0, 6.0, 10.0], [0.01, 14.0, 40.0]);
clip + holder - cylinder([-probe / 2.0 - 2.0, 10.0, 9.0], "Z", probe / 2.0, 32.0)
