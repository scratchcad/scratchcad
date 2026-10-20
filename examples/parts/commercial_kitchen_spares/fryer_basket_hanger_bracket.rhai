// Deep fryer basket hanger bracket: 60 mm tall x 40 mm wide stainless plate 3 mm thick with two 5 mm screw holes, a 20 mm shelf and a 12 mm upturned lip that holds the basket's 6 mm wire hook
let height = 60.0; // [40.0, 90.0] Back plate height (mm)
let width = 40.0; // [25.0, 60.0] Bracket width (mm)
let shelf = 20.0; // [12.0, 30.0] Shelf depth (mm)
let lip = 12.0; // [6.0, 20.0] Lip height (mm)
const t = 3.0;
let b = fuse_all([
    box_from_corners([0, 0, 0], [t, width, height]),
    box_from_corners([0, 0, 0], [shelf + t, width, t]),
    box_from_corners([shelf, 0, 0], [shelf + t, width, lip]),
]);
let holes = [];
for z in [height * 0.45, height * 0.8] {
    holes.push(cylinder([-1.0, width / 2.0, z], "X", 2.5, t + 2.0));
}
b - compound(holes)
