// Robot vacuum drive wheel tyre: 72 mm OD 18 mm wide 4 mm thick tread band with chevron offset tread blocks 1.5 mm deep
let od = 72.0; // [55.0, 90.0] Tyre OD (mm)
let width = 18.0; // [12.0, 25.0] Tyre width (mm)
let t = 4.0; // [3.0, 6.0] Tread thickness (mm)
let band = cylinder(od / 2.0, width) - cylinder([0, 0, -1], "Z", od / 2.0 - t, width + 2.0);
let grooves = [];
for k in 0..24 {
    let g = box_centered(2.0, 8.0, 1.5 * 2.0).rotate_x(90.0).rotate_z(30.0).translate([od / 2.0, -2.0, width * 0.3]) + box_centered(2.0, 8.0, 1.5 * 2.0).rotate_x(90.0).rotate_z(-30.0).translate([od / 2.0, 2.0, width * 0.7]);
    grooves.push(g.rotate_z(k.to_float() * 15.0));
}
band - fuse_all(grooves)
