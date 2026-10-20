// SOIC-8: 4.9 x 3.9 x 1.5 mm body, 8 gull-wing leads 0.42 x 0.2 mm at 1.27 mm pitch, 6.0 mm overall width
let length = 4.9; // [4.8, 5.0] Body length (mm)
let width = 3.9; // [3.8, 4.0] Body width (mm)
let height = 1.5; // [1.35, 1.75] Body height (mm)
let span = 6.0; // [5.8, 6.2] Overall width over the leads (mm)
let body = box_centered(length, width, height).translate([0, 0, 0.1 + height / 2.0]) - cylinder([-length / 2.0 + 0.7, -width / 2.0 + 0.7, 0.1 + height - 0.1], "Z", 0.3, 1.0);
let legs = [];
for i in 0..4 { for s in [-1, 1] {
    let x = -1.905 + i.to_float() * 1.27;
    let gull = sketch("YZ").move_to(width / 2.0 - 0.1, 0.65).hline_to(width / 2.0 + 0.4).line_to(width / 2.0 + 0.6, 0.0).hline_to(span / 2.0).vline_to(0.2).hline_to(width / 2.0 + 0.75).line_to(width / 2.0 + 0.55, 0.85).hline_to(width / 2.0 - 0.1).close().to_face().extrude([0.42, 0, 0]).translate([x - 0.21, 0, 0]);
    legs.push(if s > 0 { gull } else { gull.mirror("XZ") });
} }
fuse_all([body] + legs)
