// 16x2 character LCD (HD44780 1602 module) front bezel: 80 x 36 mm PCB with M3 holes on 75 x 31 mm, 71.2 x 24.2 mm metal frame, 64.5 x 16.4 mm viewing area; 90 x 46 x 2.5 mm plate, chamfered window, 4 standoffs 7.5 mm, frame locating pocket
let plate_w = 90.0; // [84.0, 120.0] Bezel width (mm)
let plate_h = 46.0; // [40.0, 70.0] Bezel height (mm)
let thick = 2.5; // [1.5, 4.0] Plate thickness (mm)
let window_w = 65.0; // [60.0, 70.0] Window width (mm)
let window_h = 17.0; // [14.0, 23.0] Window height (mm)
let standoff = 7.5; // [5.0, 12.0] Standoff height (mm)
const hole_x = 75.0;
const hole_y = 31.0;
let pw = max(plate_w, hole_x + 9.0);
let ph = max(plate_h, hole_y + 9.0);
let plate = box_centered(pw, ph, thick).translate([0, 0, thick / 2.0]);
let plate = plate.fillet(3.0, plate.edges("|Z"));
let plate = plate - box_centered(window_w, window_h, thick * 3.0);
let plate = plate.chamfer(min(1.0, thick * 0.4), plate.edges("<Z").filter(|e| e.center().x.abs() < window_w / 2.0 + 0.01 && e.center().y.abs() < window_h / 2.0 + 0.01));
let frame = box_centered(73.0, 26.0, 2.0).translate([0, 0, thick + 1.0]) - box_centered(71.6, 24.6, 6.0).translate([0, 0, thick + 1.0]);
let posts = [plate, frame];
let drills = [];
for x in [-hole_x / 2.0, hole_x / 2.0] {
    for y in [-hole_y / 2.0, hole_y / 2.0] {
        posts.push(cylinder([x, y, thick - 0.5], "Z", 3.0, standoff + 0.5));
        drills.push(cylinder([x, y, 1.0], "Z", 1.25, standoff + thick));
    }
}
fuse_all(posts) - compound(drills)
