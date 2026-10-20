// 0.96 in I2C OLED (SSD1306 128x64) front frame: module 27.3 x 27.8 mm with M2 holes on 23.4 x 23.8 mm, glass 26.7 x 19.3 mm, 21.7 x 10.9 mm active area offset 2.4 mm up; 34 x 34 x 3 mm frame, glass pocket 1.5 mm, 4 M2 pegs
let frame = 34.0; // [30.0, 45.0] Frame size (mm)
let thick = 3.0; // [2.0, 5.0] Frame thickness (mm)
let window_w = 23.0; // [20.0, 26.0] Window width (mm)
let window_h = 12.0; // [10.0, 18.0] Window height (mm)
let peg_h = 4.0; // [2.0, 8.0] Peg height (mm)
const hole_x = 23.4;
const hole_y = 23.8;
let f = max(frame, 29.0);
let body = box_centered(f, f, thick).translate([0, 0, thick / 2.0]);
let body = body.fillet(2.0, body.edges("|Z"));
let window = box_centered(window_w, window_h, thick * 3.0).translate([0, 2.4, 0]);
let glass = box_centered(27.0, 19.4, 3.0).translate([0, 0.5, thick]);
let pegs = [body - window - glass];
for x in [-hole_x / 2.0, hole_x / 2.0] {
    for y in [-hole_y / 2.0, hole_y / 2.0] {
        pegs.push(cylinder([x, y, thick - 0.5], "Z", 0.9, peg_h + 0.5));
        pegs.push(cylinder([x, y, thick - 0.5], "Z", 1.5, 2.0));
    }
}
fuse_all(pegs)
