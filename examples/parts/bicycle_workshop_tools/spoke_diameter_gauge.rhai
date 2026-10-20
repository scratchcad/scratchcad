// Spoke and wire diameter gauge: 80 x 30 x 2 mm stainless plate with 4 mm corner radii, five go holes of 1.6, 1.8, 2.0, 2.3 and 2.6 mm in a row 12 mm apart, and a 5 mm hang hole
let length = 80.0; // [65.0, 110.0] Plate length (mm)
let width = 30.0; // [22.0, 40.0] Plate width (mm)
let thickness = 2.0; // [1.0, 3.0] Plate thickness (mm)
let pitch = 12.0; // [9.0, 16.0] Hole spacing (mm)
let plate = box_from_corners([0, 0, 0], [length, width, thickness]);
let plate = plate.fillet(4.0, plate.edges("|Z"));
let step = min(pitch, (length - 26.0) / 4.0);
let sizes = [1.6, 1.8, 2.0, 2.3, 2.6];
let holes = [];
for i in 0..5 {
    holes.push(cylinder([10.0 + i.to_float() * step, width / 2.0, -1.0], "Z", sizes[i] / 2.0, thickness + 2.0));
}
holes.push(cylinder([length - 8.0, width / 2.0, -1.0], "Z", 2.5, thickness + 2.0));
plate - fuse_all(holes)
