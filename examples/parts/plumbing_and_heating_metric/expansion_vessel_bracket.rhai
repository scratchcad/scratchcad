// Heating expansion vessel wall bracket for 8 to 12 L vessels: 3 mm steel, 60 x 110 mm backplate, 70 mm shelf with 27 mm hole for the 3/4 in BSP connection, two 8 mm fixing slots, folded side cheeks
let width = 60.0; // [45.0, 90.0] Bracket width (mm)
let back_h = 110.0; // [80.0, 160.0] Backplate height (mm)
let shelf = 70.0; // [50.0, 100.0] Shelf depth (mm)
let thick = 3.0; // [2.0, 4.0] Steel thickness (mm)
let port = 27.0; // [20.0, 34.0] Connection hole diameter (mm)
let back = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, thick, back_h]);
let shelf_p = box_from_corners([-width / 2.0, 0, back_h - thick], [width / 2.0, shelf, back_h]);
let shelf_p = shelf_p.fillet(min(width * 0.3, 15.0), shelf_p.edges("|Z and >Y"));
let cheeks = [];
for x in [-width / 2.0, width / 2.0 - thick] {
    cheeks.push(polygon([[x, thick, back_h - thick], [x, shelf * 0.7, back_h - thick], [x, thick, back_h * 0.45]]).to_face().extrude([thick, 0, 0]));
}
let port_y = thick + (shelf - thick) * 0.6;
let cuts = [cylinder([0, port_y, back_h - thick - 1.0], "Z", min(port / 2.0, width / 2.0 - thick - 3.0), thick + 2.0)];
for z in [back_h * 0.25, back_h * 0.6] {
    cuts.push(box_centered(8.0, thick + 2.0, 6.0).translate([0, thick / 2.0, z]) + cylinder([0, -1, z - 3.0], "Y", 4.0, thick + 2.0) + cylinder([0, -1, z + 3.0], "Y", 4.0, thick + 2.0));
}
fuse_all([back, shelf_p] + cheeks) - compound(cuts)
