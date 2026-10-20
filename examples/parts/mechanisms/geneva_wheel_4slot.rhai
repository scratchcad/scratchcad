// Geneva wheel, 4 slots: 48 mm wheel driven by a 21.2 mm crank at 30 mm centers, 6 mm pin, 8 mm thick, 8 mm bore
let crank = 21.2; // [10.0, 40.0] Driver crank radius (mm)
let pin = 6.0; // [3.0, 10.0] Drive pin diameter (mm)
let thickness = 8.0; // [4.0, 15.0] Thickness (mm)
let bore = 8.0; // [4.0, 15.0] Bore (mm)
let c = crank * 2.0.sqrt();
let wheel_r = (c * c - crank * crank).sqrt() + pin / 2.0;
let lock_r = crank - pin;
let wheel = cylinder(wheel_r, thickness);
let slots = [];
let reliefs = [];
for k in 0..4 {
    slots.push(box_from_corners([c - crank - pin / 2.0 - 0.5, -pin / 2.0 - 0.2, -1], [wheel_r + 1.0, pin / 2.0 + 0.2, thickness + 1.0]).rotate_z(k.to_float() * 90.0));
    reliefs.push(cylinder([c, 0, -1], "Z", lock_r + 0.3, thickness + 2.0).rotate_z(k.to_float() * 90.0 + 45.0));
}
wheel - fuse_all(slots) - fuse_all(reliefs) - cylinder([0, 0, -1], "Z", bore / 2.0, thickness + 2.0)
