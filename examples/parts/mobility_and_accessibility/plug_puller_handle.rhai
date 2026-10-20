// Plug puller handle: loop handle that clips over a UK BS 1363 plug top, 50 x 28 mm plug pocket 12 mm deep, 3 mm wall, 70 x 35 mm D-shaped finger loop with 25 x 60 mm opening; lets weak hands pull plugs out
// # Plug
let plug_w = 50.0; // [40.0, 56.0] Plug body width (mm)
let plug_t = 28.0; // [22.0, 34.0] Plug body thickness (mm)
let pocket_depth = 12.0; // [8.0, 18.0] Pocket depth (mm)
let wall = 3.0; // [2.0, 4.0] Wall thickness (mm)
// # Loop
let loop_height = 45.0; // [30.0, 60.0] Finger loop height (mm)
let ow = plug_w + 2.0 * wall;
let ot = plug_t + 2.0 * wall;
let cap = box_centered(ow, ot, pocket_depth + wall).translate([0, 0, (pocket_depth + wall) / 2.0]).fillet(4.0, "|Z");
let pocket = box_centered(plug_w, plug_t, pocket_depth * 2.0).fillet(3.0, "|Z");
let cord_slot = box_from_corners([-6.0, -ot, -1.0], [6.0, 0, pocket_depth * 0.7]);
let loop_outer = box_centered(ow, 12.0, loop_height).translate([0, 0, pocket_depth + wall + loop_height / 2.0 - 0.01]).fillet(ow / 2.0 - 1.0, "|Y and >Z");
let loop_inner = box_centered(ow - 2.0 * 8.0, 14.0, loop_height - 8.0).translate([0, 0, pocket_depth + wall + loop_height / 2.0 - 4.0 + 0.01]).fillet((ow - 16.0) / 2.0 - 1.0, "|Y and >Z");
cap - pocket - cord_slot + (loop_outer - loop_inner)
