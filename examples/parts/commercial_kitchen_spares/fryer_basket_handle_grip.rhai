// Fryer basket handle grip: 120 mm heat-resistant sleeve, 28 mm diameter with four 1.5 mm finger grooves, 10.5 mm bore for the basket's 10 mm handle wire and 2 mm end chamfers
let length = 120.0; // [80.0, 160.0] Grip length (mm)
let dia = 28.0; // [22.0, 36.0] Grip diameter (mm)
let wire = 10.5; // [8.0, 14.0] Handle wire bore (mm)
let grooves = 4; // [2, 6] Number of finger grooves
let r = dia / 2.0;
let pts = [[wire / 2.0, 0], [r - 2.0, 0], [r, 2.0]];
let pitch = min(22.0, (length - 20.0) / grooves.to_float());
let z0 = length / 2.0 - pitch * (grooves.to_float() - 1.0) / 2.0;
for i in 0..grooves {
    let z = z0 + i.to_float() * pitch;
    pts.push([r, z - 4.0]);
    pts.push([r - 1.5, z]);
    pts.push([r, z + 4.0]);
}
pts.push([r, length - 2.0]);
pts.push([r - 2.0, length]);
pts.push([wire / 2.0, length]);
face(polygon(pts.map(|p| [p[0], 0, p[1]]))).revolve("Z", 360).rotate_y(90.0)
