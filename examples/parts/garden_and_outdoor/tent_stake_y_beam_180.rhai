// 180 mm aluminium Y-beam tent stake: three 9 mm fins 1.8 mm thick, 30 mm point, cord hook notch and 4 mm lanyard hole in the head
let length = 180.0; // [100.0, 300.0] Stake length (mm)
let fin = 9.0; // [6.0, 14.0] Fin height from the centre (mm)
let fin_thickness = 1.8; // [1.2, 3.0] Fin thickness (mm)
let point_length = 30.0; // [15.0, 60.0] Point length (mm)
let fins = [];
for i in 0..3 {
    fins.push(box_from_corners([-0.5, -fin_thickness / 2.0, 0], [fin, fin_thickness / 2.0, length]).rotate_z(90.0 + i.to_float() * 120.0));
}
let core = cylinder(fin_thickness * 0.9, length);
let stake = fuse_all(fins + [core]);
// point: intersect with a cone, the head flat on top
let tip = cone(0.3, fin + 1.0, point_length) + cylinder([0, 0, point_length - 0.01], "Z", fin + 1.0, length);
stake = stake & tip;
// hook notch in the upward fin near the head and a lanyard hole
stake -= box_from_corners([-2.0, fin - 3.5, length - 25.0], [2.0, fin + 1.0, length - 18.0]);
stake -= box_from_corners([-2.0, fin - 3.5, length - 25.0], [2.0, fin - 1.5, length - 14.0]);
stake -= cylinder([-3.0, 4.5, length - 8.0], "X", 2.0, 6.0);
stake.fillet(0.5, ">Z")
