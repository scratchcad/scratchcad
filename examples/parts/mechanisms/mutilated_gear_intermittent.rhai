// Intermittent (mutilated) drive wheel: 40 mm, 6 pins of 4 mm on a 90 degree sector, 6 mm plate, 6 mm bore
let diameter = 40.0; // [25.0, 80.0] Wheel diameter (mm)
let pins = 6; // [2, 12] Pin count
let sector = 90.0; // [30.0, 180.0] Pin sector (degrees)
let t = 6.0; // [3.0, 10.0] Plate thickness (mm)
let plate = cylinder(diameter / 2.0, t);
let ps = [];
for i in 0..pins {
    let a = (i.to_float() * sector / (pins - 1).to_float()) * PI() / 180.0;
    ps.push(cylinder([(diameter / 2.0 - 4.0) * a.cos(), (diameter / 2.0 - 4.0) * a.sin(), t - 0.01], "Z", 2.0, 6.0));
}
plate + fuse_all(ps) - cylinder([0, 0, -1], "Z", 3.0, t + 2.0)
