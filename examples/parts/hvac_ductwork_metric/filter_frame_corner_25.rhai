// Corner key for 25 mm deep panel filter frames: two 40 mm legs 21 x 6.5 mm that push into the hollow frame profile, 3 barb ribs per leg, 25 x 25 mm corner block 6.5 mm thick with a 1 mm lip
let leg = 40.0; // [25.0, 60.0] Leg length (mm)
let leg_w = 21.0; // [15.0, 23.0] Leg width (mm)
let leg_t = 6.5; // [4.0, 8.0] Leg thickness (mm)
let barbs = 3; // [1, 5] Number of barb ribs per leg
const block = 25.0;
const lip = 1.0;
let w = leg_w;
let corner = box_from_corners([0, 0, 0], [block, block, leg_t + 2.0 * lip]);
let leg_x = box_from_corners([block - 0.5, (block - w) / 2.0, lip], [block + leg, (block + w) / 2.0, leg_t + lip]);
let leg_y = box_from_corners([(block - w) / 2.0, block - 0.5, lip], [(block + w) / 2.0, block + leg, leg_t + lip]);
let ribs = [];
let pitch = leg / (barbs.to_float() + 1.0);
for i in 1..=barbs {
    let d = block + i.to_float() * pitch;
    ribs.push(box_from_corners([d - 1.0, (block - w) / 2.0 - 0.6, lip + 1.0], [d + 1.0, (block + w) / 2.0 + 0.6, leg_t + lip - 1.0]));
    ribs.push(box_from_corners([(block - w) / 2.0 - 0.6, d - 1.0, lip + 1.0], [(block + w) / 2.0 + 0.6, d + 1.0, leg_t + lip - 1.0]));
}
let key = fuse_all([corner, leg_x, leg_y] + ribs);
key - cylinder([block / 2.0, block / 2.0, -1], "Z", 2.0, leg_t + 2.0 * lip + 2.0)
