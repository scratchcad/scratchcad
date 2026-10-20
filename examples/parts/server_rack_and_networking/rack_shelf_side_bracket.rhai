// Rack shelf side bracket: L-bracket 300 mm deep with a 44 mm front ear carrying two 6.5 mm holes on 31.75 mm, a 25 mm shelf ledge, 3 mm steel and a rear ear for 4-post racks
let depth = 300.0; // [200.0, 600.0] Bracket depth (mm)
let ledge = 25.0; // [15.0, 40.0] Shelf ledge width (mm)
const t = 3.0;
let wall = box_from_corners([0, 0, 0], [t, depth, 44.0]);
let shelf = box_from_corners([0, 0, 0], [ledge, depth, t]);
let ears = box_from_corners([-20.0, -t, 0], [t, 0.01, 44.0]) + box_from_corners([-20.0, depth - 0.01, 0], [t, depth + t, 44.0]);
let holes = [];
for y in [-t - 1.0, depth - 1.0] { for z in [6.1, 37.85] { holes.push(cylinder([-10.0, y, z], "Y", 3.25, t + 2.0)); } }
wall + shelf + ears - fuse_all(holes)
