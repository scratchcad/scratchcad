// Stair nosing end cap: closes a 45 x 25 mm L-shaped aluminium nosing, 3 mm cap with 15 mm push-in tongues 1.5 mm thick for both legs
let leg_a = 45.0; // [30.0, 60.0] Tread leg (mm)
let leg_b = 25.0; // [15.0, 40.0] Riser leg (mm)
const t = 3.0;
const tongue = 15.0;
let cap = box_from_corners([0, 0, 0], [leg_a, t, 4.0]) + box_from_corners([0, 0, -leg_b], [4.0, t, 0.01]);
let tongues = box_from_corners([5.0, t - 0.01, 0.8], [leg_a - 3.0, t + tongue, 2.3]) + box_from_corners([0.8, t - 0.01, -leg_b + 3.0], [2.3, t + tongue, -1.0]);
cap + tongues
