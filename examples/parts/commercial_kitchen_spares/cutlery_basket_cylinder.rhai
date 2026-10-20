// Dishwasher cutlery basket cylinder: 85 mm diameter, 140 mm tall perforated cup with 2 mm walls, seven 8 mm drain holes in the floor and eight 6 x 80 mm side slots
let dia = 85.0; // [70.0, 110.0] Cylinder diameter (mm)
let height = 140.0; // [100.0, 180.0] Cylinder height (mm)
let slots = 8; // [4, 12] Number of side slots
const wall = 2.0;
let r = dia / 2.0;
let cup = cylinder([0, 0, 0], "Z", r, height).shell(-wall, ">Z");
let cutters = [cylinder([0, 0, -1.0], "Z", 4.0, wall + 2.0)];
for i in 0..6 {
    let a = i.to_float() * 60.0 * PI() / 180.0;
    cutters.push(cylinder([r * 0.5 * cos(a), r * 0.5 * sin(a), -1.0], "Z", 4.0, wall + 2.0));
}
let slot_h = height - 60.0;
for i in 0..slots {
    cutters.push(box_from_corners([r - wall - 2.0, -3.0, 30.0], [r + 2.0, 3.0, 30.0 + slot_h]).rotate_z(i.to_float() * 360.0 / slots.to_float()));
}
cup - fuse_all(cutters)
