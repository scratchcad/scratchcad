// Single-hole spring cord lock, assembled: 18 mm body 22 mm tall, 12 mm plunger with 16 mm button, 5 mm cord hole (spring omitted)
let body_diameter = 18.0; // [14.0, 26.0] Body diameter (mm)
let body_height = 22.0; // [16.0, 32.0] Body height (mm)
let plunger_diameter = 12.0; // [8.0, 18.0] Plunger diameter (mm)
let cord_hole = 5.0; // [3.0, 8.0] Cord hole diameter (mm)
let rb = body_diameter / 2.0;
let rp = min(plunger_diameter / 2.0, rb - 2.0);
let zh = body_height * 0.55;
let body = cylinder(rb, body_height).fillet(1.5, "<Z");
body -= cylinder([0, 0, 3.0], "Z", rp + 0.3, body_height);
body -= cylinder([-rb - 1.0, 0, zh], "X", cord_hole / 2.0, body_diameter + 2.0);
let ribs = [];
for i in 0..12 {
    ribs.push(box_centered(1.0, 1.2, body_height - 6.0).translate([rb, 0, body_height / 2.0 + 1.0]).rotate_z(i.to_float() * 30.0));
}
body = fuse_all([body] + ribs);
let plunger = cylinder([0, 0, 4.0], "Z", rp, body_height - 2.0) + cylinder([0, 0, body_height + 2.0], "Z", rp + 2.0, 4.0).fillet(1.0, ">Z");
plunger -= cylinder([-rp - 1.0, 0, zh + 2.0], "X", cord_hole / 2.0, 2.0 * rp + 2.0);
compound([body, plunger])
