// Bird and vermin guard for 100 mm vent outlets: 99 mm OD push-in spigot 40 mm with 2 mm wall and a 105 mm stop ring, 35 mm cage of 24 vertical bars with 6 mm gaps, 3 mm end disc with 6 mm slots
let spigot_d = 99.0; // [60.0, 160.0] Spigot outside diameter (mm)
let spigot_l = 40.0; // [25.0, 60.0] Spigot length (mm)
let cage_h = 35.0; // [20.0, 60.0] Cage height (mm)
let bar_count = 24; // [12, 36] Number of cage bars
const wall = 2.0;
const end_t = 3.0;
const gap_w = 6.0;
let ro = spigot_d / 2.0;
let ri = ro - wall;
let z0 = spigot_l;
let z1 = z0 + cage_h;
let body = cylinder(ro, z1) - cylinder([0, 0, -1], "Z", ri, z1 - end_t + 1.0);
body = body + (cylinder([0, 0, z0 - 3.0], "Z", ro + 3.0, 3.0) - cylinder([0, 0, z0 - 4.0], "Z", ri, 5.0));
// never more bars than leave 3 mm of bar between the gaps
let bars = min(bar_count, (2.0 * PI() * ri / (gap_w + 3.0)).floor().to_int());
let windows = [];
for k in 0..bars {
    windows.push(box_from_corners([ri - 1.0, -gap_w / 2.0, z0 + 3.0], [ro + 1.0, gap_w / 2.0, z1 - end_t - 3.0]).rotate_z((k.to_float() + 0.5) * 360.0 / bars.to_float()));
}
let slots = [];
let n = ((ri - 6.0) / 10.0).floor().to_int();
for i in 0..(2 * n + 1) {
    slots.push(box_centered(2.0 * ri, gap_w, end_t + 2.0).translate([0, (i - n).to_float() * 10.0, z1 - end_t / 2.0]));
}
let field = compound(slots) & cylinder([0, 0, z1 - end_t - 1.0], "Z", ri - 4.0, end_t + 2.0);
body - compound(windows) - field
