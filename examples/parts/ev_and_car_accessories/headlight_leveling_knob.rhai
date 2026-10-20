// Headlight aim adjuster thumb knob: 30 mm x 10 mm wheel with 10 scalloped grips, 12 mm hub 8 mm long, 6 mm D-shaft bore with a 4.6 mm flat, arrow mark on top
let knob_d = 30.0; // [20.0, 45.0] Knob diameter (mm)
let knob_h = 10.0; // [6.0, 16.0] Knob height (mm)
let grips = 10; // [6, 16] Number of grip scallops
let shaft = 6.0; // [4.0, 8.0] Shaft diameter (mm)
let flat = 4.6; // [3.0, 7.0] Across the flat (mm)

const hub_len = 8.0;
let r = knob_d / 2.0;
let wheel = cylinder([0, 0, hub_len], "Z", r, knob_h);
wheel = wheel.chamfer(0.8, wheel.edges("%CIRCLE"));
let scallop_r = min(PI() * knob_d / grips / 4.0, 3.5);
let cuts = [];
for i in 0..grips {
    let a = i * 2.0 * PI() / grips;
    cuts.push(cylinder([(r + scallop_r * 0.4) * cos(a), (r + scallop_r * 0.4) * sin(a), hub_len - 1.0], "Z", scallop_r, knob_h + 2.0));
}
wheel = wheel - compound(cuts);
let hub = cylinder([0, 0, 0], "Z", shaft / 2.0 + 3.0, hub_len + 1.0);
let knob = wheel + hub;
let f = min(flat, shaft - 0.4);
let bore = cylinder([0, 0, -1.0], "Z", shaft / 2.0, hub_len + knob_h - 1.5) - box_from_corners([f - shaft / 2.0, -shaft, -2.0], [shaft, shaft, hub_len + knob_h]);
let arrow = polygon([[r - 3.0, 0, 0], [r - 8.0, 2.5, 0], [r - 8.0, -2.5, 0]]).to_face().extrude([0, 0, 1.0]).translate([0, 0, hub_len + knob_h - 0.6]);
knob - bore - arrow
