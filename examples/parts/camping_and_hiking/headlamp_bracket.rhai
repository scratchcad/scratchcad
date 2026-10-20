// Headlamp tilt bracket: 50 mm wide strap plate for 25 mm elastic, two 5 mm detent hinge ears
let strap = 25.0; // [18.0, 40.0] Strap width (mm)
let width = 50.0; // [35.0, 70.0] Plate width (mm)
let thickness = 2.5; // [1.5, 4.0] Plate thickness (mm)
let plate = box_centered(width, strap + 8.0, thickness).translate([0, 0, thickness / 2.0]);
let p = plate.fillet(4.0, plate.edges("|Z"));
let slots = box_centered(3.0, strap + 1.0, 10.0).translate([width / 2.0 - 5.0, 0, 0]) + box_centered(3.0, strap + 1.0, 10.0).translate([-width / 2.0 + 5.0, 0, 0]);
let ears = [];
for s in [-1.0, 1.0] {
    let ear = box_from_corners([s * 12.0 - 1.5, -5.0, thickness - 0.01], [s * 12.0 + 1.5, 5.0, 10.0]) + cylinder([s * 12.0 - 1.5, 0, 10.0], "X", 5.0, 3.0);
    ears.push(ear - cylinder([s * 12.0 - 3.0, 0, 10.0], "X", 1.5, 6.0));
}
p - slots + fuse_all(ears)
