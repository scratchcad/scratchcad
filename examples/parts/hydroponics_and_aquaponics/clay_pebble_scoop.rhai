// Hydroponic clay pebble (LECA) scoop: 60 mm wide half-round trough 100 mm long with a 2 mm wall, a closed semicircular back plate, slotted drain holes in the trough floor, and a 100 mm flat handle 20 x 6 mm with a 6 mm hanging hole
let scoop_w = 60.0; // [40.0, 90.0] Scoop width (mm)
let scoop_len = 100.0; // [70.0, 150.0] Scoop length (mm)
let handle_len = 100.0; // [60.0, 150.0] Handle length (mm)
let drain_slots = 5; // [0, 9] Number of drain slots
const wall = 2.0;
let r = scoop_w / 2.0;
let trough = (cylinder([0, 0, r], "X", r, scoop_len) - cylinder([-1.0, 0, r], "X", r - wall, scoop_len + 2.0)) & box_from_corners([-1.0, -r - 1.0, -1.0], [scoop_len + 1.0, r + 1.0, r]);
let back = cylinder([0, 0, r], "X", r, wall) & box_from_corners([-1.0, -r - 1.0, -1.0], [wall + 1.0, r + 1.0, r]);
let handle = box_from_corners([-handle_len, -10.0, r - 6.0], [wall, 10.0, r]);
let handle = handle.fillet(4.0, handle.edges("|Z and <X"));
let body = fuse_all([trough, back, handle]);
let cuts = [cylinder([-handle_len + 10.0, 0, r - 7.0], "Z", 3.0, 8.0)];
let n = drain_slots;
for i in 0..n {
    let x = scoop_len * 0.2 + (scoop_len * 0.6) * (i.to_float() + 0.5) / n.to_float();
    cuts.push(box_centered(2.0, r * 0.6, 10.0).translate([x, 0, 2.0]));
}
body - fuse_all(cuts)
