// Trekking pole rubber boot tip: fits over an 11 mm carbide tip, 45 mm tall, 26 mm angled sole at 40 degrees with tread grooves
let socket_diameter = 11.0; // [8.0, 14.0] Socket diameter (mm)
let height = 45.0; // [30.0, 60.0] Height (mm)
let top_diameter = 17.0; // [14.0, 24.0] Top diameter (mm)
let foot_diameter = 26.0; // [20.0, 36.0] Foot diameter (mm)
let sole_angle = 40.0; // [0.0, 50.0] Sole angle (degrees)
let rt = top_diameter / 2.0;
let rf = foot_diameter / 2.0;
let body = sketch("XZ").move_to(0, -12.0).hline_to(rf).vline_to(8.0).line_to(rt + 1.0, height * 0.6).vline_to(height - 1.5).line_to(rt - 1.5, height).hline_to(0).close()
    .to_face().revolve("Z", 360);
for i in 0..3 {
    body -= torus(rt + 1.6, 0.8).translate([0, 0, height * 0.65 + i.to_float() * 4.0]);
}
// angled sole: everything below the plane through the axis at z = 0 goes
let sole_cut = box_centered(120.0, 120.0, 60.0).translate([0, 0, -30.0]).rotate_y(sole_angle);
body -= sole_cut;
let grooves = [];
for i in 0..5 {
    grooves.push(box_centered(1.6, 80.0, 3.0).translate([(i.to_float() - 2.0) * 5.0, 0, 0]).rotate_y(sole_angle));
}
body -= compound(grooves);
body - cylinder([0, 0, height * 0.35], "Z", socket_diameter / 2.0, height)
