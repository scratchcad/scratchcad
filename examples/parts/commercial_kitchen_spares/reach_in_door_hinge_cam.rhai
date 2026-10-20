// Reach-in refrigerator self-closing hinge cam: 25 mm nylon cam 18 mm tall on a 10 mm hinge pin with two 6 mm deep V detents at 0 and 90 degrees that pull the door shut, and a 6 x 3 mm anti-rotation key
let dia = 25.0; // [18.0, 32.0] Cam diameter (mm)
let height = 18.0; // [12.0, 25.0] Cam height (mm)
let pin_d = 10.0; // [6.0, 12.0] Hinge pin diameter (mm)
let detent = 6.0; // [3.0, 8.0] Detent depth (mm)
let cam = cylinder([0, 0, 0], "Z", dia / 2.0, height);
let vs = [];
for a in [0.0, 90.0] {
    let v = face(polygon([[-detent, 0, height + 0.01], [detent, 0, height + 0.01], [0, 0, height - detent]])).extrude([0, dia, 0]).translate([0, -dia / 2.0, 0]);
    vs.push(v.translate([0, 0, 0.5]).rotate_z(a));
}
cam = cam - fuse_all(vs);
cam = cam - cylinder([0, 0, -1.0], "Z", pin_d / 2.0 + 0.1, height + 2.0);
cam + box_from_corners([-1.5, -pin_d / 2.0 - 0.5, 0], [1.5, -pin_d / 2.0 + 2.5, 6.0])
