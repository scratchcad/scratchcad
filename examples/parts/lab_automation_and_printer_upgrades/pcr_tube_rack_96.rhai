// 96-place rack for 0.2 ml PCR tubes and strips: SBS footprint 127.76 x 85.48 mm, 8 x 12 holes 6.3 mm at 9 mm pitch with A1 at 14.38 / 11.24 mm, 4 mm deck on a 2 mm skirt 20 mm tall
let hole_d = 6.3; // [5.5, 7.0] Tube hole diameter (mm)
let height = 20.0; // [12.0, 30.0] Rack height (mm)
let deck = 4.0; // [2.0, 6.0] Deck thickness (mm)
let rows = 8; // [1, 8] Number of rows used
let cols = 12; // [1, 12] Number of columns used
const sbs_l = 127.76;
const sbs_w = 85.48;
const pitch = 9.0;
const skirt = 2.0;
let rack = box_from_corners([0, 0, 0], [sbs_l, sbs_w, height]);
rack = rack.fillet(3.0, "|Z");
rack = rack - box_from_corners([skirt, skirt, -1], [sbs_l - skirt, sbs_w - skirt, height - deck]);
let holes = [];
for i in 0..cols {
    for j in 0..rows {
        holes.push(cylinder([14.38 + i.to_float() * pitch, sbs_w - 11.24 - j.to_float() * pitch, height - deck - 1.0], "Z", hole_d / 2.0, deck + 2.0));
    }
}
// corner chamfer marks the H12 corner
rack - compound(holes) - box_centered(8.0, 8.0, height * 3.0).rotate_z(45.0).translate([sbs_l, 0, 0])
