// Mitre box: 250 mm long U-channel, 60 mm inside width, 50 mm tall walls 10 mm thick on a 10 mm base, 1.6 mm saw kerfs at 90 and both 45 degrees
let length = 250.0; // [180.0, 400.0] Length (mm)
let inside = 60.0; // [40.0, 100.0] Inside width (mm)
let wall_h = 50.0; // [30.0, 80.0] Wall height above the base (mm)
let wall = 10.0; // [8.0, 20.0] Wall thickness (mm)
let kerf = 1.6; // [0.8, 3.0] Saw kerf (mm)
let ow = inside + 2.0 * wall;
let box_ = box_from_corners([0, 0, 0], [length, ow, 10.0 + wall_h]) - box_from_corners([-1, wall, 10.0], [length + 1.0, wall + inside, 10.0 + wall_h + 1.0]);
let k = box_centered(kerf, ow * 2.0, wall_h + 10.0).translate([0, ow / 2.0, 8.0 + (wall_h + 10.0) / 2.0]);
let kerfs = [k.translate([length / 2.0, 0, 0]), k.rotate([0, ow / 2.0, 0], "Z", 45.0).translate([length * 0.2 + ow / 2.0, 0, 0]), k.rotate([0, ow / 2.0, 0], "Z", -45.0).translate([length * 0.8 - ow / 2.0, 0, 0])];
box_ - fuse_all(kerfs)
