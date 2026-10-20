// Boltless shelving post foot: fits a 40 x 40 mm angle post, 60 x 60 mm foot 4 mm, 25 mm socket, 2 mm walls
let post = 40.0; // [30.0, 50.0] Post leg size (mm)
let t_post = 2.0; // [1.5, 3.0] Post wall (mm)
let height = 25.0; // [15.0, 40.0] Socket height (mm)
let wall = 2.0; // [1.5, 3.0] Socket wall (mm)
let foot = box_from_corners([-10.0, -10.0, 0], [post + 10.0, post + 10.0, 4.0]);
let f = foot.fillet(8.0, foot.edges("|Z"));
let sock = box_from_corners([-wall, -wall, 3.99], [post + wall, post + wall, height]) - box_from_corners([0, 0, 4.0], [post + 0.3, post + 0.3, height + 1.0]);
let l_fill = box_from_corners([t_post + 0.3, t_post + 0.3, 3.99], [post + 1.0, post + 1.0, height]);
f + sock + l_fill
