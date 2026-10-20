// Octagonal rasp / file handle: 120 mm long, 30 mm across flats, 26 mm ferrule seat 15 mm long, 6 mm tang hole 60 mm deep, chamfered butt
let length = 120.0; // [90.0, 160.0] Handle length (mm)
let flats = 30.0; // [22.0, 40.0] Across flats (mm)
let ferrule_d = 26.0; // [18.0, 34.0] Ferrule seat diameter (mm)
let tang_d = 6.0; // [3.0, 10.0] Tang hole diameter (mm)
let tang_depth = 60.0; // [30.0, 90.0] Tang hole depth (mm)
let rc = flats / 2.0 / (22.5 * PI() / 180.0).cos();
let pts = [];
for i in 0..8 {
    let a = (i.to_float() * 45.0 + 22.5) * PI() / 180.0;
    pts.push([rc * a.cos(), rc * a.sin(), 14.0]);
}
let oct = polygon(pts).to_face().extrude([0, 0, length - 14.0]);
let o = oct.chamfer(3.0, oct.edges(">Z"));
let seat = cylinder([0, 0, 0], "Z", ferrule_d / 2.0, 15.0);
o + seat - cylinder([0, 0, -1], "Z", tang_d / 2.0, tang_depth + 1.0)
