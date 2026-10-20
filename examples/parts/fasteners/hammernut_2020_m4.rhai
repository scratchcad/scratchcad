// Hammer-head T-nut for 2020 slot, M4: 10 mm long, turns 90 degrees into place
let length = 10.0; // [8.0, 14.0] Length (mm)
let width = 6.0; // [5.0, 6.2] Width (mm)
let height = 4.0; // [3.0, 5.0] Height (mm)
let bore = 3.3; // [2.5, 5.0] Tap hole (mm)
let block = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let rounding = cylinder([0, 0, -1], "Z", length / 2.0, height + 2.0);
let shaped = block & rounding;
let bevel = box_centered(length * 2.0, width, height).rotate_x(35).translate([0, width * 0.9, 0]);
(shaped - bevel - bevel.mirror("XZ")) - cylinder([0, 0, -1], "Z", bore / 2.0, height + 2.0)
