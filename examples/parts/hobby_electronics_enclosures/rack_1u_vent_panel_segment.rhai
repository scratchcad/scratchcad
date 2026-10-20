// 19 in 1U vented front panel, left third for printing: 482.6 / 3 = 160.9 mm wide, 43.6 mm tall, 3 mm thick, 6.5 x 10 mm ear slots on 31.75 mm centres 8.75 mm from the edge, 12 vent slots 4 x 26 mm, 10 mm rear return flanges, joining tab with 2 M3 holes
let width = 160.9; // [100.0, 241.3] Segment width (mm)
let height = 43.6; // [40.0, 44.45] Panel height (mm)
let thick = 3.0; // [2.0, 4.0] Panel thickness (mm)
let vents = 12; // [4, 24] Number of vent slots
let vent_w = 4.0; // [2.5, 6.0] Vent slot width (mm)
let vent_len = 26.0; // [15.0, 32.0] Vent slot length (mm)
let flange = 10.0; // [0.0, 20.0] Rear flange depth (mm)
const ear = 8.75;
const hole_pitch = 31.75;
let panel = box_from_corners([0, 0, 0], [width, height, thick]);
let shapes = [panel];
if flange > 0.5 {
    shapes.push(box_from_corners([25.0, 0, thick - 0.5], [width, 2.0, thick + flange]));
    shapes.push(box_from_corners([25.0, height - 2.0, thick - 0.5], [width, height, thick + flange]));
}
shapes.push(box_from_corners([width - 12.0, 10.0, thick - 0.5], [width, height - 10.0, thick + 8.0]));
let body = fuse_all(shapes);
let cuts = [];
for y in [height / 2.0 - hole_pitch / 2.0, height / 2.0 + hole_pitch / 2.0] {
    cuts.push(box_centered(3.5, 6.5, thick + 2.0).translate([ear, y, thick / 2.0]) + cylinder([ear - 1.75, y, -1], "Z", 3.25, thick + 2.0) + cylinder([ear + 1.75, y, -1], "Z", 3.25, thick + 2.0));
}
let vl = min(vent_len, height - 14.0);
const x0 = 30.0;
let span = width - 20.0 - x0;
let step = span / vents.to_float();
let vw = min(vent_w, step - 1.5);
for k in 0..vents {
    let x = x0 + (k.to_float() + 0.5) * step;
    cuts.push(box_centered(vw, vl - vw, thick + 2.0).translate([x, height / 2.0, thick / 2.0]) + cylinder([x, height / 2.0 - (vl - vw) / 2.0, -1], "Z", vw / 2.0, thick + 2.0) + cylinder([x, height / 2.0 + (vl - vw) / 2.0, -1], "Z", vw / 2.0, thick + 2.0));
}
for y in [height / 2.0 - 7.0, height / 2.0 + 7.0] {
    cuts.push(cylinder([width - 13.0, y, thick + 4.0], "X", 1.6, 15.0));
}
body - compound(cuts)
