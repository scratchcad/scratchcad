// Snap clip for a 16 mm diameter LED cabinet light bar: 12 mm wide, 2 mm wall C-ring gripping 220 degrees of the tube on a 3 mm base 28 mm long with a countersunk 3.5 mm screw hole
let tube_d = 16.0; // [10.0, 30.0] Tube diameter (mm)
let width = 12.0; // [8.0, 20.0] Clip width (mm)
let opening = 0.8; // [0.65, 0.9] Opening as a fraction of the tube diameter
const wall = 2.0;
const base_t = 3.0;
let r = tube_d / 2.0;
let zc = base_t + r;
let ring = cylinder([0, -width / 2.0, zc], "Y", r + wall, width) - cylinder([0, -width, zc], "Y", r, 2.0 * width);
let gap = box_centered(tube_d * opening, width + 2.0, r + wall).translate([0, 0, zc + r]);
let base_len = tube_d + 12.0;
let base = box_centered(base_len, width, base_t).translate([0, 0, base_t / 2.0]);
let web = box_centered(tube_d * 0.7, width, r).translate([0, 0, base_t + r / 2.0 - 0.5]) - cylinder([0, -width, zc], "Y", r, 2.0 * width);
let clip = ring - gap + base + web;
let clip = clip - cylinder([base_len / 2.0 - 4.0, 0, -1.0], "Z", 1.75, base_t + 2.0) - cone(1.75, 3.5, 1.75).translate([base_len / 2.0 - 4.0, 0, base_t - 1.75 + 0.01]);
clip - cylinder([-base_len / 2.0 + 4.0, 0, -1.0], "Z", 1.75, base_t + 2.0) - cone(1.75, 3.5, 1.75).translate([-base_len / 2.0 + 4.0, 0, base_t - 1.75 + 0.01])
