// Gear rack module 2, 100 mm long, 20 x 20 mm section, teeth on top, 2 x M5 mounting holes
let gear_module = 2.0; // [0.5, 4.0] Module (mm)
let length = 100.0; // [30.0, 300.0] Length (mm)
let width = 20.0; // [6.0, 40.0] Face width (mm)
let height = 20.0; // [8.0, 40.0] Height to pitch line (mm)
let p = gear_module * PI();
let addendum = gear_module;
let dedendum = 1.25 * gear_module;
let tan20 = (20.0 * PI() / 180.0).tan();
let pts = [[0.0, 0.0], [length, 0.0], [length, height - dedendum]];
let n = (length / p).floor().to_int();
let x = length;
for i in 0..n {
    let x0 = length - (i.to_float() + 1.0) * p;
    let c = x0 + p / 2.0;
    pts.push([c + p / 4.0 + dedendum * tan20, height - dedendum]);
    pts.push([c + p / 4.0 - addendum * tan20, height + addendum]);
    pts.push([c - p / 4.0 + addendum * tan20, height + addendum]);
    pts.push([c - p / 4.0 - dedendum * tan20, height - dedendum]);
}
pts.push([0.0, height - dedendum]);
let rack = polygon("XZ", pts).to_face().extrude([0, width, 0]);
rack - cylinder([length * 0.25, width / 2.0, -1], "Z", 2.75, height) - cylinder([length * 0.75, width / 2.0, -1], "Z", 2.75, height)
