// Meat slicer thickness gauge knob: 60 mm eight-lobed knob 26 mm tall on a 34 mm hub, M8 nut pocket (13 mm across flats, 6.5 mm deep) in the base and an 8.5 mm through bore
let dia = 60.0; // [45.0, 80.0] Knob diameter (mm)
let height = 26.0; // [18.0, 35.0] Knob height (mm)
let lobes = 8; // [5, 12] Number of lobes
const nut_af = 13.0;
const nut_depth = 6.5;
let r = dia / 2.0;
let knob = cylinder([0, 0, 0], "Z", r, height * 0.6) + cylinder([0, 0, height * 0.6 - 0.01], "Z", 17.0, height * 0.4 + 0.01);
let scallops = [];
for i in 0..lobes {
    scallops.push(cylinder([r + 2.0, 0, -1.0], "Z", 6.0, height * 0.6 + 2.0).rotate_z(i.to_float() * 360.0 / lobes.to_float()));
}
knob = knob - compound(scallops);
let rh = nut_af / 2.0 / cos(30.0 * PI() / 180.0) + 0.1;
let hex = [];
for i in 0..6 {
    let a = i.to_float() * 60.0 * PI() / 180.0;
    hex.push([rh * cos(a), rh * sin(a), -1.0]);
}
knob - face(polygon(hex)).extrude([0, 0, nut_depth + 1.0]) - cylinder([0, 0, -1.0], "Z", 4.25, height + 2.0)
