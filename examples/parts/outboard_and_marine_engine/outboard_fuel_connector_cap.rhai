// Outboard fuel connector dust cap for a 1/4 in engine-side quick connector: 18.5 mm bore 20 mm deep, 23 mm OD with eight 1 mm grip ribs, 3 mm closed end, and a 2 mm tether tab 25 mm long with a 6 mm hole to loop over the hose
let bore = 18.5; // [12.0, 26.0] Connector diameter (mm)
let depth = 20.0; // [12.0, 30.0] Cap depth (mm)
let tab_len = 25.0; // [15.0, 40.0] Tether tab length (mm)
const wall = 2.25;
const end_t = 3.0;
let ri = bore / 2.0;
let ro = ri + wall;
let h = depth + end_t;
let body = cylinder([0, 0, 0], "Z", ro, h);
let body = body.chamfer(0.8, body.edges(">Z"));
let parts = [body];
for i in 0..8 {
    parts.push(box_centered(1.6, 2.0, h - 4.0).translate([ro, 0, (h - 4.0) / 2.0 + 1.0]).rotate_z(i.to_float() * 45.0 + 22.5));
}
let tab = box_from_corners([0, -5.0, 0], [ro + tab_len, 5.0, 2.0]);
let tab = tab.fillet(4.9, tab.edges("|Z and >X"));
parts.push(tab);
let cuts = [cylinder([0, 0, -1.0], "Z", ri, depth + 1.0), cylinder([ro + tab_len - 5.0, 0, -1.0], "Z", 3.0, 4.0)];
fuse_all(parts) - fuse_all(cuts)
