// Desk tape dispenser for 19 mm tape on a 25.4 mm core, two bodies: 140 x 50 mm weighted body with cheeks and 8 mm axle slots holding a roll up to 66 mm, serrated cutter with 12 teeth; plus a 25 mm hub with an 8 mm axle
let tape_w = 19.0; // [12.0, 25.0] Tape width (mm)
let roll_d = 66.0; // [50.0, 80.0] Largest roll diameter (mm)
let core = 25.4; // [25.0, 76.0] Tape core diameter (mm)
let length = 140.0; // [120.0, 180.0] Body length (mm)
let teeth = 12; // [6, 20] Number of cutter teeth

const cheek = 4.0;
const base_h = 18.0;
const axle = 8.0;
let rd = max(roll_d, core + 10.0);
let inner = tape_w + 3.0;
let w = inner + 2.0 * cheek;
const ax = 40.0;
let az = base_h + rd / 2.0 + 3.0;
let base = box_from_corners([0, -w / 2.0, 0], [length, w / 2.0, base_h]);
base = base.fillet(6.0, base.edges("|Y and <X"));
let cheeks = [];
for s in [-1.0, 1.0] {
    let y0 = if s < 0.0 { -w / 2.0 } else { inner / 2.0 };
    let c = cylinder([ax, y0, az], "Y", axle / 2.0 + 6.0, cheek) + box_from_corners([ax - axle / 2.0 - 6.0, y0, base_h - 1.0], [ax + axle / 2.0 + 6.0, y0 + cheek, az]);
    cheeks.push(c);
}
// cutter post at the front with teeth along its top edge
let post_h = base_h + rd * 0.35;
let post = box_from_corners([length - 14.0, -w / 2.0, base_h - 1.0], [length, w / 2.0, post_h]);
post = post.fillet(5.0, post.edges("|Y and <X and >Z"));
let tw = w / teeth;
let ts = [];
for i in 0..teeth {
    let y = -w / 2.0 + i * tw;
    ts.push(polygon([[length - 2.0, y, post_h - 0.5], [length - 2.0, y + tw, post_h - 0.5], [length - 2.0, y + tw / 2.0, post_h + 2.5]]).to_face().extrude([2.0, 0, 0]));
}
let body = fuse_all([base, fuse_all(cheeks), post, fuse_all(ts)]);
// roll well between the cheeks, axle slots from the top
body = body - cylinder([ax, -inner / 2.0, az], "Y", rd / 2.0 + 2.0, inner) - box_from_corners([ax - rd / 2.0 - 2.0, -inner / 2.0, az], [ax + rd / 2.0 + 2.0, inner / 2.0, az + rd]);
body = body - box_from_corners([ax - axle / 2.0 - 0.2, -w, az], [ax + axle / 2.0 + 0.2, w, az + 20.0]) - cylinder([ax, -w, az], "Y", axle / 2.0 + 0.2, 2.0 * w);
let ring = cylinder([0, 0, 0], "Z", core / 2.0 - 0.2, tape_w) - cylinder([0, 0, -1.0], "Z", core / 2.0 - 3.0, tape_w + 2.0);
let spokes = fuse_all([box_centered(core - 2.0, 2.0, tape_w).translate([0, 0, tape_w / 2.0]), box_centered(2.0, core - 2.0, tape_w).translate([0, 0, tape_w / 2.0])]);
let axle_pin = cylinder([0, 0, -cheek / 2.0 - 1.4], "Z", axle / 2.0, tape_w + cheek + 2.8 + 1.5);
let hub = fuse_all([ring, spokes, cylinder([0, 0, 0], "Z", axle / 2.0 + 2.0, tape_w), axle_pin]);
compound([body, hub.translate([length / 2.0 + 20.0, w / 2.0 + core / 2.0 + 10.0, cheek / 2.0 + 1.4])])
