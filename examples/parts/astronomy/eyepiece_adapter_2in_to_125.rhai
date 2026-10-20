// 2 inch to 1.25 inch eyepiece adapter: 50.8 mm barrel 35 mm long, 58 mm stop flange, 31.9 mm bore with a M6 thumbscrew boss
let barrel_d = 50.8; // [50.0, 51.0] Barrel OD (mm)
let barrel_l = 35.0; // [20.0, 45.0] Barrel length (mm)
let bore = 31.9; // [31.8, 32.2] 1.25 inch bore (mm)
const flange_h = 6.0;
const top_h = 20.0;
let barrel = cylinder([0, 0, 0], "Z", barrel_d / 2.0, barrel_l + 0.01);
let flange = cylinder([0, 0, barrel_l], "Z", 29.0, flange_h);
let top = cylinder([0, 0, barrel_l + flange_h - 0.01], "Z", bore / 2.0 + 4.0, top_h);
let boss = cylinder([0, 0, barrel_l + flange_h + top_h / 2.0], "X", 5.0, bore / 2.0 + 8.0);
let body = barrel + flange + top + boss;
let thru = cylinder([0, 0, -1.0], "Z", bore / 2.0, barrel_l + flange_h + top_h + 2.0);
let screw = cylinder([0, 0, barrel_l + flange_h + top_h / 2.0], "X", 2.5, bore / 2.0 + 10.0);
body - thru - screw
