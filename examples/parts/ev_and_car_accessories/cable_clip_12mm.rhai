// Snap-in cable management clip for a 12 mm EV charging cable: C-ring 2.5 mm wall with a 9 mm mouth, 12 mm wide, screw tab 3 mm thick with a 4 mm countersunk hole
let cable = 12.0; // [8.0, 16.0] Cable diameter (mm)
let wall = 2.5; // [1.8, 3.5] Ring wall (mm)
let mouth = 0.75; // [0.6, 0.85] Mouth as a share of the cable diameter
let width = 12.0; // [8.0, 20.0] Clip width (mm)

const base_t = 3.0;
let r_in = cable / 2.0;
let r_out = r_in + wall;
let zc = base_t + r_in;
let ring = cylinder([-width / 2.0, 0, zc], "X", r_out, width);
let base = box_from_corners([-width / 2.0, -r_out, 0], [width / 2.0, r_out + 12.0, base_t]);
base = base.fillet(min(width / 2.0 - 0.5, 4.0), base.edges("|Z and >Y"));
let clip = ring + base;
clip = clip - cylinder([-width / 2.0 - 1.0, 0, zc], "X", r_in, width + 2.0);
clip = clip - box_from_corners([-width / 2.0 - 1.0, -cable * mouth / 2.0, zc], [width / 2.0 + 1.0, cable * mouth / 2.0, zc + r_out + 1.0]);
clip = clip - box_from_corners([-width, -r_out - 5.0, -5.0], [width, r_out + 20.0, 0]);
let y_hole = r_out + 6.0;
clip - cylinder([0, y_hole, -1.0], "Z", 2.1, base_t + 2.0) - cone(2.1, 4.3, 2.3).translate([0, y_hole, base_t - 2.1])
