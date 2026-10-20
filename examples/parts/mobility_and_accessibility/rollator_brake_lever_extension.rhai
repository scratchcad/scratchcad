// Rollator brake lever extension: clip-on paddle that widens a 12 x 6 mm rollator brake lever blade, 70 mm long sleeve with 2.5 mm wall, 35 mm wide finger paddle 8 mm thick with 5 finger grooves, M3 retaining screw
// # Lever
let blade_w = 12.0; // [8.0, 18.0] Lever blade width (mm)
let blade_t = 6.0; // [4.0, 10.0] Lever blade thickness (mm)
let sleeve_length = 70.0; // [40.0, 100.0] Sleeve length (mm)
// # Paddle
let paddle_w = 35.0; // [25.0, 50.0] Paddle width (mm)
let paddle_t = 8.0; // [6.0, 12.0] Paddle thickness (mm)
let grooves = 5; // [0, 8] Number of finger grooves
const wall = 2.5;
let sw = blade_w + 2.0 * wall;
let st = blade_t + 2.0 * wall;
let sleeve = box_from_corners([0, -sw / 2.0, 0], [sleeve_length, sw / 2.0, st]);
let paddle = box_from_corners([5.0, -paddle_w / 2.0, st - 0.01], [sleeve_length, paddle_w / 2.0, st + paddle_t]).fillet(paddle_w / 4.0, "|Z").fillet(2.0, ">Z");
let body = sleeve + paddle;
let slot = box_from_corners([-1.0, -blade_w / 2.0, wall], [sleeve_length - 6.0, blade_w / 2.0, wall + blade_t]);
let gs = [];
for i in 0..grooves {
    let x = 12.0 + i.to_float() * (sleeve_length - 20.0) / max(grooves - 1, 1).to_float();
    gs.push(cylinder([x, -paddle_w, st + paddle_t + 2.0], "Y", 3.5, paddle_w * 2.0));
}
let screw = cylinder([sleeve_length - 15.0, 0, -1.0], "Z", 1.25, wall + 2.0);
let shaped = if grooves > 0 { body - fuse_all(gs) } else { body };
shaped - slot - screw
