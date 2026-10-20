// TO-220 heatsink clamp bar for two transistors: 34 x 8 x 4 mm bar, central M3 clearance hole 3.4 mm with 5.5 mm counterbore 1.5 mm, two 10 mm wide pressure pads 0.8 mm proud on 20 mm centres, end tabs relieved
let length = 34.0; // [24.0, 60.0] Bar length (mm)
let width = 8.0; // [6.0, 12.0] Bar width (mm)
let thick = 4.0; // [3.0, 6.0] Bar thickness (mm)
let pad_pitch = 20.0; // [14.0, 30.0] Pad centres (mm)
let pad_w = 10.0; // [6.0, 12.0] Pad width (mm)
let pad_h = 0.8; // [0.4, 1.5] Pad height (mm)
let pp = min(pad_pitch, length - pad_w);
let pw = min(pad_w, pp - 5.0);
let bar = box_centered(length, width, thick).translate([0, 0, pad_h + thick / 2.0]);
let bar = bar.fillet(1.0, bar.edges("|Z"));
let pads = [];
for x in [-pp / 2.0, pp / 2.0] {
    pads.push(box_centered(pw, width, pad_h + 0.5).translate([x, 0, (pad_h + 0.5) / 2.0]));
}
let body = fuse_all([bar] + pads);
let top = pad_h + thick;
body - cylinder([0, 0, -1], "Z", 1.7, top + 2.0) - cylinder([0, 0, top - 1.5], "Z", 2.75, 3.0)
