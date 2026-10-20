// Tin-plated lay-in grounding lug for 14-4 AWG (like ILSCO GBL-4): 15 mm wide, 19 mm tall, 25 mm long body, 7.5 mm open wire channel, 1/4-28 set screw on top, 5.2 mm #10 mounting hole
let width = 15.0; // [10.0, 25.0] Body width (mm)
let height = 19.0; // [12.0, 30.0] Body height (mm)
let length = 25.0; // [15.0, 40.0] Body length along the wire (mm)
let channel = 7.5; // [4.0, 12.0] Wire channel width (mm)
let ch = min(channel, width - 5.0);
let body = box_centered(width, length, height).translate([0, 0, height / 2.0]).fillet(1.0, "|Y");
let slot = box_from_corners([-width / 2.0 - 1.0, -length, 4.0], [width / 2.0 - (width - ch) / 2.0 + ch / 2.0 - ch / 2.0, length, 4.0 + ch]);
let channel_cut = box_from_corners([-width / 2.0 - 1.0, -length, 4.0], [ch / 2.0, length, 4.0 + ch]) + cylinder([ch / 2.0 - ch / 2.0, -length, 4.0 + ch / 2.0], "Y", ch / 2.0, 2.0 * length);
let lug = body - channel_cut;
lug -= cylinder([0, 0, 4.0 + ch * 0.5], "Z", 2.9, height);
lug -= cylinder([0, 0, -1], "Z", 2.6, 6.0);
let screw = cylinder([0, 0, height - 0.5], "Z", 3.17, 4.0) + (box_centered(1.2, 7.0, 2.0).translate([0, 0, height + 3.0]));
compound([lug, screw - box_centered(1.2, 7.0, 2.0).translate([0, 0, height + 3.4])])
