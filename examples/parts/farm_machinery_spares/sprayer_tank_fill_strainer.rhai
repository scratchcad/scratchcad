// Sprayer tank fill basket strainer for a 150 mm fill hole: 146 mm basket 110 mm deep with a 2.5 mm wall and 3 mm floor, a 175 mm hanging flange 3 mm thick, 24 vertical drain slots 3 mm wide and 70 mm long around the wall, and a ring of 12 holes of 6 mm plus one centre hole in the floor
let basket_d = 146.0; // [100.0, 200.0] Basket diameter (mm)
let depth = 110.0; // [70.0, 160.0] Basket depth (mm)
let flange_d = 175.0; // [120.0, 240.0] Flange diameter (mm)
let slots = 24; // [12, 36] Number of wall slots
let slot_w = 3.0; // [2.0, 5.0] Slot width (mm)
const wall = 2.5;
const floor_t = 3.0;
const flange_t = 3.0;
let ro = basket_d / 2.0;
let ri = ro - wall;
let rf = max(flange_d / 2.0, ro + 10.0);
let h = floor_t + depth;
let basket = fuse_all([cylinder(ro, h), cylinder([0, 0, h - flange_t], "Z", rf, flange_t)]) - cylinder([0, 0, floor_t], "Z", ri, h);
let slot_len = depth - 40.0;
let cutters = [];
for i in 0..slots {
    cutters.push(box_from_corners([ri - 1.0, -slot_w / 2.0, floor_t + 15.0], [ro + 1.0, slot_w / 2.0, floor_t + 15.0 + slot_len]).rotate_z((i + 0.5) * 360.0 / slots));
}
cutters.push(cylinder([0, 0, -1.0], "Z", 3.0, floor_t + 2.0));
for i in 0..12 {
    let a = i * 30.0 * PI() / 180.0;
    cutters.push(cylinder([ri * 0.6 * cos(a), ri * 0.6 * sin(a), -1.0], "Z", 3.0, floor_t + 2.0));
}
basket - fuse_all(cutters)
