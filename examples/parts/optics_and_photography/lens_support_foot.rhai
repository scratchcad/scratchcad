// Telephoto lens tripod collar with foot: 80 mm bore ring 10 mm wall 25 mm wide, split with a locking knob boss, 45 mm stem to a 70 x 38 mm Arca-compatible foot with two 1/4-20 holes
let bore = 80.0; // [50.0, 120.0] Lens barrel diameter (mm)
let ring_wall = 10.0; // [6.0, 15.0] Ring wall (mm)
let ring_width = 25.0; // [15.0, 40.0] Ring width (mm)
let stem_height = 25.0; // [10.0, 60.0] Stem height below the ring (mm)
let foot_length = 70.0; // [50.0, 120.0] Foot length (mm)
let r = bore / 2.0;
let ro = r + ring_wall;
let zc = ro + stem_height + 10.0;
// ring around the Y axis (the lens axis), centred at height zc
let ring = cylinder([0, -ring_width / 2.0, zc], "Y", ro, ring_width);
let stem = box_from_corners([-12.0, -ring_width / 2.0, 9.0], [12.0, ring_width / 2.0, zc - r + 1.0]);
// Arca-style foot with 45 deg dovetails, running along the lens
let fl = foot_length / 2.0;
let foot = polygon("XZ", [[-19.0, 0.0], [19.0, 0.0], [15.0, 4.0], [15.0, 10.0], [-15.0, 10.0], [-15.0, 4.0]]).to_face().extrude([0, -foot_length, 0]).translate([0, fl, 0]);
let boss = box_from_corners([-8.0, -ring_width / 2.0, zc + r - 2.0], [8.0, ring_width / 2.0, zc + ro + 8.0]);
let collar = fuse_all([ring, stem, foot, boss]);
collar -= cylinder([0, -ring_width, zc], "Y", r, 2.0 * ring_width);
// split through the boss, and the locking screw across it
collar -= box_from_corners([-1.0, -ring_width, zc + r - 3.0], [1.0, ring_width, zc + ro + 10.0]);
collar -= cylinder([-10.0, 0, zc + ro + 2.5], "X", 2.6, 20.0);
for y in [-fl + 12.0, fl - 12.0] {
    collar -= cylinder([0, y, -1.0], "Z", 2.55, 12.0);
}
collar.fillet(2.0, "|Y and >Z[-1]")
