// Square post base cover: fits a 50 x 50 mm post, 90 x 90 mm skirt 25 mm tall, 2 mm wall, two-piece split along one side
let post = 50.0; // [40.0, 100.0] Post size (mm)
let skirt = 90.0; // [70.0, 140.0] Skirt size (mm)
let height = 25.0; // [15.0, 40.0] Height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let outer = loft([rect(plane([0, 0, 0], "Z"), skirt, skirt), rect(plane([0, 0, height], "Z"), post + 2.0 * wall + 2.0, post + 2.0 * wall + 2.0)], true);
let inner = loft([rect(plane([0, 0, -0.01], "Z"), skirt - 2.0 * wall, skirt - 2.0 * wall), rect(plane([0, 0, height - wall], "Z"), post + 2.0, post + 2.0)], true);
outer - inner - box_centered(post + 0.5, post + 0.5, height * 3.0) - box_from_corners([-0.5, -skirt, -1], [0.5, 0, height + 1.0])
