// Wallbox RFID charge card holder: wall sleeve for an ID-1 card (85.6 x 54 x 0.76 mm), 1.4 mm slot open at the top, 70 x 34 mm front window, 22 mm thumb notch, 2 countersunk 3.5 mm screw holes under the card
let card_w = 85.6; // [85.0, 90.0] Card width (mm)
let card_h = 54.0; // [50.0, 56.0] Card height (mm)
let slot = 1.4; // [1.0, 3.0] Card slot (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let notch = 22.0; // [14.0, 30.0] Thumb notch width (mm)

const back = 3.0;
let w = card_w + 1.0 + 2.0 * wall;
let h = card_h * 0.85 + wall;
let d = back + slot + wall;
let body = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, d, h]);
body = body.fillet(3.0, body.edges("|Y"));
body = body - box_from_corners([-card_w / 2.0 - 0.5, back, wall], [card_w / 2.0 + 0.5, back + slot, h + 1.0]);
let win = box_centered(card_w - 16.0, wall + 2.0, h - 14.0).translate([0, back + slot + wall / 2.0, wall + 4.0 + (h - 14.0) / 2.0]);
body = body - win.fillet(3.0, win.edges("|Y"));
body = body - cylinder([0, back + slot - 0.5, h], "Y", notch / 2.0, wall + 2.0);
for s in [-1.0, 1.0] {
    let x = s * (w / 2.0 - 7.0);
    let z = h - 12.0;
    body = body - cylinder([x, -1.0, z], "Y", 1.8, back + 2.0) - cone(1.8, 3.6, 1.9).rotate_x(-90.0).translate([x, back - 1.8, z]);
}
body
