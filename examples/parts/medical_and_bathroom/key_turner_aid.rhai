// Key turner aid: 80 x 50 mm paddle 15 mm thick with a 3 mm x 25 mm key slot, 5 mm cross-bolt hole to clamp the key, rounded edges
let paddle_length = 80.0; // [60.0, 120.0] Paddle length (mm)
let paddle_width = 50.0; // [35.0, 70.0] Paddle width (mm)
let thickness = 15.0; // [10.0, 22.0] Paddle thickness (mm)
let slot_width = 3.0; // [2.0, 5.0] Key slot width (mm)
let slot_depth = 25.0; // [15.0, 35.0] Key slot depth (mm)
let hw = paddle_width / 2.0;
const neck = 18.0;
let outline = sketch("XY").move_to(-neck / 2.0, 0).hline_to(neck / 2.0).line_to(hw, paddle_length * 0.45)
    .arc_to(0, paddle_length, -hw, paddle_length * 0.45).close();
let paddle = outline.to_face().extrude(thickness).translate([0, 0, -thickness / 2.0]);
paddle = paddle.fillet(3.0, "not |Z");
// slot from the narrow end for the key head
let sd = min(slot_depth, paddle_length * 0.5);
paddle -= box_from_corners([-neck / 2.0 - 1.0, -1.0, -slot_width / 2.0], [neck / 2.0 + 1.0, sd, slot_width / 2.0]);
paddle -= cylinder([0, sd * 0.6, -thickness], "Z", 2.5, 2.0 * thickness);
// thumb dish
paddle - sphere([0, paddle_length * 0.62, thickness / 2.0 + 25.0], 26.5)
