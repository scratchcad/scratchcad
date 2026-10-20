// Plastic air brick 215 x 65 mm (one brick face): 8 mm face plate with a 4 x 15 grid of 10 mm square vents at 12.5 mm pitch, rear sleeve 205 x 55 mm 70 mm deep with 2.5 mm wall
let length = 215.0; // [150.0, 330.0] Face length (mm)
let height = 65.0; // [50.0, 110.0] Face height (mm)
let depth = 70.0; // [40.0, 110.0] Sleeve depth (mm)
let vent = 10.0; // [6.0, 10.0] Vent square size (mm)
const pitch = 12.5;
const face_t = 8.0;
const wall = 2.5;
let face = box_centered(length, height, face_t).translate([0, 0, face_t / 2.0]).chamfer(1.5, ">Z");
let sl = length - 10.0;
let sh = height - 10.0;
let sleeve = box_centered(sl, sh, depth).translate([0, 0, -depth / 2.0 + 0.5]) - box_centered(sl - 2.0 * wall, sh - 2.0 * wall, depth + 2.0).translate([0, 0, -depth / 2.0 - 1.0]);
let cols = ((sl - 2.0 * wall - 4.0) / pitch).floor().to_int();
let rows = ((sh - 2.0 * wall - 4.0) / pitch).floor().to_int();
let holes = [];
for i in 0..cols {
    for j in 0..rows {
        let x = (i.to_float() - (cols.to_float() - 1.0) / 2.0) * pitch;
        let y = (j.to_float() - (rows.to_float() - 1.0) / 2.0) * pitch;
        holes.push(box_centered(vent, vent, face_t + 2.0).translate([x, y, face_t / 2.0]));
    }
}
face + sleeve - compound(holes)
