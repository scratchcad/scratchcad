// Ratchet wheel with 24 saw teeth (50 mm OD, 6 mm thick, 10 mm bore) and its pawl on a 4 mm pivot
let teeth = 24; // [8, 60] Teeth
let outer_d = 50.0; // [20.0, 120.0] Outside diameter (mm)
let depth = 3.0; // [1.0, 8.0] Tooth depth (mm)
let thickness = 6.0; // [3.0, 15.0] Thickness (mm)
let bore = 10.0; // [4.0, 25.0] Bore (mm)
let r = outer_d / 2.0;
let pts = [];
for i in 0..teeth {
    let a0 = i.to_float() * 2.0 * PI() / teeth.to_float();
    let a1 = (i.to_float() + 1.0) * 2.0 * PI() / teeth.to_float();
    pts.push([r * a0.cos(), r * a0.sin()]);
    pts.push([(r - depth) * a1.cos(), (r - depth) * a1.sin()]);
}
let wheel = polygon(pts).to_face().extrude(thickness) - cylinder([0, 0, -1], "Z", bore / 2.0, thickness + 2.0);
let pivot = [r + 8.0, r * 0.5, 0.0];
let tip_a = 0.35;
let pawl = (sketch("XY").move_to(pivot[0] - 3.0, pivot[1]).line_to(r * 0.97 * tip_a.cos() + 0.5, r * 0.97 * tip_a.sin()).line_to(pivot[0] + 3.0, pivot[1] + 3.0).close().to_face().extrude(thickness) + cylinder(pivot, "Z", 4.0, thickness)) - cylinder([pivot[0], pivot[1], -1], "Z", 2.0, thickness + 2.0);
[wheel, pawl]
