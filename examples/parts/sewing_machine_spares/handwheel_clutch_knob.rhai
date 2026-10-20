// Handwheel stop-motion clutch knob: 38 mm disc 10 mm thick with 18 V-serrations 1.2 mm deep round the rim, 22 mm recessed centre 2 mm deep, 8.2 mm bore through for the clamp screw, 3 mm drive pin hole 4 mm deep in the back on a 12 mm radius
let knob_d = 38.0; // [30.0, 50.0] Knob diameter (mm)
let thickness = 10.0; // [7.0, 14.0] Knob thickness (mm)
let serrations = 18; // [12, 30] Number of serrations
let bore = 8.2; // [6.0, 10.0] Screw bore (mm)
const depth = 1.2;
let r = knob_d / 2.0;
let knob = cylinder(r, thickness);
let knob = knob.chamfer(0.6, knob.edges(">Z or <Z"));
let cuts = [
    cylinder([0, 0, thickness - 2.0], "Z", min(11.0, r - 4.0), 3.0),
    cylinder([0, 0, -1.0], "Z", bore / 2.0, thickness + 2.0),
    cylinder([12.0, 0, -1.0], "Z", 1.5, 5.0),
];
let s = depth * sqrt(2.0);
for i in 0..serrations {
    let a = i.to_float() * 360.0 / serrations.to_float();
    cuts.push(box_centered(s, s, thickness + 2.0).rotate_z(45.0).translate([r, 0, thickness / 2.0]).rotate_z(a));
}
knob - fuse_all(cuts)
