// MK8 extruder idler lever: 40 x 12 mm arm 6 mm thick, 3 mm pivot hole, 623 bearing pocket, spring cup
let length = 40.0; // [30.0, 60.0] Lever length (mm)
let width = 12.0; // [8.0, 18.0] Lever width (mm)
let thickness = 6.0; // [4.0, 10.0] Thickness (mm)
let lever = (box(length, width, thickness) + cylinder([0, width / 2.0, 0], "Z", width / 2.0, thickness)).fillet(2.0, "|Z and >X");
lever = lever - cylinder([0, width / 2.0, -1], "Z", 1.6, thickness + 2.0);
lever = lever - cylinder([length * 0.35, width + 2.0, -1], "Z", 5.2, thickness + 2.0);
lever = lever - cylinder([length * 0.35, width / 2.0, thickness / 2.0], "Y", 1.6, width);
lever - cylinder([length - 6.0, -1, thickness / 2.0], "Y", 3.5, 3.0)
