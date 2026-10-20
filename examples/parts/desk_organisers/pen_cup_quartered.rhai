// Pen cup with 4 compartments: 80 mm round cup 105 mm tall at the back sloping to 80 mm at the front, 2.5 mm wall, 4 mm floor, cross dividers 2 mm stopping 15 mm below the rim, 3 felt pad recesses
let diameter = 80.0; // [60.0, 110.0] Cup diameter (mm)
let back_h = 105.0; // [70.0, 140.0] Back height (mm)
let front_h = 80.0; // [50.0, 120.0] Front height (mm)
let wall = 2.5; // [2.0, 4.0] Wall (mm)
let divider_drop = 15.0; // [0.0, 40.0] Divider drop below the rim (mm)

const floor_t = 4.0;
const div_t = 2.0;
let r = diameter / 2.0;
let fh = min(front_h, back_h);
let cup = cylinder(r, back_h + 1.0) - cylinder([0, 0, floor_t], "Z", r - wall, back_h + 2.0);
let divs = box_centered(diameter - wall, div_t, back_h).translate([0, 0, back_h / 2.0 + 1.0]) + box_centered(div_t, diameter - wall, back_h).translate([0, 0, back_h / 2.0 + 1.0]);
divs = divs - box_centered(diameter * 2.0, diameter * 2.0, back_h).translate([0, 0, fh - divider_drop + back_h / 2.0]);
cup = cup + divs;
let tilt = atan(back_h - fh, diameter) * 180.0 / PI();
let cutter = box_centered(diameter * 3.0, diameter * 3.0, back_h).translate([0, 0, back_h / 2.0]).rotate_x(tilt).translate([0, 0, (back_h + fh) / 2.0]);
cup = cup - cutter;
for i in 0..3 {
    let a = (i * 120.0 + 45.0) * PI() / 180.0;
    cup = cup - cylinder([(r - 9.0) * cos(a), (r - 9.0) * sin(a), -1.0], "Z", 5.1, 2.0);
}
cup
