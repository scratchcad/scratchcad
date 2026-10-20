// Tri-lobe fidget spinner: 608 bearing (22 mm) seats at the centre and on three lobes 30 mm out, 7 mm thick body with rounded edges
let reach = 30.0; // [24.0, 40.0] Lobe distance (mm)
let t = 7.0; // [7.0, 10.0] Thickness (mm)
let body = cylinder(15.0, t);
for k in 0..3 { body += (cylinder([reach, 0, 0], "Z", 14.5, t) + box_from_corners([0, -6.0, 0], [reach, 6.0, t])).rotate("Z", k.to_float() * 120.0); }
body = body.fillet(1.5, ">Z or <Z");
body -= cylinder([0, 0, -1], "Z", 11.05, t + 2.0);
for k in 0..3 { body -= cylinder([reach, 0, -1], "Z", 11.05, t + 2.0).rotate("Z", k.to_float() * 120.0); }
body
