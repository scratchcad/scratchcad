// Plano-convex lens, Thorlabs LA1131 class: 25.4 mm diameter, f = 50 mm in N-BK7 (n = 1.517, R = 25.8 mm), 2 mm edge thickness, 0.3 mm protective bevels
let diameter = 25.4; // [6.0, 50.8] Lens diameter (mm)
let focal_length = 50.0; // [20.0, 500.0] Focal length (mm)
let edge_thickness = 2.0; // [1.0, 5.0] Edge thickness (mm)
let refractive_index = 1.517; // [1.4, 1.9] Refractive index
let radius = focal_length * (refractive_index - 1.0);
let h = diameter / 2.0;
let rr = max(radius, h + 0.5);
let sag = rr - sqrt(rr * rr - h * h);
let centre = edge_thickness + sag;
print(`R = ${rr} mm, centre thickness = ${centre} mm`);
let blank = cylinder(h, centre + 1.0);
let lens = blank & sphere([0, 0, centre - rr], rr);
lens.chamfer(0.3, "<Z")
