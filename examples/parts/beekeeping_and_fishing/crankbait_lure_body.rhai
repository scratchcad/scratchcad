// Crankbait lure body: 60 mm long, 20 mm deep, 14 mm wide, lip slot 1 mm, 2 hanger holes for split rings
let length = 60.0; // [35.0, 100.0] Body length (mm)
let depth = 20.0; // [10.0, 30.0] Body depth (mm)
let width = 14.0; // [8.0, 20.0] Body width (mm)
let sections = [];
for i in 0..=8 {
    let t = i.to_float() / 8.0;
    let s = (t * PI()).sin().max(0.15);
    sections.push(rect(plane([0, 0, t * length], [0, 0, 1]), width * s, depth * s));
}
let body = loft(sections, true);
let lip = box_centered(width * 0.5, 1.0, 8.0).translate([0, -depth * 0.1, 4.0]).rotate([0, 0, 4.0], "X", -30.0);
body - lip - cylinder([-width, -depth * 0.3, length * 0.45], "X", 0.8, width * 2.0) - cylinder([-width, -depth * 0.25, length * 0.85], "X", 0.8, width * 2.0)
