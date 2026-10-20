// Pole-mount squirrel baffle: 450 mm cone sloping 30 degrees, 1.5 mm wall, 25 mm collar for a 22 mm pole with a set-screw boss
let diameter = 450.0; // [300.0, 600.0] Baffle diameter (mm)
let slope = 30.0; // [15.0, 45.0] Cone slope (degrees)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let pole_diameter = 22.0; // [16.0, 40.0] Pole diameter (mm)
let R = diameter / 2.0;
let rp = pole_diameter / 2.0 + 0.5;
let rc = rp + 4.0;
let h = (R - rc) * (slope * PI() / 180.0).tan();
let t = wall / (slope * PI() / 180.0).cos();
let shell = cone(R, rc, h) - cone(R, rc, h).translate([0, 0, -t]);
shell = shell & cylinder([0, 0, -1.0], "Z", R, h + 2.0);
let collar = cylinder([0, 0, h - 10.0], "Z", rc, 35.0);
let boss = cylinder([0, 0, h + 15.0], "X", 5.0, rc + 4.0);
let baffle = fuse_all([shell, collar, boss]);
baffle - cylinder([0, 0, -10.0], "Z", rp, h + 60.0) - cylinder([0, 0, h + 15.0], "X", 2.0, rc + 6.0)
