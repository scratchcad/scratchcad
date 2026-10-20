// Triangular ergonomic pen and pencil grip: 40 mm long, 18 mm across the flats, rounded corners, 7.5 mm bore, finger dimples on each face
let length = 40.0; // [25.0, 60.0] Grip length (mm)
let across = 18.0; // [12.0, 26.0] Size across a face to the opposite corner (mm)
let bore = 7.5; // [6.0, 11.0] Bore diameter (mm)
let rc = across / 1.15;
let pts = [];
for i in 0..3 {
    let a = (90.0 + i.to_float() * 120.0) * PI() / 180.0;
    pts.push([rc * a.cos(), rc * a.sin()]);
}
let grip = polygon(pts).to_face().extrude(length).fillet(rc * 0.35, "|Z").fillet(1.5, ">Z or <Z");
let dimples = [];
for i in 0..3 {
    let a = (270.0 + i.to_float() * 120.0) * PI() / 180.0;
    let d = rc / 2.0 + 6.0;
    dimples.push(sphere([d * a.cos(), d * a.sin(), length * 0.55], 7.0));
}
grip - compound(dimples) - cylinder([0, 0, -1.0], "Z", bore / 2.0, length + 2.0)
