// Harness frame buckle: 50 x 35 mm rectangular frame for 45 mm webbing, 5 mm thick, 5 mm side bars and a sliding-bar center bar
let webbing = 45.0; // [25.0, 50.0] Webbing width (mm)
let thickness = 5.0; // [3.0, 7.0] Thickness (mm)
let bar = 5.0; // [3.5, 7.0] Bar width (mm)
let slot = 5.0; // [3.0, 8.0] Slot width (mm)
let inner_w = webbing + 1.5;
let ow = inner_w + 2.0 * bar;
let oh = 3.0 * bar + 2.0 * slot;
let frame = box_centered(ow, oh, thickness).translate([0, 0, thickness / 2.0]);
let f = frame.fillet(2.0, frame.edges("|Z"));
let slots = [];
for s in [-1.0, 1.0] { slots.push(box_centered(inner_w, slot, thickness + 2.0).translate([0, s * (slot + bar) / 2.0, thickness / 2.0])); }
(f - compound(slots)).chamfer(0.6)
