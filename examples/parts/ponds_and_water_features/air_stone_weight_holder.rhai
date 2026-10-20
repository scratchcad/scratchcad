// Air stone sinker holder: 40 mm puck 15 mm tall (fill with stone or lead shot through a 20 mm sealed pocket), a 25 mm air stone cup 20 mm deep on top and a 4 mm airline channel
let stone = 25.0; // [15.0, 35.0] Air stone diameter (mm)
let puck = 40.0; // [35.0, 60.0] Puck diameter (mm)
const h = 15.0;
let p = cylinder([0, 0, 0], "Z", puck / 2.0, h);
let cup = cylinder([0, 0, h - 0.01], "Z", stone / 2.0 + 2.0, 20.0) - cylinder([0, 0, h + 2.0], "Z", stone / 2.0 + 0.3, 20.0);
let pocket = cylinder([0, 0, 3.0], "Z", 10.0, h - 6.0);
let channel = box_from_corners([-2.0, 0, h + 12.0], [2.0, stone / 2.0 + 3.0, h + 21.0]);
p + cup - pocket - channel
