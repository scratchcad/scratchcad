// Hexagonal pot trivet: 180 mm across the corners, 10 mm thick, honeycomb of 26 mm hexagonal openings on a 30 mm pitch, four 6 mm silicone-foot recesses underneath
let size = 180.0; // [120.0, 260.0] Size across the corners (mm)
let thickness = 10.0; // [6.0, 16.0] Thickness (mm)
let cell = 26.0; // [15.0, 40.0] Opening size across the flats (mm)
let rib = 4.0; // [3.0, 8.0] Rib width between openings (mm)
let rim = 10.0; // [6.0, 20.0] Solid rim width (mm)
fn hexagon(r, rot) {
    let pts = [];
    for i in 0..6 { let a = (i.to_float() * 60.0 + rot) * PI() / 180.0; pts.push([r * a.cos(), r * a.sin()]); }
    polygon(pts)
}
let ro = size / 2.0;
let trivet = face(hexagon(ro, 0.0)).extrude([0, 0, thickness]).fillet(6.0, "|Z").chamfer(1.0, ">Z or <Z");
// honeycomb openings, kept inside the rim
let pitch = cell + rib;
let rc = cell / sqrt(3.0);
let limit = (ro - rim) * sqrt(3.0) / 2.0 - cell / 2.0;
let cells = [];
for i in -4..=4 {
    for j in -4..=4 {
        let x = pitch * (i.to_float() + j.to_float() * 0.5);
        let y = pitch * j.to_float() * sqrt(3.0) / 2.0;
        // inside the outer hexagon's inscribed circle less the rim
        if sqrt(x * x + y * y) <= limit {
            cells.push(face(hexagon(rc, 30.0)).extrude([0, 0, thickness + 2.0]).translate([x, y, -1.0]));
        }
    }
}
print(`${cells.len()} openings`);
trivet = trivet - compound(cells);
for a in [0.0, 90.0, 180.0, 270.0] {
    trivet -= cylinder([ro * 0.72, 0, -1.0], "Z", 3.0, 2.5).rotate_z(a + 45.0);
}
trivet
