// Draining soap dish: 120 x 85 mm, 20 mm tall, 2.5 mm wall, raised soap ribs over drain slots, four feet
let length = 120.0; // [80.0, 160.0] Length (mm)
let width = 85.0; // [55.0, 110.0] Width (mm)
let height = 20.0; // [12.0, 35.0] Height (mm)
let wall = 2.5; // [1.5, 4.0] Wall thickness (mm)
let ribs = 7; // [4, 12] Number of soap ribs
let hw = width / 2.0;
let hl = length / 2.0;
let outer = box_centered(length, width, height).translate([0, 0, height / 2.0 + 3.0]).fillet(hw * 0.8, "|Z");
let inner = box_centered(length - 2.0 * wall, width - 2.0 * wall, height).translate([0, 0, height / 2.0 + 3.0 + wall]).fillet(hw * 0.8 - wall, "|Z");
let dish = outer - inner;
let pitch = (width - 2.0 * wall - 10.0) / ribs.to_float();
let bars = [];
let slots = [];
for i in 0..ribs {
    let y = -hw + wall + 5.0 + pitch * (i.to_float() + 0.5);
    bars.push(box_centered(length - 2.0 * wall - 14.0, 2.5, 5.0).translate([0, y, 3.0 + wall + 2.5 - 0.1]).fillet(1.2, ">Z"));
    if i > 0 {
        slots.push(box_centered(length - 2.0 * wall - 30.0, pitch - 4.0, wall + 2.0).translate([0, y - pitch / 2.0, 3.0 + wall / 2.0]).fillet((pitch - 4.0) * 0.45, "|Z"));
    }
}
let feet = [];
for x in [-1.0, 1.0] {
    for y in [-1.0, 1.0] {
        feet.push(cylinder([x * (hl - 15.0), y * (hw - 15.0), 0], "Z", 5.0, 3.1));
    }
}
fuse_all([dish] + bars + feet) - compound(slots)
