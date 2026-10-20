// Bow handle for a 1/1 gastronorm lid: 120 mm long, 28 mm tall, 14 mm wide grip 8 mm thick, two 20 x 20 mm feet with M4 screw bosses (3.3 mm tap holes) at 100 mm centres
let length = 120.0; // [90.0, 160.0] Handle length (mm)
let height = 28.0; // [20.0, 40.0] Handle height (mm)
let grip_t = 8.0; // [6.0, 12.0] Grip bar thickness (mm)
const width = 14.0;
const leg_w = 10.0;
const pad = 20.0;
const pad_t = 4.0;
let bridge = box_from_corners([-length / 2.0, -width / 2.0, 0], [length / 2.0, width / 2.0, height]);
bridge = bridge.fillet(4.0, bridge.edges("|Y and >Z"));
bridge = bridge - box_from_corners([-length / 2.0 + leg_w, -width, -1.0], [length / 2.0 - leg_w, width, height - grip_t]);
let zi = height - grip_t;
bridge = bridge.fillet(2.0, bridge.edges("|Y").filter(|e| abs(e.center().z - zi) < 0.01));
let pitch = length - pad;
let parts = [bridge];
let holes = [];
for sx in [-1.0, 1.0] {
    parts.push(box_from_corners([sx * pitch / 2.0 - pad / 2.0, -pad / 2.0, 0], [sx * pitch / 2.0 + pad / 2.0, pad / 2.0, pad_t]));
    holes.push(cylinder([sx * pitch / 2.0, 0, -1.0], "Z", 1.65, 11.0));
}
fuse_all(parts) - compound(holes)
