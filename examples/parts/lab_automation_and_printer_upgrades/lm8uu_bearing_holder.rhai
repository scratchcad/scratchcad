// Snap-in holder for an LM8UU linear bearing (15 mm OD x 24 mm): 24 mm long saddle, 15.2 mm bore 11 mm above the base gripping past centre with a 11.4 mm mouth, 40 x 24 mm base flange 3 mm with 2 x M3 holes on 32 mm
let bearing_d = 15.2; // [10.2, 22.2] Bearing bore (mm)
let length = 24.0; // [17.0, 45.0] Holder length (mm)
let grip = 5.0; // [2.0, 6.0] Grip height past the centre (mm)
let hole_pitch = 32.0; // [28.0, 50.0] Mounting hole spacing (mm)
const base_t = 3.0;
const wall = 4.0;
let r = bearing_d / 2.0;
let g = min(grip, r * 0.8);
let zc = base_t + r + 0.5;
let half_w = r + wall;
let flange_w = max(hole_pitch + 8.0, 2.0 * half_w + 10.0);
let saddle = box_from_corners([0, -half_w, 0], [length, half_w, zc + g]);
saddle = saddle.fillet(2.0, saddle.edges("|X and >Z"));
let base = box_from_corners([0, -flange_w / 2.0, 0], [length, flange_w / 2.0, base_t]);
let holder = saddle + base - cylinder([-1, 0, zc], "X", r, length + 2.0);
let hp = max(hole_pitch, 2.0 * half_w + 4.0);
holder - cylinder([length / 2.0, -hp / 2.0, -1], "Z", 1.6, base_t + 2.0) - cylinder([length / 2.0, hp / 2.0, -1], "Z", 1.6, base_t + 2.0)
