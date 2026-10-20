// Mechanical endstop holder for 2020: 25 x 20 mm plate 4 mm thick, two M2.5 holes 9.5 mm apart for the switch, M5 slot mount
let width = 25.0; // [20.0, 40.0] Width (mm)
let height = 20.0; // [15.0, 35.0] Height (mm)
let thickness = 4.0; // [3.0, 6.0] Thickness (mm)
let switch_pitch = 9.5; // [6.5, 22.0] Switch hole spacing (mm)
let plate = box(width, thickness, height).fillet(2.0, "|Y");
let tab = box(width, 6.0, 4.0).translate([0, -6.0 + 0.01, 0]);
let part = plate + tab;
for s in [-1, 1] { part -= cylinder([width / 2.0 + s * switch_pitch / 2.0, -1, height * 0.65], "Y", 1.25, thickness + 2.0); }
part - (cylinder([width / 2.0 - 3.0, -3.0, -1], "Z", 2.6, 6.0) + cylinder([width / 2.0 + 3.0, -3.0, -1], "Z", 2.6, 6.0) + box_centered(6.0, 5.2, 6.0).translate([width / 2.0, -3.0, 2.0]))
