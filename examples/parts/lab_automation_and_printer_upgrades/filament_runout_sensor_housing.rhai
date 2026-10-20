// Filament runout sensor housing for a KW10 micro switch: 45 x 26 x 22 mm body, 2.2 mm filament channel, M10 PC4 fitting bosses 16 mm dia 8 mm long with 8.5 mm tap holes at both ends, 20.5 x 10.5 mm switch pocket with 2 mm pins on 9.5 mm, lever window to the filament, 2 x M3 mounting holes
let length = 45.0; // [36.0, 70.0] Body length (mm)
let filament = 2.2; // [2.0, 3.4] Filament channel diameter (mm)
let boss_l = 8.0; // [5.0, 12.0] Fitting boss length (mm)
let tap = 8.5; // [6.0, 8.8] Fitting tap hole (mm)
const width = 26.0;
const height = 22.0;
const fy = 9.0;
const fz = 11.0;
let body = box_from_corners([0, 0, 0], [length, width, height]);
body = body.fillet(2.0, "|X");
let bosses = cylinder([-boss_l, fy, fz], "X", 8.0, boss_l + 0.5) + cylinder([length - 0.5, fy, fz], "X", 8.0, boss_l + 0.5);
let housing = body + bosses;
let cx = length / 2.0;
let cuts = [
    cylinder([-boss_l - 1.0, fy, fz], "X", filament / 2.0, length + 2.0 * boss_l + 2.0),
    cylinder([-boss_l - 1.0, fy, fz], "X", tap / 2.0, boss_l + 4.0),
    cylinder([length - 3.0, fy, fz], "X", tap / 2.0, boss_l + 4.0),
    box_from_corners([cx - 10.25, fy + 4.0, 4.0], [cx + 10.25, fy + 14.5, height + 1.0]),
    box_from_corners([cx - 6.0, fy - 1.0, fz - 2.0], [cx + 6.0, fy + 5.0, height + 1.0])
];
let pins = cylinder([cx - 4.75, fy + 9.25, 3.0], "Z", 1.0, 3.5) + cylinder([cx + 4.75, fy + 9.25, 3.0], "Z", 1.0, 3.5);
let mount = cylinder([5.0, width - 5.0, -1], "Z", 1.6, height + 2.0) + cylinder([length - 5.0, width - 5.0, -1], "Z", 1.6, height + 2.0);
housing - fuse_all(cuts) + pins - mount
