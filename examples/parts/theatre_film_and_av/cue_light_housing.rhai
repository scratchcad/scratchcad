// Stage cue light housing: 80 x 60 x 40 mm box, 2.5 mm wall, open back, two 25 mm lens holes (red / green) with 3 mm hoods, 16 mm cable gland hole and a 30 mm rear clamp tab with 10 mm hole
let width = 80.0; // [60.0, 120.0] Housing width (mm)
let height = 60.0; // [45.0, 90.0] Housing height (mm)
let depth = 40.0; // [30.0, 60.0] Housing depth (mm)
let wall = 2.5; // [2.0, 4.0] Wall thickness (mm)
let lens = 25.0; // [18.0, 35.0] Lens hole diameter (mm)
let outer = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, depth, height]);
let o = outer.fillet(4.0, outer.edges("|Y"));
let inner = box_from_corners([-width / 2.0 + wall, wall, wall], [width / 2.0 - wall, depth + 1.0, height - wall]);
let hoods = [];
let holes = [];
for s in [-1.0, 1.0] {
    hoods.push(cylinder([s * width / 4.0, 0.01, height / 2.0], "-Y", lens / 2.0 + 3.0, 10.0) - box_from_corners([s * width / 4.0 - 20.0, -11.0, height / 2.0 - 20.0], [s * width / 4.0 + 20.0, 1.0, height / 2.0 - 2.0]));
    holes.push(cylinder([s * width / 4.0, -12.0, height / 2.0], "Y", lens / 2.0, 20.0));
}
let gland = cylinder([0, depth / 2.0, -1.0], "Z", 8.0, wall + 2.0);
let tab = box_from_corners([-15.0, depth - 10.0, height - 0.01], [15.0, depth - 6.0, height + 25.0]);
let t = tab.fillet(8.0, tab.edges("|Y and >Z"));
(o - inner + fuse_all(hoods) + t) - fuse_all(holes) - gland - cylinder([0, depth - 12.0, height + 14.0], "Y", 5.0, 8.0)
