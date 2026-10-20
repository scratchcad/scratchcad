// Gear shift knob: 52 mm ball with a flat top engraved with a 6-speed H pattern, tapered 24-34 mm neck, M12x1.25 bore 25 mm deep
let d = 52.0; // [45.0, 60.0] Ball diameter (mm)
let r = d / 2.0;
let zc = 40.0; // [32.0, 60.0] Ball centre height (mm)
let knob = sphere([0, 0, zc], r) + cone(12.0, 17.0, zc - 10.0);
let top = zc + r - 4.0;
knob -= box_centered(80.0, 80.0, 20.0).translate([0, 0, top + 10.0]);
let grooves = fuse_all([
    box_centered(1.2, 14.0, 2.0).translate([-7.0, 0, top]),
    box_centered(1.2, 14.0, 2.0).translate([0, 0, top]),
    box_centered(1.2, 14.0, 2.0).translate([7.0, 0, top]),
    box_centered(15.2, 1.2, 2.0).translate([0, 0, top])
]);
knob - grooves.translate([0, 0, 0.2]) - cylinder([0, 0, -1], "Z", 5.3, 26.0)
