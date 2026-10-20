// Blister pack holder rack: 8 slots 5 mm wide between 2.5 mm dividers 40 mm high with rounded tops, for standard 105 x 50 mm blister cards stood on end, on a 100 mm wide base 3 mm thick with 10 mm side rails tying the dividers together
let slots = 8; // [3, 14] Number of slots
let slot_w = 5.0; // [3.0, 8.0] Slot width (mm)
let rack_w = 100.0; // [70.0, 130.0] Rack width (mm)
let divider_h = 40.0; // [25.0, 60.0] Divider height (mm)
let divider_t = 2.5; // [1.5, 4.0] Divider thickness (mm)
const base_t = 3.0;
const rail_h = 10.0;
const rail_t = 3.0;
let pitch = slot_w + divider_t;
let length = slots * pitch + divider_t;
let parts = [
    box_from_corners([0, 0, 0], [rack_w, length, base_t]),
    box_from_corners([0, 0, 0], [rail_t, length, rail_h]),
    box_from_corners([rack_w - rail_t, 0, 0], [rack_w, length, rail_h]),
];
for i in 0..=slots {
    let y = i * pitch;
    let d = box_from_corners([1.5, y, base_t - 0.5], [rack_w - 1.5, y + divider_t, divider_h]);
    parts.push(d.fillet(divider_t * 0.4, d.edges("|X and >Z")));
}
fuse_all(parts)
