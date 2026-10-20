// Cover retaining clip for 25 x 40 mm slotted wiring duct: U-clip 10 mm wide that snaps over the closed duct's 25 mm width, 1.6 mm legs 12 mm deep with 0.8 mm barbs, 2 mm bridge
let duct_width = 25.0; // [15.0, 100.0] Duct width (mm)
let leg_depth = 12.0; // [6.0, 20.0] Leg depth (mm)
let clip_width = 10.0; // [6.0, 20.0] Clip width (mm)
const wall = 1.6;
const top = 2.0;
const barb = 0.8;
let a = duct_width / 2.0 + 0.2;
let b = a + wall;
let profile = polygon([
    [-b, 0, 0], [-a + barb, 0, 0], [-a, 0, 1.5], [-a, 0, leg_depth],
    [a, 0, leg_depth], [a, 0, 1.5], [a - barb, 0, 0], [b, 0, 0],
    [b, 0, leg_depth + top], [-b, 0, leg_depth + top]]);
let clip = face(profile).extrude([0, clip_width, 0]);
clip.fillet(0.5, clip.edges("|Y and >Z"))
