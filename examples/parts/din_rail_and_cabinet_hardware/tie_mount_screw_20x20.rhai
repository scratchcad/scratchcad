// Screw-on cable tie mount 20 x 20 mm: 2 mm base with 1 mm chamfered edges, raised 12 mm saddle 6 mm tall with a 5.2 x 2 mm tunnel for ties up to 4.8 mm, central 4.3 mm screw hole countersunk 90 degrees to 8 mm
let size = 20.0; // [15.0, 30.0] Base size (mm)
let tie_width = 5.2; // [3.0, 9.5] Tie slot width (mm)
let screw_d = 4.3; // [3.2, 5.3] Screw hole diameter (mm)
const base_t = 2.0;
const saddle_h = 6.0;
let base = box_centered(size, size, base_t).translate([0, 0, base_t / 2.0]);
let base = base.chamfer(0.8, base.edges(">Z"));
let saddle = box_centered(size * 0.6, size, saddle_h).translate([0, 0, saddle_h / 2.0]);
let saddle = saddle.chamfer(1.0, saddle.edges("|Y and >Z"));
let tunnel = box_centered(size * 0.6 + 2.0, tie_width, 2.0).translate([0, 0, base_t + 0.3 + 1.0]);
let tunnel2 = box_centered(tie_width, size + 2.0, 2.0).translate([0, 0, base_t + 0.3 + 1.0]);
let hole = cylinder([0, 0, -1.0], "Z", screw_d / 2.0, saddle_h + 2.0);
let sink = cone(screw_d / 2.0, screw_d / 2.0 + 2.5, 2.5).translate([0, 0, saddle_h - 2.5 + 0.01]);
base + saddle - fuse_all([tunnel, tunnel2]) - hole - sink
