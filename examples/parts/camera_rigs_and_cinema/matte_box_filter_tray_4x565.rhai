// Matte box filter tray for 4 x 5.65 in filters (101.6 x 143.7 x 2 mm): 112 x 165 x 5 mm frame with a 102.2 x 144.3 mm pocket 2.4 mm deep, 94 x 136 mm clear window, 2 mm corner relief holes and a 30 x 12 mm finger pull tab with a 20 mm lip at the top
let filter_w = 101.6; // [76.2, 102.0] Filter width (mm)
let filter_h = 143.7; // [100.0, 150.0] Filter height (mm)
let filter_t = 2.0; // [1.0, 4.0] Filter thickness (mm)
const frame_t = 5.0;
const border = 5.0;
let w = filter_w + 2.0 * border;
let h = filter_h + 2.0 * border;
let frame = box_centered(w, h, frame_t).translate([0, 0, frame_t / 2.0]);
let frame = frame.fillet(2.0, frame.edges("|Z"));
let tab = box_from_corners([-15.0, h / 2.0 - 0.5, 0], [15.0, h / 2.0 + 12.0, frame_t]);
let tab = tab.fillet(3.0, tab.edges("|Z and >Y"));
let pocket = box_centered(filter_w + 0.6, filter_h + 0.6, filter_t + 1.0).translate([0, 0, frame_t - (filter_t + 0.4) + (filter_t + 1.0) / 2.0]);
let window = box_centered(filter_w - 7.6, filter_h - 7.7, frame_t + 2.0).translate([0, 0, frame_t / 2.0]);
let corners = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        corners.push(cylinder([sx * (filter_w + 0.6) / 2.0, sy * (filter_h + 0.6) / 2.0, frame_t - filter_t - 0.4], "Z", 1.0, filter_t + 1.0));
    }
}
let pull = box_from_corners([-10.0, h / 2.0 + 4.0, -1.0], [10.0, h / 2.0 + 8.0, frame_t + 1.0]);
frame + tab - pocket - fuse_all(corners) - window - pull
