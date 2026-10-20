// Motorcycle frame slider puck: 40 mm Delrin puck 35 mm long with a 4 mm bevelled nose, 8.5 mm bolt bore, 15 mm counterbore 25 mm deep, 22 mm spacer spigot recess at the base
let diameter = 40.0; // [30.0, 60.0] Puck diameter (mm)
let length = 35.0; // [20.0, 60.0] Puck length (mm)
let bevel = 4.0; // [1.0, 8.0] Nose bevel (mm)
let bolt_d = 8.5; // [6.5, 12.5] Bolt bore (mm)
let counterbore_depth = 25.0; // [10.0, 45.0] Counterbore depth (mm)
const counterbore_d = 15.0;
const spigot_d = 22.0;
let puck = cylinder(diameter / 2.0, length).chamfer(min(bevel, diameter / 4.0), ">Z").chamfer(1.0, "<Z");
let cbd = min(counterbore_depth, length - 6.0);
puck = puck - cylinder([0, 0, -1.0], "Z", bolt_d / 2.0, length + 2.0) - cylinder([0, 0, length - cbd], "Z", counterbore_d / 2.0, cbd + 1.0);
puck = puck - cylinder([0, 0, -1.0], "Z", spigot_d / 2.0, 4.0);
let flats = [];
for i in 0..4 { flats.push(box_centered(3.0, diameter, 6.0).translate([diameter / 2.0, 0, length * 0.45]).rotate_z(i.to_float() * 90.0)); }
puck - compound(flats)
