// Sprayer bayonet nozzle cap to suit an 18 mm bayonet nozzle body: 27 mm cap 12 mm tall with an 18.4 mm bore 9 mm deep, two 4.5 mm entry slots leading to 90 degree locking grooves 2.8 mm high that take 2.5 mm lugs, a 3 mm top with an 11 mm hole for the spray tip, and two 4 mm grip wings 6 mm proud
let body_d = 18.4; // [14.4, 22.4] Bore for the nozzle body (mm)
let cap_d = 27.0; // [22.0, 34.0] Cap diameter (mm)
let cap_h = 12.0; // [10.0, 16.0] Cap height (mm)
let tip_hole = 11.0; // [6.0, 14.0] Tip hole diameter (mm)
let wing = 6.0; // [3.0, 10.0] Grip wing height (mm)
const top_t = 3.0;
const lug_proud = 2.5;
const slot_w = 4.5;
const groove_h = 2.8;
let rb = body_d / 2.0;
let rg = rb + lug_proud + 0.2;
let ro = max(cap_d / 2.0, rg + 1.8);
let depth = cap_h - top_t;
let parts = [cylinder(ro, cap_h)];
for s in [0.0, 180.0] {
    parts.push(box_from_corners([ro - 1.0, -2.0, 0], [ro + wing, 2.0, cap_h]).rotate_z(s + 90.0));
}
let cap = fuse_all(parts);
let gz = depth - groove_h - 1.5;
let groove = polygon([[rb - 0.5, 0, gz], [rg, 0, gz], [rg, 0, gz + groove_h], [rb - 0.5, 0, gz + groove_h]]).to_face().revolve("Z", 90.0);
let cutters = [
    cylinder([0, 0, -1.0], "Z", rb, depth + 1.0),
    cylinder([0, 0, depth - 1.0], "Z", min(tip_hole, body_d - 2.0) / 2.0, top_t + 2.0),
];
for s in [0.0, 180.0] {
    cutters.push(box_from_corners([rb - 0.5, -slot_w / 2.0, -1.0], [rg, slot_w / 2.0, gz + groove_h]).rotate_z(s));
    cutters.push(groove.rotate_z(s));
}
cap - fuse_all(cutters)
