// Eccentric cam: 40 mm disk, 5 mm eccentricity, 10 mm thick, 10 mm bore with a 3 mm keyway, plus a 12 mm roller follower
let disk_d = 40.0; // [16.0, 100.0] Disk diameter (mm)
let eccentricity = 5.0; // [1.0, 20.0] Eccentricity (mm)
let thickness = 10.0; // [4.0, 25.0] Thickness (mm)
let bore = 10.0; // [4.0, 25.0] Bore (mm)
let cam = cylinder([eccentricity, 0, 0], "Z", disk_d / 2.0, thickness) - cylinder([0, 0, -1], "Z", bore / 2.0, thickness + 2.0);
cam = cam - box_from_corners([-1.5, 0, -1], [1.5, bore / 2.0 + 1.4, thickness + 1]);
let follower = cylinder([eccentricity + disk_d / 2.0 + 6.0, 0, 1.0], "Z", 6.0, thickness - 2.0) - cylinder([eccentricity + disk_d / 2.0 + 6.0, 0, 0], "Z", 2.0, thickness);
[cam, follower]
