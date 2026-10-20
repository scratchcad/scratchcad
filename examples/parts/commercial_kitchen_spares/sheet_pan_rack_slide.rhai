// Bun pan rack angle slide: 25 x 25 x 2 mm angle 450 mm long for full-size 18 x 26 in sheet pans, 30 degree lead-in at the front and two 5 mm rivet holes at each end
let length = 450.0; // [300.0, 700.0] Slide length (mm)
let leg = 25.0; // [15.0, 40.0] Angle leg (mm)
let t = 2.0; // [1.5, 3.0] Material thickness (mm)
let angle = fuse_all([
    box_from_corners([0, 0, 0], [length, t, leg]),
    box_from_corners([0, 0, 0], [length, leg, t]),
]);
let lead = face(polygon([[-1.0, t + 0.5, -1.0], [-1.0, leg + 1.0, -1.0], [leg * 0.6, leg + 1.0, -1.0]])).extrude([0, 0, t + 2.0]);
angle = angle - lead;
let holes = [];
for x in [15.0, 40.0, length - 40.0, length - 15.0] {
    holes.push(cylinder([x, -1.0, leg / 2.0 + 1.0], "Y", 2.5, t + 2.0));
}
angle - compound(holes)
