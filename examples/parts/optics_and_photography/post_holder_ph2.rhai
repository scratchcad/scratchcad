// Thorlabs PH2 post holder: 1/2 in post bore 50.8 mm (2 in) deep, 25.4 mm OD body, 1/4-20 tapped base, side boss with a knurled 8-32 locking thumbscrew
let height = 50.8; // [25.0, 100.0] Holder height (mm)
let body_diameter = 25.4; // [20.0, 32.0] Body diameter (mm)
let post_bore = 12.9; // [10.5, 13.5] Post bore diameter (mm)
let base_thickness = 6.4; // [4.0, 10.0] Base thickness below the bore (mm)
let r = body_diameter / 2.0;
let body = cylinder(r, height).chamfer(0.6, "%CIRCLE and >Z");
// side boss for the thumbscrew, 8 mm below the top
let zb = height - 8.0;
let boss = cylinder([r - 2.0, 0, zb], "X", 5.0, 5.0);
body = body + boss;
body -= cylinder([0, 0, base_thickness], "Z", post_bore / 2.0, height);
body -= cylinder([0, 0, -1.0], "Z", 2.55, base_thickness + 0.5);
body -= cylinder([r - 3.0, 0, zb], "X", 1.75, 7.0);
// thumbscrew: knurled knob and threaded shank, backed off 0.5 mm from the post bore
let knob = cylinder([r + 4.0, 0, zb], "X", 6.0, 6.0);
let knurls = [];
for i in 0..24 {
    knurls.push(cylinder([r + 3.5, 6.1, zb], "X", 0.6, 7.0).rotate([r, 0, zb], "X", i.to_float() * 15.0));
}
let shank = cylinder([post_bore / 2.0 + 0.5, 0, zb], "X", 1.6, r + 4.5 - post_bore / 2.0);
let thumbscrew = (knob.chamfer(0.5, "%CIRCLE and >X") - compound(knurls)) + shank;
compound([body, thumbscrew])
