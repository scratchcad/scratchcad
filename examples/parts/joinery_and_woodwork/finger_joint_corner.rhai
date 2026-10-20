// Box joint (finger joint) drawer corner sample: two 12 mm boards 80 mm high, 6 fingers each 6.67 mm, assembled (two solids)
let height = 80.0; // [40.0, 150.0] Board height (mm)
let t = 12.0; // [6.0, 20.0] Board thickness (mm)
let fingers = 6; // [3, 12] Fingers per board
let length = 60.0; // [30.0, 120.0] Board length shown (mm)
let pitch = height / (2 * fingers).to_float();
let a = box_from_corners([0, 0, 0], [length, t, height]);
let b = box_from_corners([0, 0, 0], [t, length, height]);
let cuts_a = [];
let cuts_b = [];
for i in 0..fingers {
    let z0 = (2 * i).to_float() * pitch;
    cuts_a.push(box_from_corners([-1, -1, z0], [t, t + 1.0, z0 + pitch]));
    cuts_b.push(box_from_corners([-1, -1, z0 + pitch], [t + 1.0, t, z0 + 2.0 * pitch]));
}
let board_a = a - compound(cuts_a);
let board_b = b - compound(cuts_b);
compound([board_a, board_b])
