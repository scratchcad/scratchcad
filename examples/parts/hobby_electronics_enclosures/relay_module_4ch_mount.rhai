// Mounting plate for a 4-channel 5 V relay module (75 x 55 mm PCB, M3 holes 3.1 mm on 69.5 x 49.5 mm): 85 x 65 x 2.5 mm plate, 4 standoffs 7 mm tall 6 mm OD, 3 cooling slots under the relays, 4 x 4.5 mm screw tabs, wire tie slots
let board_l = 75.0; // [50.0, 120.0] Board length (mm)
let board_w = 55.0; // [30.0, 80.0] Board width (mm)
let inset = 2.75; // [2.0, 5.0] Hole inset from the board edge (mm)
let standoff = 7.0; // [4.0, 15.0] Standoff height (mm)
let thick = 2.5; // [2.0, 4.0] Plate thickness (mm)
let slots = 3; // [0, 6] Number of cooling slots
let pl = board_l + 10.0;
let pw = board_w + 10.0;
let plate = box_centered(pl, pw, thick).translate([0, 0, thick / 2.0]);
let plate = plate.fillet(4.0, plate.edges("|Z"));
let tabs = box_centered(pl + 20.0, 14.0, thick).translate([0, 0, thick / 2.0]);
let tabs = tabs.fillet(6.5, tabs.edges("|Z"));
let parts = [plate, tabs];
let drills = [];
let hx = board_l / 2.0 - inset;
let hy = board_w / 2.0 - inset;
for x in [-hx, hx] {
    for y in [-hy, hy] {
        parts.push(cylinder([x, y, thick - 0.5], "Z", 3.0, standoff + 0.5));
        drills.push(cylinder([x, y, 1.0], "Z", 1.25, standoff + thick));
    }
}
let cuts = [];
let sl = board_l - 24.0;
let usable = 2.0 * hy - 16.0;
let n = min(slots, (usable / 6.0).floor().to_int());
for k in 0..n {
    let y = -hy + 8.0 + (k.to_float() + 0.5) * usable / n.to_float();
    cuts.push(box_centered(sl, 3.0, thick + 2.0).translate([0, y, thick / 2.0]));
}
for x in [-pl / 2.0 - 5.0, pl / 2.0 + 5.0] {
    drills.push(cylinder([x, 0, -1], "Z", 2.25, thick + 2.0));
}
for x in [-pl / 2.0 + 2.5, pl / 2.0 - 2.5] {
    cuts.push(box_centered(1.6, 4.0, thick + 2.0).translate([x, pw / 4.0, thick / 2.0]));
    cuts.push(box_centered(1.6, 4.0, thick + 2.0).translate([x, -pw / 4.0, thick / 2.0]));
}
fuse_all(parts) - fuse_all(cuts) - compound(drills)
