// Guitar tuner button: 22 x 16 mm stadium grip 6 mm thick on a 6 mm ferrule, 2.5 mm shaft hole
let w = 22.0; // [16.0, 30.0] Button width (mm)
let r = w * 0.38;
let b = (box_centered(w * 0.4, 6.0, 2.0 * r) + cylinder([-w * 0.2, -3.0, 0], "Y", r, 6.0) + cylinder([w * 0.2, -3.0, 0], "Y", r, 6.0));
let ferrule = cylinder([0, 0, -r - 8.0], "Z", 3.0, 10.0);
fuse_all([b, ferrule]) - cylinder([0, 0, -r - 9.0], "Z", 1.25, 10.0)
