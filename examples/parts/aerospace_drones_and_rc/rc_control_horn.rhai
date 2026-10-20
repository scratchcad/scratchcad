// RC control horn: 15 x 8 x 1.5 mm base with two 1.8 mm screw holes, 1.5 mm horn 18 mm tall with three 1.2 mm clevis holes
let h = 18.0; // [10.0, 30.0] Horn height (mm)
let base = box_centered(15.0, 8.0, 1.5).translate([0, 0, 0.75]);
for x in [-5.5, 5.5] { base -= cylinder([x, 0, -1], "Z", 0.9, 4.0); }
let horn = polygon([[-6, 0, 1.4], [6, 0, 1.4], [2, 0, h + 1.5], [-1, 0, h + 1.5]]).to_face().extrude([0, 1.5, 0]).translate([0, -0.75, 0]);
for k in 0..3 { let z = h + 1.5 - 2.0 - k.to_float() * 3.5; horn -= cylinder([0.5 - (h + 1.5 - z) * 0.05, -2, z], "Y", 0.6, 4.0); }
base + horn
