// Hydroponic 2 inch net pot: 50 mm inside at the rim, 50 mm tall, tapering to a 38 mm base, 1.5 mm wall, a 6 mm wide rim lip 2 mm thick, 12 vertical side slots 3 mm wide and four radial slots in the 2 mm floor
let top_d = 50.0; // [40.0, 76.0] Inside diameter at the rim (mm)
let height = 50.0; // [35.0, 80.0] Pot height (mm)
let slots = 12; // [6, 24] Number of side slots
let slot_w = 3.0; // [2.0, 5.0] Slot width (mm)
const wall = 1.5;
const floor_t = 2.0;
const lip_w = 6.0;
const lip_t = 2.0;
let rt = top_d / 2.0 + wall;
let rb = rt * 0.76;
let profile = polygon([
    [0, 0, 0], [rb, 0, 0], [rt, 0, height - lip_t], [rt + lip_w, 0, height - lip_t], [rt + lip_w, 0, height],
    [rt - wall, 0, height], [rb - wall, 0, floor_t], [0, 0, floor_t]]);
let pot = face(profile).revolve("Z", 360.0);
let sw = min(slot_w, 0.45 * 2.0 * PI() * (rb - wall) / slots.to_float());
let z0 = floor_t + 3.0;
let z1 = height - lip_t - 4.0;
let cuts = [];
for i in 0..slots {
    let a = i.to_float() * 360.0 / slots.to_float();
    cuts.push(box_from_corners([rb - wall - 4.0, -sw / 2.0, z0], [rt + 2.0, sw / 2.0, z1]).rotate_z(a));
}
for i in 0..4 {
    cuts.push(box_from_corners([5.0, -sw / 2.0, -1.0], [rb - wall - 2.0, sw / 2.0, floor_t + 1.0]).rotate_z(i.to_float() * 90.0 + 45.0 / 2.0));
}
pot - fuse_all(cuts)
