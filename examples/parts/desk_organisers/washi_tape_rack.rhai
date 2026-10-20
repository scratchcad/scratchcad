// Washi tape rack, two bodies (rack and rod): wall or desk rack with a 25 mm dowel-style rod for 8 rolls of 15 mm washi tape on 25 mm cores, 130 mm between 5 mm cheeks 60 mm tall, rod pins drop into open-top slots, 2 countersunk 4 mm screws
let span = 130.0; // [60.0, 250.0] Clear span between cheeks (mm)
let core = 25.0; // [20.0, 32.0] Tape core diameter (mm)
let roll_d = 50.0; // [35.0, 70.0] Largest roll diameter (mm)
let cheek_t = 5.0; // [4.0, 8.0] Cheek thickness (mm)
let back_t = 4.0; // [3.0, 6.0] Back plate thickness (mm)

let rod_r = core / 2.0 - 1.0;
let rd = max(roll_d, core + 14.0);
let zc = rd / 2.0 + 4.0;
let reach = rd / 2.0 + back_t + 3.0 + rod_r + 4.0;
let h = zc + rod_r + 8.0;
let back = box_from_corners([-span / 2.0 - cheek_t, 0, 0], [span / 2.0 + cheek_t, back_t, h]);
let cheeks = [];
for s in [-1.0, 1.0] {
    let x0 = if s < 0.0 { -span / 2.0 - cheek_t } else { span / 2.0 };
    let c = box_from_corners([x0, 0, 0], [x0 + cheek_t, reach, h]);
    c = c.fillet(rod_r + 4.0, c.edges("|X and >Y and >Z"));
    c = c - cylinder([x0 - 1.0, reach - rod_r - 4.0, zc], "X", 4.1, cheek_t + 2.0) - box_from_corners([x0 - 1.0, reach - rod_r - 4.0 - 3.4, zc], [x0 + cheek_t + 1.0, reach - rod_r - 4.0 + 3.4, h + 1.0]);
    cheeks.push(c);
}
let rack = back + fuse_all(cheeks);
for s in [-1.0, 1.0] {
    let x = s * span / 4.0;
    rack = rack - cylinder([x, -1.0, h - 10.0], "Y", 2.1, back_t + 2.0) - cone(2.1, 4.3, 2.3).rotate_x(-90.0).translate([x, back_t - 2.1, h - 10.0]);
}
// the rod, a separate body lying in front: 8 mm pins at the ends drop into the cheek slots
let rod = cylinder([-span / 2.0 + 0.5, 0, 0], "X", rod_r, span - 1.0) + cylinder([-span / 2.0 - cheek_t, 0, 0], "X", 3.8, span + 2.0 * cheek_t);
compound([rack, rod.translate([0, reach + rod_r + 10.0, rod_r])])
