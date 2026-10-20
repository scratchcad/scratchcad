// Door lever extension: clip-on 100 mm extension for a 19 mm round door lever, C-shaped sleeve 60 mm long with 3 mm wall and 70 percent wrap, 30 x 14 mm paddle and two cable-tie slots 5 x 2 mm
// # Fit
let lever = 19.0; // [15.0, 25.0] Lever diameter (mm)
let sleeve_length = 60.0; // [40.0, 90.0] Sleeve length (mm)
let wall = 3.0; // [2.0, 5.0] Sleeve wall (mm)
// # Paddle
let extension = 100.0; // [60.0, 150.0] Extension beyond the sleeve (mm)
let paddle_w = 30.0; // [20.0, 45.0] Paddle width (mm)
let paddle_t = 14.0; // [8.0, 20.0] Paddle thickness (mm)
let ro = lever / 2.0 + wall;
let sleeve = cylinder([0, 0, 0], "X", ro, sleeve_length);
let paddle = box_from_corners([sleeve_length - 10.0, -paddle_w / 2.0, -paddle_t / 2.0], [sleeve_length + extension, paddle_w / 2.0, paddle_t / 2.0]).fillet(paddle_w / 2.0 - 0.5, "|Z and >X").fillet(3.0, "|X");
let body = sleeve + paddle;
let bore = cylinder([-1.0, 0, 0], "X", lever / 2.0, sleeve_length + 1.0);
let opening = box_from_corners([-1.0, -lever * 0.35, -ro - 1.0], [sleeve_length - 12.0, lever * 0.35, 0]);
let ties = [];
for x in [12.0, sleeve_length - 22.0] {
    ties.push(box_from_corners([x, -ro - 1.0, 0.5], [x + 5.0, ro + 1.0, 2.5]));
}
body - bore - opening - compound(ties)
