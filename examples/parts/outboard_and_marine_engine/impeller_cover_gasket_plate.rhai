// Outboard water pump wear plate under the impeller: 1.5 mm stainless plate, 62 mm round with two 14 mm wide ears carrying M6 bolt holes (6.5 mm) 76 mm apart, 16 mm drive shaft hole, two 4 mm water inlet slots 18 mm long at 22 mm radius, and a 4 mm locating pin hole
let plate_d = 62.0; // [45.0, 80.0] Plate diameter (mm)
let bolt_spacing = 76.0; // [60.0, 100.0] Bolt hole spacing (mm)
let thickness = 1.5; // [0.8, 3.0] Plate thickness (mm)
let shaft_hole = 16.0; // [10.0, 22.0] Drive shaft hole (mm)
let r = plate_d / 2.0;
let bs = max(bolt_spacing, plate_d + 4.0);
let ears = box_centered(bs, 14.0, thickness).translate([0, 0, thickness / 2.0]) + cylinder([-bs / 2.0, 0, 0], "Z", 7.0, thickness) + cylinder([bs / 2.0, 0, 0], "Z", 7.0, thickness);
let plate = cylinder([0, 0, 0], "Z", r, thickness) + ears;
let rs = (shaft_hole / 2.0 + r) / 2.0 + 1.0;
let cuts = [
    cylinder([0, 0, -1.0], "Z", shaft_hole / 2.0, thickness + 2.0),
    cylinder([-bs / 2.0, 0, -1.0], "Z", 3.25, thickness + 2.0),
    cylinder([bs / 2.0, 0, -1.0], "Z", 3.25, thickness + 2.0),
    cylinder([rs * cos(150.0 * PI() / 180.0), rs * sin(150.0 * PI() / 180.0), -1.0], "Z", 2.0, thickness + 2.0)
];
for a in [60.0, 240.0] {
    let slot = box_centered(4.0, 14.0, thickness + 2.0).translate([rs, 0, thickness / 2.0]) + cylinder([rs, -7.0, -1.0], "Z", 2.0, thickness + 2.0) + cylinder([rs, 7.0, -1.0], "Z", 2.0, thickness + 2.0);
    cuts.push(slot.rotate_z(a));
}
plate - fuse_all(cuts)
