// Snail drop cam: base radius 15 mm rising 12 mm over 330 degrees then dropping, 8 mm thick, 6 mm bore
let base_r = 15.0; // [8.0, 30.0] Base radius (mm)
let rise = 12.0; // [4.0, 25.0] Rise (mm)
let thickness = 8.0; // [4.0, 15.0] Thickness (mm)
let bore = 6.0; // [3.0, 12.0] Bore (mm)
let pts = [];
for i in 0..=33 {
    let deg = i.to_float() * 10.0;
    let a = deg * PI() / 180.0;
    let r = base_r + rise * deg / 330.0;
    pts.push([r * a.cos(), r * a.sin()]);
}
pts.push([base_r * (330.0 * PI() / 180.0).cos(), base_r * (330.0 * PI() / 180.0).sin()]);
let cam = polygon(pts).to_face().extrude([0, 0, thickness]);
cam - cylinder([0, 0, -1], "Z", bore / 2.0, thickness + 2.0)
