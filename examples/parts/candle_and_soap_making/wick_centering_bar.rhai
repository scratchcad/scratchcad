// Candle wick centering bar: 100 x 12 x 3 mm bar resting across a jar mouth up to 90 mm, with a 2 x 8 mm wick slot at the centre and two 3 mm locating lugs that sit just inside the jar mouth (kept on the bar if the jar is wider)
let length = 100.0; // [70.0, 140.0] Bar length (mm)
let jar = 80.0; // [50.0, 120.0] Jar mouth ID for the lugs (mm)
const t = 3.0;
let b = box_centered(length, 12.0, t).translate([0, 0, t / 2.0]);
let lug_x = min(jar, length - 6.0) / 2.0 - 1.5;
let lugs = box_centered(3.0, 8.0, 4.0).translate([-lug_x, 0, -2.0 + 0.01]) + box_centered(3.0, 8.0, 4.0).translate([lug_x, 0, -2.0 + 0.01]);
b + lugs - box_centered(2.0, 8.0, t + 2.0).translate([0, 0, t / 2.0])
