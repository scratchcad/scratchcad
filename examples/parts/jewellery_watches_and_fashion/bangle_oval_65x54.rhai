// Oval bangle bracelet, 65 x 54 mm inside (medium hand), 6 mm wide D-section 3 mm thick with a flat comfort inside
let inside_width = 65.0; // [55.0, 75.0] Inside width (mm)
let inside_height = 54.0; // [45.0, 65.0] Inside height (mm)
let band_width = 6.0; // [3.0, 15.0] Band width (mm)
let thickness = 3.0; // [1.5, 5.0] Band thickness (mm)
let a = inside_width / 2.0;
let b = min(inside_height, inside_width) / 2.0;
let pts = [];
for i in 0..48 {
    let t = i.to_float() * 2.0 * PI() / 48.0;
    pts.push([a * t.cos(), b * t.sin(), 0]);
}
let path = wire([spline(pts, true)]);
// D-section at the path's start (a, 0, 0), where the path runs along +Y
let section = sketch("XZ").move_to(a, -band_width / 2.0).arc_to(a + thickness, 0, a, band_width / 2.0).close();
section.to_face().sweep(path)
