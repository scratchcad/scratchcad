// Bar cabinet pull, 96 mm hole centres: 12 mm round bar 136 mm long on two 30 mm posts, M4 tapped
let centres = 96.0; // [64.0, 320.0] Hole centres (mm)
let bar_d = 12.0; // [8.0, 20.0] Bar diameter (mm)
let overhang = 20.0; // [0.0, 60.0] Overhang past each post (mm)
let height = 30.0; // [20.0, 50.0] Height (mm)
let bar = cylinder([-centres / 2.0 - overhang, 0, height - bar_d / 2.0], "X", bar_d / 2.0, centres + 2.0 * overhang).fillet(bar_d * 0.3);
let posts = [];
for s in [-1, 1] { posts.push(cylinder([s * centres / 2.0, 0, 0], "Z", bar_d * 0.4, height - bar_d / 2.0) - cylinder([s * centres / 2.0, 0, -1], "Z", 1.65, 10.0)); }
fuse_all([bar] + posts)
