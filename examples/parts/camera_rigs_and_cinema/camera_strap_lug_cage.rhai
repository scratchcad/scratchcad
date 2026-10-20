// Camera cage strap lug: 30 x 16 x 6 mm base with a 1/4-20 clearance hole (6.5 mm) counterbored 11 mm and a 3 mm anti-twist pin 2 mm proud underneath, 24 x 12 mm bail rising 14 mm with a 16 x 4 mm strap slot through it and 1.5 mm rounded edges
let strap_w = 16.0; // [10.0, 25.0] Strap width (mm)
let bail_h = 14.0; // [10.0, 25.0] Bail height (mm)
let base_t = 6.0; // [5.0, 10.0] Base thickness (mm)
const slot_h = 4.0;
let bw = strap_w + 8.0;
let base = box_centered(30.0, 16.0, base_t).translate([0, 0, base_t / 2.0]);
let base = base.fillet(3.0, base.edges("|Z"));
let bail = box_from_corners([-6.0, -bw / 2.0, base_t - 0.5], [6.0, bw / 2.0, base_t + bail_h]).translate([9.0, 0, 0]);
let bail = bail.fillet(1.5, bail.edges("|X and >Z"));
let slot = box_from_corners([1.0, -strap_w / 2.0, base_t + bail_h - slot_h - 3.0], [17.0, strap_w / 2.0, base_t + bail_h - 3.0]);
let hole = cylinder([-6.0, 0, -1.0], "Z", 3.25, base_t + 2.0) + cylinder([-6.0, 0, base_t - 3.0], "Z", 5.5, 4.0);
let pin = cylinder([-12.5, 0, -2.0], "Z", 1.5, 2.5);
base + bail + pin - slot - hole
