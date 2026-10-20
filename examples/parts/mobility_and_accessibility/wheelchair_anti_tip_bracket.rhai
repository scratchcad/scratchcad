// Wheelchair anti-tip bracket: clamp block for a 25.4 mm (1 in) rear frame tube holding an anti-tip arm on a 19 mm tube at 30 degrees down, 50 mm wide block 40 mm tall, two M6 clamp bolts and a 6 mm detent pin hole
// # Frame
let frame = 25.4; // [22.0, 32.0] Frame tube diameter (mm)
let block_width = 50.0; // [40.0, 70.0] Block width (mm)
// # Arm
let arm = 19.0; // [16.0, 25.0] Anti-tip arm tube diameter (mm)
let arm_angle = 30.0; // [10.0, 45.0] Arm angle below horizontal (degrees)
let socket_length = 45.0; // [30.0, 60.0] Arm socket length (mm)
let h = frame + 14.0;
let block = box_centered(block_width, h, h).translate([0, 0, 0]);
let frame_bore = cylinder([-block_width / 2.0 - 1.0, 0, 0], "X", frame / 2.0, block_width + 2.0);
let split = box_from_corners([-block_width / 2.0 - 1.0, -0.75, -h], [block_width / 2.0 + 1.0, 0.75, 0]);
let bolts = [cylinder([-block_width / 2.0 + 8.0, -h, -frame / 2.0 - 3.5], "Y", 3.2, h * 2.0), cylinder([block_width / 2.0 - 8.0, -h, -frame / 2.0 - 3.5], "Y", 3.2, h * 2.0)];
let sock_r = arm / 2.0 + 4.0;
let socket = cylinder([0, 0, 0], "X", sock_r, socket_length).rotate_y(arm_angle).translate([block_width / 2.0 - 6.0, 0, h / 2.0 - sock_r]);
let arm_bore = cylinder([0, 0, 0], "X", arm / 2.0, socket_length + 1.0).rotate_y(arm_angle).translate([block_width / 2.0 + 2.0, 0, h / 2.0 - sock_r]);
let pin = cylinder([0, 0, -sock_r - 1.0], "Z", 3.0, 2.0 * sock_r + 2.0).translate([socket_length * 0.6, 0, 0]).rotate_y(arm_angle).translate([block_width / 2.0 - 6.0, 0, h / 2.0 - sock_r]);
(block + socket) - frame_bore - split - compound(bolts) - arm_bore - pin
