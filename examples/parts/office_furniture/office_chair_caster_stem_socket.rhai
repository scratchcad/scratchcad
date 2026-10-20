// Office chair caster stem socket: 11 mm x 22 mm stem with a 1.5 mm grip ring groove, 25 mm base boss
let stem = 11.0; // [10.0, 11.5] Stem diameter (mm)
let length = 22.0; // [18.0, 25.0] Stem length (mm)
let boss = cylinder(12.5, 6.0);
let s = cylinder([0, 0, 5.99], "Z", stem / 2.0, length + 0.01);
let groove = cylinder([0, 0, 6.0 + length - 6.0], "Z", stem, 1.5) - cylinder([0, 0, 6.0 + length - 7.0], "Z", stem / 2.0 - 0.8, 4.0);
let tip = s.chamfer(0.8, s.edges(">Z"));
boss + tip - groove
