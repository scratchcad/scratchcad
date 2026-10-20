// Gibson-style speed knob: 18.5 mm top, 20 mm base, 16 mm tall with a 0.5 mm skirt step, 24 grip flutes and a 6 mm knurled shaft bore
let top = 18.5; // [14.0, 25.0] Top diameter (mm)
let h = 16.0; // [12.0, 22.0] Height (mm)
let knob = cone(10.0, top / 2.0, h).fillet(1.0, ">Z") + cylinder(10.5, 1.5);
let flutes = [];
for k in 0..24 { flutes.push(cylinder([10.1, 0, 2.5], "Z", 0.5, h).rotate("Z", k.to_float() * 15.0)); }
knob - fuse_all(flutes) - cylinder([0, 0, -1], "Z", 3.0, h - 3.0) - cylinder([0, 0, h - 0.6], "Z", top / 2.0 - 2.5, 1.0)
