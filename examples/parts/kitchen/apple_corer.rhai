// Apple corer: 20 mm stainless tube 90 mm long with a serrated cutting edge (8 teeth), 0.8 mm wall, T-handle 110 mm wide with rounded grips, slot to push the core out
let tube_diameter = 20.0; // [14.0, 28.0] Tube diameter (mm)
let tube_length = 90.0; // [60.0, 130.0] Tube length (mm)
let wall = 0.8; // [0.5, 1.5] Tube wall (mm)
let teeth = 8; // [0, 16] Number of teeth
let handle_width = 110.0; // [80.0, 150.0] Handle width (mm)
let r = tube_diameter / 2.0;
let tube = cylinder(r, tube_length + 0.1) - cylinder([0, 0, -1.0], "Z", r - wall, tube_length + 3.0);
// teeth: V notches round the cutting end
let cuts = [];
for i in 0..teeth {
    let v = polygon("XZ", [[r - 3.0, -0.1], [r + 3.0, -0.1], [r + 3.0, 4.0]]).to_face().extrude([0, 3.0, 0]).translate([0, -1.5, 0]);
    cuts.push(v.rotate_z(i.to_float() * 360.0 / teeth.to_float()));
}
if teeth > 0 { tube = tube - compound(cuts); }
// side slot to push the core out
tube -= box_centered(6.0, 2.0 * r, tube_length * 0.55).translate([0, r, tube_length * 0.45]);
// T-handle on top
let grip = cylinder([-handle_width / 2.0, 0, tube_length + 8.0], "X", 9.0, handle_width).fillet(6.0, "%CIRCLE");
let hub = cylinder([0, 0, tube_length - 6.0], "Z", r + 3.0, 14.0) - cylinder([0, 0, tube_length - 7.0], "Z", r - wall, 6.0);
fuse_all([tube, hub, grip])
