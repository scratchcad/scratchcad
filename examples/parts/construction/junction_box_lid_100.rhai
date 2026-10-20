// Junction box lid, 100 x 100 mm: 3 mm plate with 6 mm rounded corners, 2 mm locating skirt inset 2.5 mm, four captive screw bosses
let s = 100.0; // [65.0, 200.0] Lid size (mm)
let lid = box_centered(s, s, 3.0).translate([0, 0, 1.5]).fillet(6.0, "|Z").chamfer(0.8, ">Z");
let skirt = box_centered(s - 5.0, s - 5.0, 6.0).translate([0, 0, -3.0]).fillet(4.0, "|Z") - box_centered(s - 9.0, s - 9.0, 8.0).translate([0, 0, -3.0]).fillet(2.0, "|Z");
let l = lid + skirt;
for x in [-1.0, 1.0] { for y in [-1.0, 1.0] { l = l + cylinder([x * (s / 2.0 - 8.0), y * (s / 2.0 - 8.0), -6.0], "Z", 4.0, 6.1) - cylinder([x * (s / 2.0 - 8.0), y * (s / 2.0 - 8.0), -7.0], "Z", 2.0, 12.0); } }
l
