// Mop bucket wringer rim hook: 5 mm thick inverted J hook 30 mm wide that hangs the wringer on a bucket rim up to 12 mm thick, 35 mm drop on the outside leg with an M6 clamp screw hole (5 mm tapping), and a 40 mm mounting tab with two 6.5 mm bolt holes 20 mm apart
let rim_t = 12.0; // [6.0, 20.0] Bucket rim thickness (mm)
let drop = 35.0; // [20.0, 60.0] Outside leg drop (mm)
let width = 30.0; // [24.0, 45.0] Hook width (mm)
let tab_len = 40.0; // [32.0, 60.0] Mounting tab length (mm)
const t = 5.0;
let g = rim_t + 1.0;
let pts = [[-t, 0, -tab_len], [0, 0, -tab_len], [0, 0, 0], [g, 0, 0], [g, 0, -drop], [g + t, 0, -drop], [g + t, 0, t], [-t, 0, t]];
let hook = face(polygon(pts)).extrude([0, width, 0]).translate([0, -width / 2.0, 0]);
let hs = min(20.0, width - 13.0);
let cuts = [cylinder([g - 1.0, 0, -drop + 10.0], "X", 2.5, t + 2.0)];
for y in [-hs / 2.0, hs / 2.0] {
    cuts.push(cylinder([-t - 1.0, y, -tab_len + 10.0], "X", 3.25, t + 2.0));
}
hook - fuse_all(cuts)
