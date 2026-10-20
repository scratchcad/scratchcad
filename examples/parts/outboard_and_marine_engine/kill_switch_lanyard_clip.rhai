// Outboard kill switch lanyard clip: 3 mm thick horseshoe 30 mm round with a 9.5 mm slot that slides under the stop button, 2 mm chamfer at the slot mouth, and a 20 mm tail with a 5 mm hole for the lanyard cord, 2 mm rounded tail end
let clip_d = 30.0; // [24.0, 40.0] Clip diameter (mm)
let slot_w = 9.5; // [6.0, 14.0] Slot width (mm)
let thickness = 3.0; // [2.0, 4.5] Clip thickness (mm)
let tail_len = 20.0; // [12.0, 35.0] Tail length (mm)
let r = clip_d / 2.0;
let disc = cylinder([0, 0, 0], "Z", r, thickness);
let tail = box_from_corners([-6.0, -r - tail_len, 0], [6.0, 0, thickness]);
let tail = tail.fillet(2.0, tail.edges("|Z and <Y"));
let body = disc + tail;
let sw = min(slot_w, clip_d - 12.0);
let mouth = face(polygon([[-sw / 2.0 - 2.0, r + 1.0, 0], [sw / 2.0 + 2.0, r + 1.0, 0], [sw / 2.0, r - 2.0, 0], [-sw / 2.0, r - 2.0, 0]])).extrude([0, 0, thickness + 2.0]).translate([0, 0, -1.0]);
let cuts = [
    box_from_corners([-sw / 2.0, 0, -1.0], [sw / 2.0, r + 1.0, thickness + 1.0]),
    cylinder([0, 0, -1.0], "Z", sw / 2.0, thickness + 2.0),
    mouth,
    cylinder([0, -r - tail_len + 6.0, -1.0], "Z", 2.5, thickness + 2.0)
];
body - fuse_all(cuts)
