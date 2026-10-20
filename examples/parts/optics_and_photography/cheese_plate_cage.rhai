// Camera cage cheese plate: 100 x 60 x 6 mm aluminium, 3/8-16 holes on a 20 mm grid with 1/4-20 holes between them (tap drill sizes), two 6.5 mm slots, 3 mm corner radii
let length = 100.0; // [60.0, 200.0] Plate length (mm)
let width = 60.0; // [52.8, 96.0] Plate width (mm)
let thickness = 6.0; // [4.0, 10.0] Plate thickness (mm)
let grid = 20.0; // [17.0, 30.0] Hole grid pitch (mm)
let corner_radius = 3.0; // [1.5, 8.0] Corner radius (mm)
let plate = box_centered(length, width, thickness).translate([0, 0, thickness / 2.0]).fillet(corner_radius, "|Z").chamfer(0.5, ">Z or <Z");
let nx = ((length - 10.0) / grid).floor().to_int() + 1;
let ny = ((width - 10.0) / grid).floor().to_int() + 1;
let x0 = -(nx - 1).to_float() * grid / 2.0;
let y0 = -(ny - 1).to_float() * grid / 2.0;
let holes = [];
for i in 0..nx {
    for j in 0..ny {
        let x = x0 + i.to_float() * grid;
        let y = y0 + j.to_float() * grid;
        // keep the middle row free for the slots
        if j * 2 + 1 != ny { holes.push(cylinder([x, y, -1.0], "Z", 4.2, thickness + 2.0)); }
        if i + 1 < nx && j + 1 < ny { holes.push(cylinder([x + grid / 2.0, y + grid / 2.0, -1.0], "Z", 2.55, thickness + 2.0)); }
    }
}
// two slots along the centre line
let sl = length * 0.3;
for s in [-1.0, 1.0] {
    let cx = s * length * 0.25;
    holes.push(box_centered(sl - 6.5, 6.5, thickness + 2.0).translate([cx, 0, thickness / 2.0]) + cylinder([cx - sl / 2.0 + 3.25, 0, -1], "Z", 3.25, thickness + 2.0) + cylinder([cx + sl / 2.0 - 3.25, 0, -1], "Z", 3.25, thickness + 2.0));
}
plate - compound(holes)
