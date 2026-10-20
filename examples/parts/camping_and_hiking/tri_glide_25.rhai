// 25 mm tri-glide webbing slide: 33 x 22 x 3.5 mm with two 26 x 4 mm slots
let webbing = 25.0; // [15.0, 50.0] Webbing width (mm)
let thickness = 3.5; // [2.5, 5.0] Thickness (mm)
let slot = 4.0; // [2.5, 6.0] Slot width (mm)
let outer = box_centered(webbing + 8.0, 22.0, thickness);
let o = outer.fillet(3.0, outer.edges("|Z"));
o - box_centered(webbing + 1.0, slot, thickness * 2.0).translate([0, -5.5, 0]) - box_centered(webbing + 1.0, slot, thickness * 2.0).translate([0, 5.5, 0])
