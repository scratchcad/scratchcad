// Drying rack for 10 x 90 mm Petri dishes standing on edge: 200 x 100 mm base 4 mm, two 25 mm tall rails 10 mm thick 60 mm apart with 10 slots 15.5 mm wide (dish 14.2 mm) 18 mm deep on 19 mm pitch
let dishes = 10; // [3, 20] Number of dishes
let slot_w = 15.5; // [10.0, 20.0] Slot width (mm)
let pitch = 19.0; // [14.0, 30.0] Slot pitch (mm)
let rail_gap = 60.0; // [40.0, 80.0] Rail spacing (mm)
let rail_h = 25.0; // [15.0, 40.0] Rail height (mm)
const base_t = 4.0;
const rail_t = 10.0;
let sw = min(slot_w, pitch - 3.0);
let length = dishes.to_float() * pitch + 12.0;
let width = rail_gap + 2.0 * rail_t + 20.0;
let base = box_centered(length, width, base_t).translate([0, 0, base_t / 2.0]);
base = base.fillet(6.0, "|Z");
let rails = [];
for sy in [-1.0, 1.0] {
    rails.push(box_centered(length, rail_t, rail_h).translate([0, sy * (rail_gap + rail_t) / 2.0, base_t + rail_h / 2.0 - 0.5]));
}
let rack = fuse_all([base] + rails);
let slots = [];
let depth = min(18.0, rail_h - 3.0);
for i in 0..dishes {
    let x = (i.to_float() - (dishes.to_float() - 1.0) / 2.0) * pitch;
    slots.push(box_centered(sw, width + 2.0, depth + 1.0).translate([x, 0, base_t + rail_h - depth + (depth + 1.0) / 2.0 - 0.5]));
}
rack - compound(slots)
