// 4 in pop-up spray sprinkler: 50 mm body 100 mm tall, 57 mm cap, 22 mm riser shown up 30 mm with a spray slot, 1/2 in NPT inlet boss
let body_height = 100.0; // [70.0, 160.0] Body height (mm)
let body_diameter = 50.0; // [40.0, 60.0] Body diameter (mm)
let cap_diameter = 57.0; // [48.0, 70.0] Cap diameter (mm)
let riser_diameter = 22.0; // [16.0, 28.0] Riser diameter (mm)
let pop_up = 30.0; // [0.0, 100.0] Riser pop-up height (mm)
let rb = body_diameter / 2.0;
let rc = max(cap_diameter / 2.0, rb + 2.0);
let rr = riser_diameter / 2.0;
let boss = cylinder([0, 0, -14.0], "Z", 13.0, 15.0);
let body = cylinder(rb, body_height) + boss;
let cap = cylinder([0, 0, body_height - 1.0], "Z", rc, 7.0).fillet(2.0, ">Z");
let housing = fuse_all([body, cap]);
housing -= cylinder([0, 0, 3.0], "Z", rb - 2.5, body_height - 2.0);
housing -= cylinder([0, 0, body_height - 3.0], "Z", rr + 0.6, 12.0);
housing -= cylinder([0, 0, -15.0], "Z", 9.0, 20.0);
let grips = [];
for i in 0..12 {
    grips.push(box_centered(3.0, 2.0, 5.0).translate([rc, 0, body_height + 2.5]).rotate_z(i.to_float() * 30.0));
}
housing = housing - compound(grips);
// riser: stem, nozzle head and wiper flange inside the body
let top = body_height + 6.0 + pop_up;
let riser = cylinder([0, 0, 20.0], "Z", rr, top - 20.0) + cylinder([0, 0, 20.0], "Z", rb - 3.5, 3.0);
let head = cylinder([0, 0, top], "Z", rr + 1.0, 8.0).fillet(1.5, ">Z");
riser = riser + head;
riser -= box_from_corners([-6.0, 0, top + 2.0], [6.0, rr + 3.0, top + 3.2]);
riser -= cylinder([0, 0, 18.0], "Z", rr - 2.0, top - 16.0);
compound([housing, riser])
