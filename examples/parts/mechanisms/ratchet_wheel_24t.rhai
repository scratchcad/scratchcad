// Ratchet wheel, 24 teeth: 50 mm tip, 4 mm tooth depth, 6 mm thick, 8 mm bore with 3 mm key
let teeth = 24; // [12, 48] Tooth count
let od = 50.0; // [30.0, 100.0] Tip diameter (mm)
let depth = 4.0; // [2.0, 8.0] Tooth depth (mm)
let thickness = 6.0; // [3.0, 12.0] Thickness (mm)
let bore = 8.0; // [5.0, 20.0] Bore (mm)
let ro = od / 2.0;
let ri = ro - depth;
let pts = [];
for i in 0..teeth {
    let a0 = i.to_float() * 2.0 * PI() / teeth.to_float();
    let a1 = (i.to_float() + 1.0) * 2.0 * PI() / teeth.to_float();
    pts.push([ri * a0.cos(), ri * a0.sin()]);
    pts.push([ro * a1.cos(), ro * a1.sin()]);
}
let w = polygon(pts).to_face().extrude([0, 0, thickness]);
w - cylinder([0, 0, -1], "Z", bore / 2.0, thickness + 2.0) - box_from_corners([bore / 2.0 - 1.0, -1.5, -1], [bore / 2.0 + 1.5, 1.5, thickness + 1.0])
