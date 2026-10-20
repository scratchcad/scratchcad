// Wiring diagram pocket for the inside of a cabinet door, takes folded A4: 230 mm wide, 160 mm tall, 30 mm deep, 2 mm walls, open top with a 40 mm wide 25 mm deep finger cut-out in the front, four 4.5 mm screw holes in the back
let width = 230.0; // [120.0, 320.0] Pocket width (mm)
let height = 160.0; // [80.0, 240.0] Pocket height (mm)
let depth = 30.0; // [15.0, 60.0] Pocket depth (mm)
const wall = 2.0;
let outer = box_from_corners([0, 0, 0], [width, depth, height]);
let outer = outer.fillet(3.0, outer.edges("|Z"));
let inner = box_from_corners([wall, wall, wall], [width - wall, depth - wall, height + 1.0]);
let finger = box_from_corners([width / 2.0 - 20.0, -1.0, height - 25.0], [width / 2.0 + 20.0, depth / 2.0, height + 1.0]);
let holes = [];
for x in [20.0, width - 20.0] {
    for z in [25.0, height - 25.0] {
        holes.push(cylinder([x, depth + 1.0, z], "-Y", 2.25, wall + 2.0));
    }
}
outer - inner - finger - fuse_all(holes)
