// Shower drain hair catcher: 38 mm basket 25 mm deep with 2.5 mm holes in the floor and three rows in the wall, 60 mm rim and a lift tab
let basket_diameter = 38.0; // [25.0, 60.0] Basket diameter (mm)
let depth = 25.0; // [12.0, 40.0] Basket depth (mm)
let rim_diameter = 60.0; // [40.0, 90.0] Rim diameter (mm)
let hole = 2.5; // [1.5, 4.0] Hole diameter (mm)
const wall = 1.2;
let rb = basket_diameter / 2.0;
let rr = max(rim_diameter / 2.0, rb + 4.0);
let basket = cylinder([0, 0, -depth], "Z", rb, depth + 0.1) - cylinder([0, 0, -depth + wall], "Z", rb - wall, depth + 1.0);
let rim = cylinder(rr, 1.5) - cylinder([0, 0, -1.0], "Z", rb - wall, 3.5);
let tab = box_from_corners([-4.0, -0.75, 0], [4.0, 0.75, 10.0]).fillet(3.5, ">Z and |Y");
let part = fuse_all([basket, rim, tab.translate([0, rb - wall - 0.5, 0])]);
let holes = [];
let n = ((rb - wall - 2.0) / (hole + 1.5)).floor().to_int();
for i in 0..=n {
    let rad = i.to_float() * (hole + 1.5);
    let count = if i == 0 { 1 } else { (2.0 * PI() * rad / (hole + 1.5)).floor().to_int() };
    for j in 0..count {
        holes.push(cylinder([rad, 0, -depth - 1.0], "Z", hole / 2.0, wall + 2.0).rotate_z(j.to_float() * 360.0 / count.to_float()));
    }
}
let per_row = (2.0 * PI() * rb / (hole + 2.0)).floor().to_int();
for row in 0..3 {
    for j in 0..per_row {
        holes.push(cylinder([rb - wall - 1.0, 0, -depth + 5.0 + row.to_float() * (hole + 2.0)], "X", hole / 2.0, wall + 2.0)
            .rotate_z((j.to_float() + 0.5 * row.to_float()) * 360.0 / per_row.to_float()));
    }
}
part - compound(holes)
