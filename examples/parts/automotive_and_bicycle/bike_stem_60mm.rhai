// 60 mm MTB stem: 31.8 mm bar clamp with removable faceplate and four M5 bolts, 28.6 mm steerer clamp 40 mm tall with two pinch bolts
let reach = 60.0; // [35.0, 110.0] Reach (mm)
let bar = 31.8; // [25.4, 35.0] Bar clamp diameter (mm)
let stack = 40.0; // [35.0, 45.0] Steerer clamp height (mm)
const steerer = 28.6;
let zc = stack / 2.0;
let stem = cylinder(steerer / 2.0 + 5.0, stack) + box_from_corners([-steerer / 2.0 - 12.0, -8.0, 4.0], [-steerer / 2.0, 8.0, stack - 4.0]);
stem += box_from_corners([0, -11.0, zc - 12.0], [reach, 11.0, zc + 12.0]);
stem += cylinder([reach, -20.0, zc], "Y", bar / 2.0 + 5.0, 40.0);
for s in [-1.0, 1.0] { stem += box_from_corners([reach - 8.0, -20.0, zc + s * (bar / 2.0)], [reach + 8.0, 20.0, zc + s * (bar / 2.0 + 5.5)]); }
stem -= cylinder([0, 0, -1], "Z", steerer / 2.0, stack + 2.0);
stem -= cylinder([reach, -21.0, zc], "Y", bar / 2.0, 42.0);
stem -= box_from_corners([-steerer / 2.0 - 13.0, -1.0, -1.0], [-steerer / 2.0 + 1.0, 1.0, stack + 1.0]);
for z in [12.0, stack - 12.0] { stem -= cylinder([-steerer / 2.0 - 6.0, -9.0, z], "Y", 2.6, 18.0); }
stem -= box_from_corners([reach, -21.0, zc - bar / 2.0 - 7.0], [reach + 1.0, 21.0, zc + bar / 2.0 + 7.0]);
for s in [-1.0, 1.0] { for y in [-13.0, 13.0] { stem -= cylinder([reach - 10.0, y, zc + s * (bar / 2.0 + 2.6)], "X", 2.6, 20.0); } }
stem
