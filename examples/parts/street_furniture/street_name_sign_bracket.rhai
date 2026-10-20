// Street name plate wall bracket: 120 mm channel 30 mm wide, 3 mm section, holding a 3 mm plate in a 3.5 mm slot, with three 6.5 mm wall fixing holes and 15 mm stand-off
let length = 120.0; // [80.0, 200.0] Bracket length (mm)
let plate = 3.5; // [2.0, 6.0] Sign plate slot (mm)
const t = 3.0;
let back = box_from_corners([0, 0, 0], [length, t, 30.0]);
let arm = box_from_corners([0, t - 0.01, 0], [length, 15.0 + t, t]);
let slot_wall = box_from_corners([0, 15.0, 0], [length, 15.0 + 2.0 * t + plate, 30.0]) - box_from_corners([-1.0, 15.0 + t, t], [length + 1.0, 15.0 + t + plate, 31.0]);
let holes = [];
for x in [15.0, length / 2.0, length - 15.0] { holes.push(cylinder([x, -1.0, 18.0], "Y", 3.25, t + 2.0)); }
back + arm + slot_wall - fuse_all(holes)
