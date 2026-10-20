// Park bench slat end cap: push-on cap for a 70 x 30 mm timber or recycled-plastic slat, 3 mm walls, 25 mm skirt with 4 crush ribs and 4 mm rounded top edges
let slat_w = 70.0; // [45.0, 100.0] Slat width (mm)
let slat_t = 30.0; // [20.0, 45.0] Slat thickness (mm)
const wall = 3.0;
let c = box_centered(slat_w + 2.0 * wall, slat_t + 2.0 * wall, 25.0 + wall).translate([0, 0, (25.0 + wall) / 2.0]);
let c = c.fillet(4.0, c.edges(">Z"));
let c = c - box_centered(slat_w, slat_t, 25.0).translate([0, 0, 12.5 - 0.01]);
let ribs = box_centered(1.0, slat_t, 20.0).translate([slat_w / 2.0 - 0.4, 0, 12.0]) + box_centered(1.0, slat_t, 20.0).translate([-slat_w / 2.0 + 0.4, 0, 12.0]) + box_centered(slat_w, 1.0, 20.0).translate([0, slat_t / 2.0 - 0.4, 12.0]) + box_centered(slat_w, 1.0, 20.0).translate([0, -slat_t / 2.0 + 0.4, 12.0]);
c + ribs
