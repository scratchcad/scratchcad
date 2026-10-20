// Bluetooth tracker tag holder: pocket for a 31.9 x 8 mm tag in a 36 mm shell 10 mm tall, 26 mm viewing window and a 10 x 4 mm key-ring loop
let tag = 31.9; // [25.0, 40.0] Tag diameter (mm)
let tag_t = 8.0; // [5.0, 10.0] Tag thickness (mm)
const wall = 2.0;
let shell = cylinder([0, 0, 0], "Z", tag / 2.0 + wall, tag_t + wall);
let shell = shell.fillet(1.5, shell.edges(">Z"));
let pocket = cylinder([0, 0, -1.0], "Z", tag / 2.0 + 0.2, tag_t + 1.0);
let window = cylinder([0, 0, tag_t], "Z", tag / 2.0 - 3.0, wall + 1.0);
let loop_ = box_from_corners([tag / 2.0, -5.0, 0], [tag / 2.0 + 10.0, 5.0, 4.0]) - box_from_corners([tag / 2.0 + wall + 2.0, -3.0, -1.0], [tag / 2.0 + 8.0, 3.0, 5.0]);
shell - pocket - window + loop_
