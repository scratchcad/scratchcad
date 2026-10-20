// Petal (tulip) lens hood for a 77 mm-thread zoom, EW-83 style: 84 mm bayonet base, 55 mm long flaring to 120 mm, 1.6 mm wall, scalloped cut-outs on the long sides of the frame, three bayonet lugs
let base_diameter = 84.0; // [60.0, 100.0] Base inside diameter (mm)
let length = 55.0; // [30.0, 90.0] Hood length (mm)
let front_diameter = 120.0; // [80.0, 160.0] Front inside diameter (mm)
let wall = 1.6; // [1.0, 3.0] Wall thickness (mm)
let scallop_depth = 26.0; // [5.0, 45.0] Petal cut-out depth (mm)
let rb = base_diameter / 2.0;
let rf = max(front_diameter / 2.0, rb + 5.0);
// conical shell from a revolved profile, with a straight collar at the base
let profile = polygon("XZ", [[rb, -8.0], [rb + wall, -8.0], [rb + wall, 0.0], [rf + wall, length], [rf, length], [rb, 0.0]]);
let hood = profile.to_face().revolve("Z", 360);
// scallops: a big cylinder across the hood along X cuts arcs out of the side walls only
let rs = rb + 6.0;
let scallop = cylinder([-rf - 10.0, 0, length + rs - min(scallop_depth, length - 2.0)], "X", rs, 2.0 * rf + 20.0);
hood = hood - scallop;
// three bayonet lugs inside the collar
let lugs = [];
for a in [0.0, 120.0, 240.0] {
    lugs.push(cylinder([0, 0, -6.5], "Z", rb + 0.1, 2.0).rotate_z(a) & box_from_corners([0, -6.0, -7.0], [rb + 1.0, 6.0, -4.0]).rotate_z(a + 90.0));
}
let ring = cylinder([0, 0, -6.5], "Z", rb + 0.2, 2.0) - cylinder([0, 0, -7.0], "Z", rb - 1.2, 3.0);
hood + (ring & fuse_all(lugs))
