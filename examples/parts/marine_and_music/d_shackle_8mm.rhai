// 8 mm stainless D-shackle: 8 mm body wire, 16 mm jaw width, 32 mm inside length, 10 mm screw pin with an eye head
let wire = 8.0; // [4.0, 16.0] Body diameter (mm)
let w = wire * 2.0;
let L = wire * 4.0;
let r = wire / 2.0;
let bow = (torus(w / 2.0 + r, r) & box_centered(3.0 * w, 3.0 * w, 3.0 * w).translate([0, 1.5 * w, 0])).rotate_x(90.0).translate([0, 0, L - w / 2.0]);
let legs = [cylinder([-w / 2.0 - r, 0, 0], "Z", r, L - w / 2.0), cylinder([w / 2.0 + r, 0, 0], "Z", r, L - w / 2.0)];
let ears = [cylinder([-w / 2.0 - r, -r * 1.3, 0], "Y", r * 1.3, r * 2.6) , cylinder([w / 2.0 + r, -r * 1.3, 0], "Y", r * 1.3, r * 2.6)].map(|e| e.rotate_x(0.0));
let body = fuse_all([bow] + legs + [cylinder([-w / 2.0 - r - 1.3 * r, 0, 0], "X", 1.3 * r, 2.6 * r), cylinder([w / 2.0 + r - 1.3 * r, 0, 0], "X", 1.3 * r, 2.6 * r)]);
body -= cylinder([-w, 0, 0], "X", r * 0.65, 2.0 * w);
let pin = cylinder([-w / 2.0 - 2.0 * r - 2.0, 0, 0], "X", r * 0.6, w + 3.0 * r + 2.0) + torus(r * 0.9, r * 0.4).rotate_y(90.0).rotate_x(90.0).translate([-w / 2.0 - 2.0 * r - 2.0 - r * 0.9, 0, 0]) + cylinder([-w / 2.0 - 2.0 * r - 3.0, 0, 0], "X", r, 2.0);
compound([body, pin])
