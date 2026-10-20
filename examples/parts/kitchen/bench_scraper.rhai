// Bench (dough) scraper: 150 x 115 mm stainless blade 1.2 mm thick with a bevelled cutting edge and centimetre ruler notches, rolled 30 mm handle along the top edge
let blade_width = 150.0; // [100.0, 200.0] Blade width (mm)
let blade_height = 115.0; // [70.0, 150.0] Blade height (mm)
let thickness = 1.2; // [0.8, 2.0] Blade thickness (mm)
let handle_height = 30.0; // [20.0, 45.0] Handle height (mm)
let handle_thickness = 20.0; // [14.0, 30.0] Handle thickness (mm)
let hw = blade_width / 2.0;
let blade = box_from_corners([-hw, -thickness / 2.0, 0], [hw, thickness / 2.0, blade_height]);
// edge bevel along the bottom
blade -= polygon("YZ", [[thickness / 2.0 + 0.01, -0.1], [thickness / 2.0 + 0.01, 3.0], [-thickness / 2.0 + 0.2, -0.1]]).to_face().extrude([blade_width + 2.0, 0, 0]).translate([-hw - 1.0, 0, 0]);
// ruler notches every 10 mm along the bottom of one face
let n = (blade_width / 10.0).floor().to_int();
for i in 1..n {
    let x = -hw + i.to_float() * 10.0;
    let l = if i % 5 == 0 { 10.0 } else { 5.0 };
    blade -= box_centered(0.6, 0.6, l).translate([x, -thickness / 2.0, 6.0 + l / 2.0]);
}
// handle: an oval tube wrapped over the top edge
let ht = handle_thickness / 2.0;
let handle = face(rect(plane([-hw, 0, blade_height + handle_height / 2.0 - 4.0], "X", [0, 1, 0]), handle_thickness - 0.2, handle_height - handle_thickness + 0.2).offset(ht - 0.2)).extrude([blade_width, 0, 0]);
handle = handle.fillet(3.0, "%CIRCLE or %BSPLINE");
blade + handle
