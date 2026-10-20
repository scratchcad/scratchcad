// Holder for two 18650 cells side by side
let cell_d = 18.6; // [18.0, 19.0] Cell diameter (mm)
let cell_l = 65.2; // [65.0, 70.0] Cell length (mm)
let clearance = 0.4; // [0.2, 1.0] Clearance (mm)
let wall = 1.6; // [1.2, 3.0] Wall thickness (mm)
let cells = 2; // [1, 4] Number of cells
let divider = 1.0; // [0.8, 2.0] Divider thickness (mm)
let slot_w = 8.0; // [4.0, 12.0] Contact tab slot width (mm)
let d = cell_d + 2.0 * clearance;
let l = cell_l + 2.0 * clearance;
let w = cells.to_float() * d + (cells - 1).to_float() * divider + 2.0 * wall;
let h = d * 0.6 + wall;
let body = box(w, l + 2.0 * wall, h).fillet(1.0, "|Z");
let cuts = [];
for i in 0..cells {
    let x = wall + d / 2.0 + i.to_float() * (d + divider);
    cuts.push(cylinder([x, wall, wall + d / 2.0], "Y", d / 2.0, l));
    cuts.push(box_centered(slot_w, wall * 3.0, h).translate([x, wall / 2.0, wall + h / 2.0 + 1.0]));
    cuts.push(box_centered(slot_w, wall * 3.0, h).translate([x, l + 1.5 * wall, wall + h / 2.0 + 1.0]));
    cuts.push(box_centered(d * 0.5, l * 0.6, wall * 3.0).translate([x, wall + l / 2.0, 0]));
}
body - fuse_all(cuts)
