// Western plate belt buckle for a 38 mm (1.5 in) belt: 75 x 55 mm oval plate 3 mm thick with a domed 1.5 mm raised centre, 40 mm belt bridge 5 mm off the back and a 9 mm mushroom hook stud
let plate_length = 75.0; // [55.0, 95.0] Plate length (mm)
let plate_width = 55.0; // [40.0, 70.0] Plate width (mm)
let plate_thickness = 3.0; // [2.0, 5.0] Plate thickness (mm)
let dome = 1.5; // [0.5, 4.0] Centre dome height (mm)
let belt_width = 38.0; // [25.0, 45.0] Belt width (mm)
fn oval(a, b, z) {
    let pts = [];
    for i in 0..36 {
        let t = i.to_float() * 10.0 * PI() / 180.0;
        pts.push([a * t.cos(), b * t.sin(), z]);
    }
    wire([spline(pts, true)])
}
let a = plate_length / 2.0;
let b = plate_width / 2.0;
let t = plate_thickness;
let plate = loft([oval(a, b, 0), oval(a - 0.6, b - 0.6, t / 2.0), oval(a - 2.0, b - 2.0, t)], true);
// raised dome in the middle of the face, sunk 0.2 mm into the plate
let raised = loft([oval(a * 0.7, b * 0.7, t - 0.2), oval(a * 0.62, b * 0.62, t + dome * 0.6), oval(a * 0.45, b * 0.45, t + dome)], true);
// belt bridge on the -X side of the back, hook stud on the +X side
let bw = min(belt_width + 2.0, plate_width - 8.0);
let bridge = box_centered(6.0, bw + 6.0, 2.0).translate([-a * 0.55, 0, -6.0]);
let legs = [];
for s in [-1.0, 1.0] {
    legs.push(box_centered(6.0, 3.0, 6.0).translate([-a * 0.55, s * (bw / 2.0 + 1.5), -3.0 + 0.1]));
}
let stud = cylinder([a * 0.55, 0, -6.0], "Z", 3.0, 6.2) + cylinder([a * 0.55, 0, -8.0], "Z", 4.5, 2.0).chamfer(0.6, "%CIRCLE and <Z");
fuse_all([plate, raised, bridge, legs[0], legs[1], stud])
