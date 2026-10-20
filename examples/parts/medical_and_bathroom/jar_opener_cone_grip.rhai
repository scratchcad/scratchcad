// One-handed jar opener cone: fits lids 30 to 94 mm, 40 mm tall, 3 mm wall, 12 internal gripping ribs, ribbed outside for grip
let large_diameter = 100.0; // [70.0, 140.0] Large end outside diameter (mm)
let small_diameter = 36.0; // [24.0, 60.0] Small end outside diameter (mm)
let height = 40.0; // [25.0, 60.0] Height (mm)
let wall = 3.0; // [2.0, 5.0] Wall thickness (mm)
let ribs = 12; // [6, 24] Number of internal ribs
let R = large_diameter / 2.0;
let r = min(small_diameter / 2.0, R - 10.0);
let outer = cone(R, r, height);
let inner = cone(R - wall, r - wall, height).translate([0, 0, -wall]);
let shell = outer - inner;
let fins = [];
let slope = (R - r) / height;
for i in 0..ribs {
    let a = i.to_float() * 360.0 / ribs.to_float();
    fins.push(polygon([[R - wall - 4.0, 0, 0], [R - wall + 0.5, 0, 0], [r - wall + 0.5 + wall * slope, 0, height - 0.5], [r - wall - 4.0, 0, height - wall - 1.0]])
        .to_face().extrude([0, 2.0, 0]).translate([0, -1.0, 0]).rotate_z(a));
}
let body = fuse_all([shell] + fins) & cone(R, r, height);
let grooves = [];
for i in 0..24 {
    let a = i.to_float() * 15.0;
    grooves.push(polygon([[R + 0.6, 0, -1.0], [r + 0.6, 0, height + 1.0], [r - 0.8, 0, height + 1.0], [R - 0.8, 0, -1.0]]).to_face().extrude([0, 2.0, 0]).translate([0, -1.0, 0]).rotate_z(a));
}
body - compound(grooves)
