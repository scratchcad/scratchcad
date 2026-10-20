// Rack for 24 microcentrifuge tubes 1.5 ml: 4 x 6 grid at 16 mm pitch, 3 mm top deck with 11.2 mm holes, middle deck 15 mm below with 6 mm holes for the conical tips, 2 mm skirt 35 mm tall
let rows = 4; // [2, 8] Number of rows
let cols = 6; // [2, 12] Number of columns
let pitch = 16.0; // [13.0, 22.0] Tube pitch (mm)
let hole_d = 11.2; // [9.0, 12.0] Top hole diameter (mm)
let height = 35.0; // [25.0, 50.0] Rack height (mm)
const deck = 3.0;
const skirt = 2.0;
let length = cols.to_float() * pitch + 8.0;
let width = rows.to_float() * pitch + 8.0;
let hd = min(hole_d, pitch - 2.5);
let outer = box_centered(length, width, height).translate([0, 0, height / 2.0]);
outer = outer.fillet(3.0, "|Z");
let rack = outer - box_centered(length - 2.0 * skirt, width - 2.0 * skirt, height - deck + 1.0).translate([0, 0, (height - deck - 1.0) / 2.0]);
let mid = box_centered(length - 2.0 * skirt + 1.0, width - 2.0 * skirt + 1.0, 2.0).translate([0, 0, height - deck - 15.0]);
rack = rack + mid;
// finger notches in the long skirts
rack = rack - cylinder([0, -width, 0], "Y", min(8.0, height - deck - 17.0), 2.0 * width);
let holes = [];
for i in 0..cols {
    for j in 0..rows {
        let x = (i.to_float() - (cols.to_float() - 1.0) / 2.0) * pitch;
        let y = (j.to_float() - (rows.to_float() - 1.0) / 2.0) * pitch;
        holes.push(cylinder([x, y, height - deck - 1.0], "Z", hd / 2.0, deck + 2.0));
        holes.push(cylinder([x, y, height - deck - 17.0], "Z", 3.0, 4.0));
    }
}
rack - compound(holes)
