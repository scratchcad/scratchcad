// Cone thread stand base for two cones: 140 x 70 x 8 mm base with 10 mm rounded corners and 1 mm top chamfer, two 6 mm spool pins 70 mm tall on 28 mm cone seats 3 mm high, 80 mm apart, 8.2 mm socket 12 mm deep in a 16 mm boss for the antenna rod at the back
let length = 140.0; // [100.0, 200.0] Base length (mm)
let depth = 70.0; // [55.0, 100.0] Base depth (mm)
let pin_h = 70.0; // [40.0, 120.0] Spool pin height (mm)
let pin_spacing = 80.0; // [60.0, 120.0] Spool pin spacing (mm)
const base_t = 8.0;
const pin_d = 6.0;
const seat_d = 28.0;
let base = box_centered(length, depth, base_t).translate([0, 0, base_t / 2.0]);
let base = base.fillet(10.0, base.edges("|Z"));
let base = base.chamfer(1.0, base.edges(">Z"));
let ps = min(pin_spacing, length - seat_d - 6.0);
let parts = [base, cylinder([0, depth / 2.0 - 12.0, base_t - 0.5], "Z", 8.0, 14.5)];
for s in [-1.0, 1.0] {
    parts.push(cylinder([s * ps / 2.0, -6.0, base_t - 0.5], "Z", seat_d / 2.0, 3.5));
    parts.push(cylinder([s * ps / 2.0, -6.0, base_t + 2.5], "Z", pin_d / 2.0, pin_h + 0.5));
}
fuse_all(parts) - cylinder([0, depth / 2.0 - 12.0, base_t + 14.0], "-Z", 4.1, 12.0)
