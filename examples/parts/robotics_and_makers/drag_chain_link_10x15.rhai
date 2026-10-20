// Cable drag chain link, 10 x 15 mm inside: 20 mm link pitch, jogged 1.6 mm side plates (inner front end with a 3.2 mm pivot hole, outer rear end with an inward 3 mm pin), top and bottom crossbars
let inner_h = 10.0; // [7.0, 20.0] Inside height (mm)
let inner_w = 15.0; // [10.0, 40.0] Inside width (mm)
let pitch = 20.0; // [15.0, 30.0] Link pitch (mm)
const t = 1.6;
const bar = 2.0;
let h = inner_h + 2.0 * bar;
let yi = inner_w / 2.0;
let side = box_from_corners([0, yi, 0], [pitch * 0.55, yi + t, h]) + cylinder([0, yi, h / 2.0], "Y", h / 2.0, t)
    + box_from_corners([pitch * 0.45, yi + t - 0.01, 0], [pitch, yi + 2.0 * t, h]) + cylinder([pitch, yi + t - 0.01, h / 2.0], "Y", h / 2.0, t + 0.01)
    + cylinder([pitch, yi + t + 0.01, h / 2.0], "-Y", 1.5, t - 0.2);
side -= cylinder([0, yi - 1.0, h / 2.0], "Y", 1.6, t + 2.0);
let sides = side + side.mirror([0, 0, 0], [0, 1, 0]);
let bars = box_from_corners([pitch * 0.15, -yi - 0.01, 0], [pitch * 0.6, yi + 0.01, bar]) + box_from_corners([pitch * 0.15, -yi - 0.01, h - bar], [pitch * 0.6, yi + 0.01, h]);
sides + bars
