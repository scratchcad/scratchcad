// Two-hole pocket hole jig: 60 x 40 x 45 mm guide block, 2 x 9.5 mm guide holes at 15 degrees, 22 mm apart, exiting 10 mm up the work face, 20 mm clamping ledge
let hole_d = 9.5; // [8.0, 12.0] Stepped drill guide hole (mm)
let angle = 15.0; // [10.0, 20.0] Hole angle to the work face (degrees)
let spacing = 22.0; // [16.0, 40.0] Hole spacing (mm)
let exit_h = 10.0; // [6.0, 16.0] Exit height on the work face (mm)
let height = 45.0; // [35.0, 60.0] Block height (mm)
let w = spacing + 38.0;
let blk = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, 40.0, height]);
let b = blk.fillet(3.0, blk.edges("|Z and >Y"));
let ledge = box_from_corners([-w / 2.0, 39.99, 0], [w / 2.0, 60.0, 10.0]);
let holes = [];
for s in [-0.5, 0.5] { holes.push(cylinder([s * spacing, 0, exit_h - 12.0], "Z", hole_d / 2.0, height + 40.0).rotate([s * spacing, 0, exit_h], "X", -angle)); }
let clamp = box_from_corners([-6.0, 44.0, -1], [6.0, 56.0, 11.0]);
b + ledge - fuse_all(holes) - clamp
