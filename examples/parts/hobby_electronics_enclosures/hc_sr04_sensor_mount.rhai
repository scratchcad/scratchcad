// HC-SR04 ultrasonic sensor front mount: 45 x 20 mm board with two 16 mm transducers on 26 mm centres, 52 x 26 x 2 mm face with 16.6 mm holes, 2 board clips holding the PCB 10 mm behind the face, 25 mm L-foot with 3.2 x 8 mm adjustment slot
let face_w = 52.0; // [47.0, 70.0] Face width (mm)
let face_h = 26.0; // [22.0, 40.0] Face height (mm)
let thick = 2.0; // [1.5, 3.5] Face thickness (mm)
let eye = 16.6; // [16.0, 18.0] Transducer hole (mm)
let centres = 26.0; // [24.0, 28.0] Transducer centres (mm)
let foot = 25.0; // [15.0, 40.0] Foot depth (mm)
const board_w = 45.0;
const board_h = 20.0;
const can = 10.0;
let fw = max(face_w, board_w + 4.0);
let fh = max(face_h, board_h + 4.0);
let face = box_from_corners([-fw / 2.0, 0, 0], [fw / 2.0, thick, fh]);
let parts = [face];
let z0 = fh / 2.0;
for s in [-1.0, 1.0] {
    let x = s * (board_w / 2.0 + 0.2);
    let xo = s * fw / 2.0;
    let yb = thick + can;
    parts.push(box_from_corners([min(x, xo), thick - 0.5, z0 - 4.0], [max(x, xo), yb + 3.0, z0 + 4.0]));
    parts.push(box_from_corners([min(x, x - s * 1.5), thick - 0.5, z0 - 4.0], [max(x, x - s * 1.5), yb, z0 + 4.0]));
    parts.push(polygon([[x, yb + 1.6, z0 - 4.0], [x, yb + 3.0, z0 - 4.0], [x - s * 0.6, yb + 3.0, z0 - 4.0]]).to_face().extrude([0, 0, 8.0]));
}
let ft = box_from_corners([-fw / 2.0, 0, 0], [fw / 2.0, foot, thick]);
parts.push(ft);
parts.push(polygon([[-thick / 2.0, thick - 0.5, thick - 0.5], [-thick / 2.0, foot * 0.6, thick - 0.5], [-thick / 2.0, thick - 0.5, fh * 0.45]]).to_face().extrude([thick, 0, 0]).translate([-fw / 2.0 + thick / 2.0 + 0.0, 0, 0]));
parts.push(polygon([[-thick / 2.0, thick - 0.5, thick - 0.5], [-thick / 2.0, foot * 0.6, thick - 0.5], [-thick / 2.0, thick - 0.5, fh * 0.45]]).to_face().extrude([thick, 0, 0]).translate([fw / 2.0 - thick / 2.0, 0, 0]));
let c = min(centres, fw - eye - 3.0);
let cuts = [cylinder([-c / 2.0, -1, z0], "Y", eye / 2.0, thick + 2.0), cylinder([c / 2.0, -1, z0], "Y", eye / 2.0, thick + 2.0)];
let sy = (thick + foot) / 2.0 + 2.0;
cuts.push(box_centered(3.2, 8.0 - 3.2, thick + 2.0).translate([0, sy, thick / 2.0]) + cylinder([0, sy - 2.4, -1], "Z", 1.6, thick + 2.0) + cylinder([0, sy + 2.4, -1], "Z", 1.6, thick + 2.0));
fuse_all(parts) - compound(cuts)
