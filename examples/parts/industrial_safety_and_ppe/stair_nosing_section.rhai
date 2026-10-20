// Anti-slip stair nosing: 300 mm section of 55 x 30 mm L-profile, 3 mm wall, five 4 mm wide grit insert channels 1.5 mm deep on the tread, 8 mm rounded nose, three countersunk 5 mm screw holes
let length = 300.0; // [150.0, 1000.0] Section length (mm)
let tread = 55.0; // [40.0, 80.0] Tread depth (mm)
let riser = 30.0; // [20.0, 50.0] Riser depth (mm)
let wall = 3.0; // [2.0, 5.0] Wall thickness (mm)
let p = polygon("YZ", [[0, 0], [wall, 0], [wall, riser - wall], [tread, riser - wall], [tread, riser], [0, riser]]);
let body = p.to_face().extrude([length, 0, 0]);
let b = body.fillet(4.0, body.edges("|X and <Y and >Z"));
let channels = [];
for i in 0..5 { channels.push(box_from_corners([-1.0, 10.0 + i.to_float() * 8.0, riser - 1.5], [length + 1.0, 14.0 + i.to_float() * 8.0, riser + 1.0])); }
let screws = [];
for x in [25.0, length / 2.0, length - 25.0] {
    screws.push(cylinder([x, 48.0, riser - wall - 1.0], "Z", 2.5, wall + 2.0));
    screws.push(cone(2.5, 6.0, 3.5).translate([x, 48.0, riser - 2.5]));
}
b - compound(channels) - fuse_all(screws)
