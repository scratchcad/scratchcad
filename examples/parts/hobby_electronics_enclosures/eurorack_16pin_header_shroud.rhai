// Eurorack 16-pin (2 x 8, 2.54 mm) power header shroud: 30.6 x 8.9 x 9 mm box, 25.5 x 6.1 mm socket opening for the IDC plug, 4.5 x 2 mm polarity key slot on one long side, 0.9 mm square pin holes (0.64 mm pins) in a 1.5 mm floor
let pins = 8; // [3, 13] Pins per row
let height = 9.0; // [6.0, 12.0] Shroud height (mm)
let wall = 1.0; // [0.8, 1.6] Wall thickness (mm)
let floor_t = 1.5; // [1.0, 2.5] Floor thickness (mm)
let key_w = 4.5; // [3.0, 6.0] Key slot width (mm)
const pitch = 2.54;
let open_l = (pins - 1).to_float() * pitch + 2.54 + 0.2 + 2.5 * 2.0;
const open_w = 6.1;
let outer_l = open_l + 2.0 * wall + 3.08;
let outer_w = open_w + 2.0 * wall + 0.8;
let body = box_centered(outer_l, outer_w, height).translate([0, 0, height / 2.0]);
let body = body.chamfer(0.3, body.edges(">Z"));
let socket = box_centered(open_l, open_w, height * 2.0).translate([0, 0, floor_t + height]);
let key = box_centered(min(key_w, open_l * 0.5), wall + 2.0, height * 2.0).translate([0, open_w / 2.0 + wall / 2.0, floor_t + height]);
let holes = [];
for i in 0..pins {
    for j in [-1.0, 1.0] {
        let x = (i.to_float() - (pins - 1).to_float() / 2.0) * pitch;
        holes.push(box_centered(0.9, 0.9, floor_t * 4.0).translate([x, j * pitch / 2.0, 0]));
    }
}
body - socket - key - compound(holes)
