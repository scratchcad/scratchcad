// Putter ball pick-up: suction-style cup 44 mm ID 15 mm deep for a 42.67 mm ball with 3 lip fingers, on a 25 mm grip-end sleeve 20 mm long bored 23.5 mm
let grip = 23.5; // [20.0, 28.0] Grip end diameter (mm)
let cup_d = 44.0; // [43.5, 46.0] Cup inside diameter (mm)
const wall = 2.0;
let sleeve = cylinder([0, 0, 0], "Z", grip / 2.0 + wall, 20.01) - cylinder([0, 0, -1.0], "Z", grip / 2.0, 20.0);
let floor_ = cylinder([0, 0, 20.0], "Z", cup_d / 2.0 + wall, wall);
let cup = cylinder([0, 0, 20.0], "Z", cup_d / 2.0 + wall, 15.0 + wall) - cylinder([0, 0, 20.0 + wall], "Z", cup_d / 2.0, 20.0);
let fingers = [];
for i in 0..3 { fingers.push(box_from_corners([cup_d / 2.0 - 1.5, -3.0, 20.0 + wall + 12.0], [cup_d / 2.0 + 0.01, 3.0, 20.0 + wall + 15.0]).rotate_z(i.to_float() * 120.0)); }
sleeve + floor_ + cup + fuse_all(fingers)
