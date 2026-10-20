// Tube-style climbing belay device: 70 mm tall tapered body 52 mm wide at the top, 24 mm deep, two 11 x 18 mm rope slots with a 4 mm centre web for 8.5-11 mm ropes, 2.5 mm walls, 6 mm keeper-cable hole
let height = 70.0; // [55.0, 90.0] Height (mm)
let top_width = 52.0; // [44.0, 64.0] Width at the top (mm)
let bottom_width = 40.0; // [30.0, 56.0] Width at the bottom (mm)
let depth = 24.0; // [18.0, 32.0] Depth (mm)
let slot_w = 11.0; // [9.0, 14.0] Rope slot width (mm)
let slot_l = 18.0; // [12.0, 22.0] Rope slot length (mm)
const wall = 2.5;
let tw = top_width / 2.0;
let bw = min(bottom_width, top_width) / 2.0;
let side = polygon([[-bw, 0], [bw, 0], [tw, height], [-tw, height]]).to_face();
let body = side.rotate_x(90.0).extrude([0, depth, 0]).translate([0, -depth / 2.0, 0]);
body = body.fillet(4.0, "|Y");
let sl = max(min(slot_l, depth - 2.0 * wall), min(slot_w, bw - wall - 2.0) + 0.5);
let sw = min(slot_w, bw - wall - 2.0);
let slots = [];
for s in [-1.0, 1.0] {
    let cx = s * (sw / 2.0 + 2.0);
    slots.push(box_centered(sw, sl - sw, height + 2.0).translate([cx, 0, height / 2.0]) + cylinder([cx, -(sl - sw) / 2.0, -1.0], "Z", sw / 2.0, height + 2.0) + cylinder([cx, (sl - sw) / 2.0, -1.0], "Z", sw / 2.0, height + 2.0));
}
body = body - compound(slots);
body - cylinder([0, -depth, 8.0], "Y", 3.0, 2.0 * depth)
