// Synta-style finder scope dovetail shoe: 50 x 40 mm base saddled to a 100 mm tube radius, 31 mm dovetail channel tapering to 26 mm, M5 locking thumbscrew from the side, two M4 tube screws
let length = 50.0; // [35.0, 80.0] Shoe length (mm)
let width = 40.0; // [36.0, 50.0] Shoe width (mm)
let height = 12.0; // [9.0, 16.0] Height at the centre (mm)
let tube_radius = 100.0; // [40.0, 200.0] Telescope tube radius (mm)
let channel_bottom = 31.0; // [28.0, 34.0] Channel width at the bottom (mm)
let channel_top = 26.0; // [22.0, 30.0] Channel width at the top (mm)
let channel_depth = 7.0; // [5.0, 9.0] Channel depth (mm)
let block = box_from_corners([-length / 2.0, -width / 2.0, -4.0], [length / 2.0, width / 2.0, height]).fillet(3.0, "|Z");
// saddle the underside to the tube
block -= cylinder([-length, 0, -tube_radius], "X", tube_radius, 2.0 * length);
// dovetail channel open at both ends
let cb = max(channel_bottom, channel_top + 1.0) / 2.0;
let ct = channel_top / 2.0;
let z0 = height - channel_depth;
let channel = polygon("YZ", [[-cb, z0], [cb, z0], [ct, height + 0.01], [ct, height + 1.0], [-ct, height + 1.0], [-ct, height + 0.01]]).to_face().extrude([length + 2.0, 0, 0]).translate([-length / 2.0 - 1.0, 0, 0]);
block -= channel;
// side thumbscrew and two tube screws through the channel floor
block -= cylinder([0, width / 2.0 + 1.0, z0 + channel_depth / 2.0], "-Y", 2.1, width / 2.0 - cb + 2.0);
for x in [-length / 4.0, length / 4.0] {
    block -= cylinder([x, 0, -tube_radius], "Z", 2.2, tube_radius + height) + cylinder([x, 0, z0 - 2.5], "Z", 4.0, 3.0);
}
block
