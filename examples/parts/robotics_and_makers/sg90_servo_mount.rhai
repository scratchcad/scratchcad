// Mounting block for an SG90 micro servo: 22.8 x 12.4 mm pocket, ledge for the 32.5 mm tab flange, two M2 pilot holes 27.6 mm apart, base plate with two M3 screw slots
let pocket_l = 22.8; // [20.0, 26.0] Servo body length (mm)
let pocket_w = 12.4; // [11.0, 14.0] Servo body width (mm)
let ledge_h = 16.0; // [10.0, 22.0] Height of the tab ledge (mm)
let base_len = 50.0; // [40.0, 70.0] Base plate length (mm)
const wall = 3.0;
const hole_spacing = 27.6;
let bl = max(base_len, pocket_l + 2.0 * wall + 16.0);
let block = box_centered(pocket_l + 2.0 * wall + 9.0, pocket_w + 2.0 * wall, ledge_h).translate([0, 0, ledge_h / 2.0]);
let base = box_centered(bl, pocket_w + 2.0 * wall + 10.0, 3.0).translate([0, 0, 1.5]).fillet(3.0, "|Z");
let m = block + base;
m -= box_centered(pocket_l, pocket_w, ledge_h * 2.0).translate([0, 0, ledge_h + 3.0]);
m -= box_centered(6.0, 4.0, 10.0).translate([-pocket_l / 2.0, 0, 6.0]);
for s in [-1.0, 1.0] {
    m -= cylinder([s * hole_spacing / 2.0, 0, 4.0], "Z", 0.8, ledge_h);
    let x = s * (bl / 2.0 - 5.0);
    m -= box_centered(0.01 + 3.0, 3.4, 10.0).translate([x, 0, 0]) + cylinder([x - 1.5, 0, -1], "Z", 1.7, 6.0) + cylinder([x + 1.5, 0, -1], "Z", 1.7, 6.0);
}
m.fillet(0.8, "%LINE and >Z")
