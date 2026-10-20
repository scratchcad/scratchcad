// Bouldering chalk bucket shell: 110 mm diameter, 130 mm tall, 2.5 mm wall, 3 mm base, 5 mm rolled top rim, 18 mm brush holder tube 70 mm long on the side, two belt loop tabs at the back
let diameter = 110.0; // [80.0, 160.0] Diameter (mm)
let height = 130.0; // [80.0, 180.0] Height (mm)
let wall = 2.5; // [1.5, 4.0] Wall thickness (mm)
let brush_d = 18.0; // [12.0, 26.0] Brush holder bore (mm)
let brush_length = 70.0; // [40.0, 100.0] Brush holder length (mm)
const base_t = 3.0;
let r = diameter / 2.0;
let bucket = cylinder(r, height) - cylinder([0, 0, base_t], "Z", r - wall, height);
bucket = bucket + (cylinder([0, 0, height - 5.0], "Z", r + 2.5, 5.0) - cylinder([0, 0, height - 6.0], "Z", r - wall, 7.0));
let bl = min(brush_length, height - 10.0);
let rb = brush_d / 2.0 + 2.0;
let holder = cylinder([r + rb - wall, 0, height - bl - 5.0], "Z", rb, bl) - cylinder([r + rb - wall, 0, height - bl - 3.0], "Z", brush_d / 2.0, bl);
bucket = bucket + holder;
for z in [height * 0.3, height * 0.7] {
    let tab = box_from_corners([-r - 8.0, -25.0, z - 6.0], [-r + 3.0, 25.0, z + 6.0]) - box_from_corners([-r - 5.0, -20.0, z - 3.0], [-r + 1.0, 20.0, z + 3.0]);
    bucket = bucket + (tab - cylinder([0, 0, 0], "Z", r - wall, height));
}
bucket
