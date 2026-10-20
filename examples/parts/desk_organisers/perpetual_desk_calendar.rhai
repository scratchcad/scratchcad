// Perpetual desk calendar, 3 bodies: two 30 mm day cubes with 1 mm label recesses front and back, and a 68 x 40 mm stand with a 6 mm month-card slot 14 mm deep, a cube lip and a back rest leaning 10 degrees
let cube = 30.0; // [20.0, 40.0] Day cube size (mm)
let lean = 10.0; // [0.0, 20.0] Lean back (degrees)
let month_h = 14.0; // [10.0, 20.0] Month card slot depth (mm)
let base_d = 40.0; // [30.0, 60.0] Stand depth (mm)
let wall = 3.0; // [2.0, 5.0] Stand wall (mm)

let cradle_w = 2.0 * cube + 2.0;
let w = cradle_w + 2.0 * wall;
let base_h = month_h + 4.0;
// stand: a base block with a pocket for the month bar in front and a cradle for the cubes on top
let stand = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, base_d, base_h]);
stand = stand.fillet(3.0, stand.edges("|Z"));
stand = stand - box_from_corners([-cradle_w / 2.0 + 2.0, 4.0, base_h - month_h], [cradle_w / 2.0 - 2.0, 4.0 + 6.0, base_h + 1.0]);
let back = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, wall, cube * 0.7]).rotate_x(-lean).translate([0, base_d - wall - 2.0, base_h - 1.0]);
let lip = box_from_corners([-w / 2.0, 12.0, base_h - 1.0], [w / 2.0, 12.0 + wall, base_h + 6.0]);
stand = fuse_all([stand, back, lip]);
// day cubes: two cubes with shallow recessed faces as digit-label pads
let mk = |cx| {
    let c = box_centered(cube, cube, cube).translate([cx, 0, cube / 2.0]);
    c = c.fillet(2.0);
    c - box_centered(cube * 0.6, 2.0, cube * 0.7).translate([cx, -cube / 2.0, cube / 2.0]) - box_centered(cube * 0.6, 2.0, cube * 0.7).translate([cx, cube / 2.0, cube / 2.0])
};
let y0 = base_d + cube / 2.0 + 10.0;
compound([stand, mk.call(-cube / 2.0 - 5.0).translate([0, y0, 0]), mk.call(cube / 2.0 + 5.0).translate([0, y0, 0])])
