// Silicone-style heated bed leveling spacer replacing springs: 18 mm column 16 mm tall with a slight waist, 3.4 mm bore for M3, 6 mm locating spigot 2 mm tall on top that sits in the bed's hole, 0.8 mm chamfers
let column_d = 18.0; // [12.0, 25.0] Column diameter (mm)
let height = 16.0; // [8.0, 25.0] Column height (mm)
let bore = 3.4; // [3.0, 5.5] Screw bore (mm)
let spigot_d = 6.0; // [5.0, 10.0] Locating spigot diameter (mm)
let waist = 0.9; // [0.75, 0.97] Waist diameter relative to the column
const spigot_h = 2.0;
let r = column_d / 2.0;
let rw = r * waist;
let column = cone(r, rw, height / 2.0) + cone(rw, r, height / 2.0).translate([0, 0, height / 2.0]);
let sd = max(spigot_d, bore + 2.0);
let spacer = column + cylinder([0, 0, height - 0.5], "Z", min(sd / 2.0, rw - 1.0), spigot_h + 0.5);
spacer - cylinder([0, 0, -1], "Z", bore / 2.0, height + spigot_h + 2.0)
